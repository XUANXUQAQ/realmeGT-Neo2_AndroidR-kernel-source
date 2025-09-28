#!/bin/bash
ARM64_AS="aarch64-linux-gnu-as"  
ARM32_AS="arm-linux-gnueabi-as"
X86_AS="x86_64-linux-gnu-as"

# Murasame at 2025/09/28 20:06
# 我不知道为什么交叉编译arm代码就非得用as，指定AS=aarch64-linux-gnu-as不管用。所以我写了这个很烂的包装脚本。

for arg in "$@"; do
    if [ "$arg" = "-EL" ]; then
        exec "$ARM64_AS" "$@"
    fi
done

for arg in "$@"; do
    if [ "$arg" = "-mfloat-abi=soft" ]; then
        exec "$ARM32_AS" "$@"
    fi
done

# 如果没有找到，则使用x86的汇编器
exec "$X86_AS" "$@"
