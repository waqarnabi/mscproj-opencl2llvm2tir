# Transformation of pipe-based OpenCL kernels into an LLVM-based intermediate representation for FPGA programming

Wim Vanderbauwhede, Waqar Nabi, Glasgow, Oct 2018

## Context

The context of this MSc team project is the [TyTra research project](http://tytra.org.uk). The aim of this research is to make it easier to deploy legacy scientific code onto heterogeneous systems, and in particular on FPGAs.

FPGAs are promising as accelerators for a wide class of applications where the computation can be expressed as dataflow. A high-level programming approach for FPGAs is via [the OpenCL framework](https://www.khronos.org/opencl/), which has added a mechanism called _pipes_ specifically to support dataflow programming. However, OpenCL does not currently support the program transformations that are the focus of the TyTra project. Therefore, we have developed our own programming flow. This flow uses an intermediate representation language called Tytra-IR, which is based on [LLVM](https://llvm.org).

## Aim

The aim of this project is to develop a series of scripts that allow to transform pipe-based OpenCL kernels in to Tytra-IR programs.

## Approach

The proposed approach is to translate the  OpenCL kernel code to LLVM IR using a carefully chosen series of passes, and then transform this LLVM code into Tytra-IR code using a custom Python script.

## Key tasks

- Transform the OpenCL code into C code that works in `clang`, this involves defining of macros to remove or change unsupported keywords and creating OpenCL API function stubs.
- Transform this C code into LLVM IR, via the script provided in the repo.
- Transform the LLVM IR into Tytra-IR via a custom Python script.
- Validate correctness of the toolchain by comparison with a manual Tytra-IR reference.
- Demonstrate the functionality of the toolchain on a more complicated kernel (2-D shallow water equation).
