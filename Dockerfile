# Build Stage
FROM ubuntu:20.04 as builder

## Install build dependencies.
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y cmake clang

## Add source code to the build stage.
ADD . /mayhem-cmake-example
WORKDIR /mayhem-cmake-example

## Build
RUN mkdir build
WORKDIR /mayhem-cmake-example/build
RUN CC=clang CXX=clang++ cmake .. && make -j$(grep -c ^processor /proc/cpuinfo)

# Package Stage
FROM ubuntu:20.04

## Copy libFuzzer binary into final image.
COPY --from=builder /mayhem-cmake-example/build/fuzzme /

