# 🔨 Hướng dẫn Build Family Gem APK

## Yêu cầu hệ thống

### 1. Java Development Kit (JDK)
- **Yêu cầu:** JDK 17 hoặc cao hơn
- **Tải về:** [Eclipse Temurin JDK](https://adoptium.net/) (khuyến nghị)
- **Kiểm tra:** `java -version`

### 2. Android Studio (Tùy chọn nhưng khuyến nghị)
- **Tải về:** [Android Studio](https://developer.android.com/studio)
- Bao gồm Android SDK và build tools

### 3. Biến môi trường
```bash
# Windows
set JAVA_HOME=C:\Program Files\Eclipse Adoptium\jdk-17.0.x

# Linux/Mac
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk
```

## 🚀 Cách build nhanh

### Sử dụng script tự động (Khuyến nghị)

#### Trên Linux/Mac:
```bash
chmod +x build.sh
./build.sh
```

#### Trên Windows:
```cmd
build.bat
```

### Build thủ công

#### 1. Clean project:
```bash
# Linux/Mac
./gradlew clean

# Windows
gradlew.bat clean
```

#### 2. Build APK:
```bash
# Linux/Mac
./gradlew assembleRelease

# Windows
gradlew.bat assembleRelease
```

## 📁 File APK output

Sau khi build thành công, file APK sẽ được tạo tại:

- **Thủ công:** `app/build/outputs/apk/release/app-release.apk`
- **Script tự động:** `build_output/FamilyGem-release.apk`

## 📱 Thông tin ứng dụng

- **Tên ứng dụng:** Family Gem
- **Package ID:** app.familygem
- **Version:** 1.2 (Build 28)
- **Min Android:** 5.0 (API 21)
- **Target Android:** Android 14 (API 35)

## 🔧 Troubleshooting

### Lỗi "JAVA_HOME is not set"
```bash
# Kiểm tra Java đã cài đặt
java -version

# Thiết lập JAVA_HOME (Windows)
set JAVA_HOME=C:\Program Files\Java\jdk-17

# Thiết lập JAVA_HOME (Linux/Mac)
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk
```

### Lỗi "SDK location not found"
1. Cài đặt Android Studio
2. Mở Android Studio và cài đặt SDK
3. Thiết lập `ANDROID_HOME`:
   ```bash
   # Windows
   set ANDROID_HOME=C:\Users\%USERNAME%\AppData\Local\Android\Sdk

   # Linux/Mac
   export ANDROID_HOME=$HOME/Android/Sdk
   ```

### Lỗi "Permission denied"
```bash
# Linux/Mac - cấp quyền thực thi
chmod +x gradlew
chmod +x build.sh
```

## 🎯 Build variants

### Debug APK (cho testing):
```bash
./gradlew assembleDebug
```

### Release APK (cho phát hành):
```bash
./gradlew assembleRelease
```

## 📝 Ghi chú

- File APK release đã được tối ưu và minify
- Cần chứng chỉ ký (signing certificate) để phát hành lên Google Play
- File `credential.properties` (nếu có) chứa thông tin signing

## 📞 Hỗ trợ

Nếu gặp vấn đề trong quá trình build, hãy kiểm tra:
1. Java JDK đã cài đặt đúng version
2. Biến môi trường JAVA_HOME đã thiết lập
3. Kết nối internet ổn định (để tải dependencies)
4. Đủ dung lượng ổ cứng (ít nhất 2GB free space)