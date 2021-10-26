cmake_minimum_required(VERSION 3.10.2)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

project(terminal_menu_dirent)

add_executable(terminal_menu_dirent
    terminal_menu_dirent.cpp
)

find_package(MAVSDK REQUIRED)

target_link_libraries(terminal_menu_dirent
    MAVSDK::mavsdk_telemetry
    MAVSDK::mavsdk_action
    MAVSDK::mavsdk_log_files
    MAVSDK::mavsdk
    stdc++fs
)

if(NOT MSVC)
    add_compile_options(terminal_menu_dirent PRIVATE -Wall -Wextra)
else()
    add_compile_options(terminal_menu_dirent PRIVATE -WX -W2)
endif()
