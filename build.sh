#!/bin/bash


dd if=bootloader.bin of=os.img count=1
dd if=kernel.bin of=os.img seek=1
