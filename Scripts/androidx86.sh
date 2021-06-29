#!/bin/bash
qemu-system-x86_64 -boot c -enable-kvm -smp 2 -device virtio-vga,virgl=on  -net nic -net bridge,br=android0 -cpu host -device ES1370 -m 2048 -display sdl,gl=on -hda /run/media/c0dysharma/Drive/android/android.img

