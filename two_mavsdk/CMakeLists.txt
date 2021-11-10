cmake_minimum_required(VERSION 3.10.2)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

project(two_mavsdk)

add_executable(two_mavsdk
    two_mavsdk.cpp
)

find_package(MAVSDK REQUIRED)

target_link_libraries(two_mavsdk
    MAVSDK::mavsdk_telemetry
    MAVSDK::mavsdk_action
    MAVSDK::mavsdk_log_files
    MAVSDK::mavsdk
    stdc++fs
)

if(NOT MSVC)
    add_compile_options(two_mavsdk PRIVATE -Wall -Wextra)
else()
    add_compile_options(two_mavsdk PRIVATE -WX -W2)
endif()
