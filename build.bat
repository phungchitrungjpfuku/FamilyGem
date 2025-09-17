@echo off
rem Script tự động build APK cho Family Gem trên Windows

echo === Family Gem APK Builder ===
echo.

rem Kiểm tra Java
echo Kiểm tra Java...
java -version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Java chưa được cài đặt!
    echo Vui lòng cài đặt Java JDK 17+ từ: https://adoptium.net/
    pause
    exit /b 1
)

echo ✅ Java đã được cài đặt
java -version

rem Kiểm tra JAVA_HOME
if "%JAVA_HOME%"=="" (
    echo ⚠️  JAVA_HOME chưa được thiết lập
    echo Đang tự động tìm Java...

    rem Tự động tìm JAVA_HOME từ registry hoặc path
    for /f "tokens=2*" %%i in ('reg query "HKEY_LOCAL_MACHINE\SOFTWARE\JavaSoft\JDK" /s /v JavaHome 2^>nul ^| find "JavaHome"') do (
        set "JAVA_HOME=%%j"
        goto :found_java
    )

    :found_java
    if not "%JAVA_HOME%"=="" (
        echo ✅ Đã thiết lập JAVA_HOME: %JAVA_HOME%
    )
)

rem Tạo thư mục output nếu chưa có
if not exist build_output mkdir build_output

echo.
echo 🔨 Bắt đầu build APK...
echo.

rem Clean project trước
echo Dọn dẹp project...
gradlew.bat clean

rem Build release APK
echo.
echo Build release APK...
gradlew.bat assembleRelease

if %errorlevel% equ 0 (
    echo.
    echo ✅ Build thành công!

    rem Tìm file APK
    for /r app\build\outputs\apk\release %%f in (*.apk) do (
        if exist "%%f" (
            rem Copy APK vào thư mục build_output
            copy "%%f" build_output\FamilyGem-release.apk >nul

            echo.
            echo 📱 File APK đã được tạo:
            echo    • Location: build_output\FamilyGem-release.apk
            for %%A in (build_output\FamilyGem-release.apk) do echo    • Size: %%~zA bytes
            echo.
            echo 🎉 Bạn có thể cài đặt file APK này trên thiết bị Android!

            rem Hiển thị thông tin APK
            echo.
            echo 📋 Thông tin APK:
            echo    • App ID: app.familygem
            echo    • Version: 1.2 (28)
            echo    • Min SDK: 21 (Android 5.0)
            echo    • Target SDK: 35

            goto :success
        )
    )

    echo ❌ Không tìm thấy file APK sau khi build!
    goto :error
) else (
    echo.
    echo ❌ Build thất bại!
    echo Vui lòng kiểm tra lỗi ở trên và thử lại.
    goto :error
)

:success
echo.
echo Build hoàn tất! Nhấn phím bất kỳ để thoát...
pause >nul
exit /b 0

:error
echo.
echo Nhấn phím bất kỳ để thoát...
pause >nul
exit /b 1