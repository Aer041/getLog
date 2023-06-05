FROM debian:bullseye-20220125-slim AS builder

ARG TARGETPLATFORM

ENV FIRMWARE_DIR /root/AerOS-getLog
ENV INSTALL_DIR /usr/lib/tmp

# Install dependencies
RUN apt-get update \
    && apt-get -y --quiet --no-install-recommends install \
        build-essential \
        cmake \
        sudo \ 
        wget \
        git \
        ca-certificates \
    && apt-get -y autoremove \
    && apt-get clean autoclean \
    && rm -rf /var/lib/apt/lists/{apt,dpkg,cache,log} /tmp/* /var/tmp/*

# Install MAVSDK prebuilt C++ library
ENV MAVSDK_VERSION=1.4.13
RUN if [ "$TARGETPLATFORM" = "linux/amd64" ]; then \
        MAVSDK_PKG=ubuntu20.04_amd64; \
    elif [ "$TARGETPLATFORM" = "linux/arm/v7" ]; then \
        MAVSDK_PKG=debian11_armv6; \
    elif [ "$TARGETPLATFORM" = "linux/arm64" ]; then \
        MAVSDK_PKG=debian11_arm64; \    
    else \
        echo "$TARGETPLATFORM is not supported"; false; \
    fi \
    && wget https://github.com/mavlink/MAVSDK/releases/download/v${MAVSDK_VERSION}/libmavsdk-dev_${MAVSDK_VERSION}_${MAVSDK_PKG}.deb \
    && sudo dpkg -i libmavsdk-dev_${MAVSDK_VERSION}_${MAVSDK_PKG}.deb \
    && sudo rm libmavsdk-dev_${MAVSDK_VERSION}_${MAVSDK_PKG}.deb

# Build AerOS getLog code
COPY . ${FIRMWARE_DIR}
RUN cd ${FIRMWARE_DIR}; \
    cmake -Bbuild .; \
    cmake --build build; \
    cp ${FIRMWARE_DIR}/build/download_log_auto .;

# Huge hack because no way to assign directly INSTALL DIR
# based on the target platform. So we copy to a temp folder so
# the runtime docker can pick the required libraries
RUN if [ "$TARGETPLATFORM" = "linux/amd64" ]; then \
        cp -r /usr/lib/x86_64-linux-gnu ${INSTALL_DIR} ; \
    elif [ "$TARGETPLATFORM" = "linux/arm/v7" ]; then \
        cp -r /usr/lib/arm-linux-gnueabihf ${INSTALL_DIR} ; \
    elif [ "$TARGETPLATFORM" = "linux/arm64" ]; then \
        cp -r /usr/lib/aarch64-linux-gnu ${INSTALL_DIR} ; \
    else \
        echo "Target $TARGETPLATFORM is not supported"; false; \
    fi;

#---------------------------------------

FROM debian:bullseye-20220125-slim AS runtime

ARG TARGETPLATFORM

ENV FIRMWARE_DIR /root/AerOS-getLog
ENV INSTALL_DIR /usr/lib/tmp

# Copy MAVSDK shared library
COPY --from=builder /usr/lib/libmavsdk* /usr/lib/

WORKDIR ${FIRMWARE_DIR}

# Copy application executable
COPY --from=builder ${FIRMWARE_DIR}/download_log_auto* ${FIRMWARE_DIR}/

COPY entrypoint.sh /root/entrypoint.sh
RUN chmod +x /root/entrypoint.sh

# Run the AerOS software when running the docker
ENTRYPOINT ["/root/entrypoint.sh"]