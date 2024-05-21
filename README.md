# S32K1XX Docker Toolchain

This repository provides a Docker embedded toolchain for NXP S32K1XX projects, allowing
you to build your projects without relying on S32 Design Studio software. It
also includes a "Hello World" project example (S32K144 EVB) with a Makefile
compatible with this Docker toolchain.

## Prerequisites

Before using this Docker toolchain, make sure you have the following installed
on your machine:

- [Docker](https://www.docker.com/)
- [SDK for S32K1XX](https://www.nxp.com/design/design-center/software/development-software/s32-sdk/s32-software-development-kit-for-s32k1:S32SDK-ARMK1): You need to download the SDK for S32K1XX microcontrollers
  from the NXP website and extract its contents into the  `sdk/` directory of this
  repository. Make sure the SDK is accessible in the `sdk/` path of the repository
  before building the docker image.

## Installation

Build the Docker image:

```bash
docker build -t s32k1xx-toolchain .
```

Once the image is built, it includes the SDK (in `/sdk/`) as well as the entire
ARM GCC embedded toolchain. You can use it for all projects using S32K1XX MCUs.

## Example

In the `hello_world/` directory, you will find code for S32K144 EVB that lights up
a single LED with a complete Makefile serving as a template.

By default, the Docker image runs the `make` command in the `/app/` directory.

```bash
docker run --rm -v ./hello_world:/app/ s32k1xx-toolchain
```

For MacOS Apple Silicon

```bash
docker run --rm --platform linux/amd64 -v ./hello_world:/app/ s32k1xx-toolchain
```

