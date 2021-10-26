cmake_minimum_required(VERSION 3.10.2)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

project(download_log_auto)

add_executable(download_log_auto
    download_log_auto.cpp
)

find_package(MAVSDK REQUIRED)

target_link_libraries(download_log_auto
    MAVSDK::mavsdk_telemetry
    MAVSDK::mavsdk_action
    MAVSDK::mavsdk_log_files
    MAVSDK::mavsdk
    stdc++fs
)

if(NOT MSVC)
    add_compile_options(download_log_auto PRIVATE -Wall -Wextra)
else()
    add_compile_options(download_log_auto PRIVATE -WX -W2)
endif()
