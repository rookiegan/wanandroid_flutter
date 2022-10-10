
# 编译步骤
1. flutter pub get

2. Android Studio 安装 Flutter Intl 插件，该插件会自动检测国际化资源是否变动
    如果lib/generated/路径下仍然无法生成国际化资源，则使用 flutter pub global run intl_utils:generate

3. 生成文件: flutter pub run build_runner watch --delete-conflicting-outputs
