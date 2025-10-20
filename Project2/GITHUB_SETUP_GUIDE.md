# GitHub 提交指南

## 步骤 1: 安装 Git

1. 访问 https://git-scm.com/download/win
2. 下载 Windows 版本的 Git
3. 运行安装程序，使用默认设置即可
4. 安装完成后，重新打开 PowerShell

## 步骤 2: 配置 Git

安装完成后，在 PowerShell 中运行以下命令配置您的信息：

```powershell
git config --global user.name "您的GitHub用户名"
git config --global user.email "您的GitHub邮箱"
```

## 步骤 3: 初始化 Git 仓库

在项目目录中运行：

```powershell
# 初始化 Git
git init

# 添加所有文件到暂存区
git add .

# 提交更改
git commit -m "初始提交：Django开发者信息项目"
```

## 步骤 4: 连接到 GitHub 仓库

```powershell
# 添加远程仓库
git remote add origin https://github.com/Wacenrs8192/20231201023.git

# 验证远程仓库
git remote -v
```

## 步骤 5: 推送到 GitHub

```powershell
# 推送代码到 GitHub
git push -u origin main

# 如果遇到错误，可能需要先拉取更改
git pull origin main --allow-unrelated-histories
git push -u origin main
```

## 步骤 6: 验证提交

访问 https://github.com/Wacenrs8192/20231201023 查看您的代码

## 重要文件说明

项目包含以下重要文件：
- `manage.py` - Django 管理脚本
- `developer_info/` - 主要应用代码
- `mysite/` - 项目设置
- `requirements.txt` - Python 依赖
- `.gitignore` - Git 忽略规则
- `db.sqlite3` - 数据库文件（已添加到.gitignore）

## 注意事项

1. 确保您有 GitHub 仓库的写入权限
2. 第一次推送可能需要输入 GitHub 用户名和密码
3. 推荐使用 SSH 密钥进行更安全的认证

## 设置 SSH 密钥（可选）

```powershell
# 生成 SSH 密钥
ssh-keygen -t ed25519 -C "您的邮箱"

# 将公钥添加到 GitHub
cat ~/.ssh/id_ed25519.pub
# 然后复制到 GitHub Settings -> SSH and GPG keys
```