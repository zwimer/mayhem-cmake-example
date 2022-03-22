cmake_minimum_required(VERSION 3.16)
project(mayhem-cmake-example)

if (NOT CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
    message(FATAL_ERROR "Clang is required for libFuzzer!")
endif()

add_executable(fuzzme fuzzme.c)
target_compile_options(fuzzme PUBLIC -fsanitize=fuzzer)
target_link_options(fuzzme PUBLIC -fsanitize=fuzzer)
