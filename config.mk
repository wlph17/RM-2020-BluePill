include util.mk
# Use command line to change prefix as: $> make PREFIX=/path/to/llvm/bin/prefix-
PREFIX    ?=
# y: verbose output, other: silent mode
VERBOSE   ?= n
# Project name
TARGET    := HelloWorld
# Build directory
BUILD_DIR := build
# Linker script
LDSCRIPT  := STM32F103C8Tx_FLASH.ld
# Optimization level: 0, 1, 2, 3, fast, s, z, g
OPT_LEVEL := s
# Arch flags (translated to scripts/$(ARCH).mk)
ARCH      := cortex-m3
# C standard: c89, c99, c11
C_STD     := c11
# CPP standard:
CPP_STD   := gnu++11
# Debug level: 0, 1, 2, 3
DBG_LEVEL := 3
# GCC Toolchain SYSROOT
SYSROOT = $(call normalize,$(shell arm-none-eabi-gcc --print-sysroot))
# libgcc.a path
LIBGCC = $(call normalize,$(call +s,$(dir $(call s+,$(shell arm-none-eabi-gcc --print-libgcc-file-name)))))
# LIB_SUBPATH
LIB_SUBPATH = thumb/v7e-m+fp/hard/

RTOS_PATH = $/RTOS
include $(RTOS_PATH)/RTOS.mk
