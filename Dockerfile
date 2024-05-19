FROM --platform=linux/amd64 ubuntu:22.04

RUN apt-get update && apt-get install -y \
    wget \
    xz-utils \
    make \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app/tmp/

ENV ARM_GCC_VERSION 13.2.rel1
ENV ARM_GCC_BASE_URL https://developer.arm.com/-/media/Files/downloads/gnu/13.2.rel1/binrel

RUN wget -O arm-gnu-toolchain.tar.xz ${ARM_GCC_BASE_URL}/arm-gnu-toolchain-${ARM_GCC_VERSION}-x86_64-arm-none-eabi.tar.xz \
    && mkdir -p /opt/arm-gnu-toolchain \
    && tar -xvf arm-gnu-toolchain.tar.xz \
    && mv */* /opt/arm-gnu-toolchain \
    && rm -rf /app/tmp

ENV PATH=/opt/arm-gnu-toolchain/bin:$PATH

COPY sdk /sdk

WORKDIR /app

CMD ["make"]
