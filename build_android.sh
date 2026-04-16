#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ -z "${ANDROID_NDK_HOME:-}" ] || [ ! -d "$ANDROID_NDK_HOME" ]; then
    echo "请设置 ANDROID_NDK_HOME 为 Android NDK 根目录（须含 build/cmake/android.toolchain.cmake）。"
    exit 1
fi

echo "Building for Android (arm64-v8a) with NDK: $ANDROID_NDK_HOME"

mkdir -p "$SCRIPT_DIR/build_android"
cd "$SCRIPT_DIR/build_android"

cmake "$SCRIPT_DIR" \
    -DCMAKE_TOOLCHAIN_FILE="$ANDROID_NDK_HOME/build/cmake/android.toolchain.cmake" \
    -DANDROID_ABI=arm64-v8a \
    -DANDROID_PLATFORM=android-24 \
    -DCMAKE_BUILD_TYPE=Release

cmake --build .

echo "Android build complete. Output is in build_android/"
