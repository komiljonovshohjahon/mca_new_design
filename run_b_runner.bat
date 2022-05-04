@echo off

:build

call flutter packages pub run build_runner watch --delete-conflicting-outputs

goto end

:end