#!/bin/bash
# Script tự động build APK cho Family Gem

echo "=== Family Gem APK Builder ==="
echo ""

# Kiểm tra Java
echo "Kiểm tra Java..."
if ! command -v java &> /dev/null; then
    echo "❌ Java chưa được cài đặt!"
    echo "Vui lòng cài đặt Java JDK 17+ từ: https://adoptium.net/"
    exit 1
fi

JAVA_VERSION=$(java -version 2>&1 | head -n 1 | cut -d'"' -f2 | cut -d'.' -f1)
echo "✅ Java version: $(java -version 2>&1 | head -n 1)"

# Kiểm tra JAVA_HOME
if [ -z "$JAVA_HOME" ]; then
    echo "⚠️  JAVA_HOME chưa được thiết lập"
    echo "Đang tự động tìm Java..."

    # Tự động tìm JAVA_HOME
    if command -v java &> /dev/null; then
        JAVA_PATH=$(which java)
        JAVA_HOME=$(dirname $(dirname $(readlink -f $JAVA_PATH)))
        export JAVA_HOME
        echo "✅ Đã thiết lập JAVA_HOME: $JAVA_HOME"
    fi
fi

# Tạo thư mục output nếu chưa có
mkdir -p build_output

echo ""
echo "🔨 Bắt đầu build APK..."
echo ""

# Clean project trước
echo "Dọn dẹp project..."
./gradlew clean

# Build release APK
echo ""
echo "Build release APK..."
./gradlew assembleRelease

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Build thành công!"

    # Tìm file APK
    APK_FILE=$(find app/build/outputs/apk/release -name "*.apk" | head -n 1)

    if [ -f "$APK_FILE" ]; then
        # Copy APK vào thư mục build_output
        cp "$APK_FILE" build_output/FamilyGem-release.apk

        echo ""
        echo "📱 File APK đã được tạo:"
        echo "   • Location: build_output/FamilyGem-release.apk"
        echo "   • Size: $(du -h build_output/FamilyGem-release.apk | cut -f1)"
        echo ""
        echo "🎉 Bạn có thể cài đặt file APK này trên thiết bị Android!"

        # Hiển thị thông tin APK
        echo ""
        echo "📋 Thông tin APK:"
        echo "   • App ID: app.familygem"
        echo "   • Version: 1.2 (28)"
        echo "   • Min SDK: 21 (Android 5.0)"
        echo "   • Target SDK: 35"
    else
        echo "❌ Không tìm thấy file APK sau khi build!"
    fi
else
    echo ""
    echo "❌ Build thất bại!"
    echo "Vui lòng kiểm tra lỗi ở trên và thử lại."
    exit 1
fi