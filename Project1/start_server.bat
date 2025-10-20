@echo off
setlocal
TITLE Django Server Starter (CMD only)

REM ===============================
REM  纯 CMD 启动脚本，不使用 PowerShell
REM ===============================

REM 检查 Python Launcher 是否可用
py --version >nul 2>&1
if errorlevel 1 (
  echo [ERROR] 未检测到 Python Launcher (py)。请安装 Python 或将 py 加入 PATH。
  echo 下载地址: https://www.python.org/downloads/
  pause
  exit /b 1
)

REM 创建虚拟环境（若不存在）
if not exist ".\.venv\Scripts\python.exe" (
  echo [INFO] 未检测到虚拟环境，正在创建 .venv ...
  py -m venv .venv
  if errorlevel 1 (
    echo [ERROR] 创建虚拟环境失败。
    pause
    exit /b 1
  )
)

REM 激活虚拟环境（CMD 批处理）
call ".\.venv\Scripts\activate.bat"
if errorlevel 1 (
  echo [ERROR] 激活虚拟环境失败。
  pause
  exit /b 1
)

REM 安装依赖
if exist "requirements.txt" (
  echo [INFO] 安装依赖...
  pip install -r requirements.txt
  if errorlevel 1 (
    echo [ERROR] 依赖安装失败，请检查网络或 requirements.txt。
    pause
    exit /b 1
  )
) else (
  echo [WARN] 未找到 requirements.txt，跳过依赖安装。
)

REM 迁移数据库
echo [INFO] 迁移数据库...
python manage.py migrate
if errorlevel 1 (
  echo [ERROR] 迁移失败，请检查错误输出。
  pause
  exit /b 1
)

REM 启动开发服务器
echo [INFO] 启动开发服务器: http://127.0.0.1:8000/
python manage.py runserver

echo.
echo [DONE] 脚本执行结束。
pause
endlocal