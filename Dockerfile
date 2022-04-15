# Build Stage
FROM ubuntu:20.04 as builder

## Install build dependencies.
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y cmake clang

## Add source code to the build stage.
ADD . /mayhem-cmake-example
WORKDIR /mayhem-cmake-example

RUN mkdir build
RUN cd build && CC=clang CXX=clang++ cmake ..
RUN cd build && make

# Package Stage
FROM ubuntu:20.04

## TODO: Change <Path in Builder Stage>
COPY --from=builder /mayhem-cmake-example/build/fuzzme /

