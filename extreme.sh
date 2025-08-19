#!/bin/bash

AS=nasm
LD=ld

$AS -f elf64 kernel.asm -o kernel.o

$LD -n -o kernel.bin -T linker.ld kernel.o

if [ ! -f kernel.bin ]; then
	echo "Failed to assemble the kernel"
	exit 1
fi

qemu-system-x86_64 \
	-kernel kernel.bin \
	-cpu host \
	-smp cores=1,threads=2 \
	-m 64K \
	-nographic \
	-icount shift=auto,sleep=on \
	-rtc base=utc,clock=vm \
	-monitor stdio \
	-s

rm kernel.o kernel.bin
