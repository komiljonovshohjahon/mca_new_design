@echo off

:build

call flutter pub run change_app_package_name:main com.example.name

goto end

:end