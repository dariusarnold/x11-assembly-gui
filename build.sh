#!/usr/bin/env bash

set -euo pipefail

nasm -f elf64 -g main.asm
ld main.o -static -o main