cmake_minimum_required(VERSION 3.10.2)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

project(end_download)

add_executable(end_download
    end_download.cpp
)

find_package(MAVSDK REQUIRED)

target_link_libraries(end_download
    MAVSDK::mavsdk_telemetry
    MAVSDK::mavsdk_action
    MAVSDK::mavsdk_log_files
    MAVSDK::mavsdk
)

if(NOT MSVC)
    add_compile_options(end_download PRIVATE -Wall -Wextra)
else()
    add_compile_options(end_download PRIVATE -WX -W2)
endif()
