# 🚀 bb-fast (中文文档)

[**English**](README.md) | [**中文文档**](README_CN.md)

**bb-fast** 是一款高性能、轻量级、零依赖的跨平台 Fast.com / Netflix Open Connect 测速客户端（纯 C 语言原生实现）。专为嵌入式 Linux 设备（OpenWrt / Padavan / Cudy 等路由器）、NAS、开发板（树莓派 / RISC-V）以及服务器设计。

---

## ✨ 特性

- ⚡ **极致性能**：C 语言原生实现，全链路 `-O3 -flto` 深度优化，支持 ARMv8 Crypto / AES-NI 硬件加密加速，轻松压满千兆、2.5G 与万兆网络。
- 📦 **完全静态编译**：零外部依赖，内置 TLS/SSL 加密协议栈。可在任意 Linux 发行版（glibc、musl libc、OpenWrt、Alpine、Debian、CentOS 等）、macOS 及 Windows 上开箱即用。
- 🔍 **智能服务器择优**：自动从 Fast.com (Netflix Open Connect CDN) 获取附近的候选测速服务器，并发测试 Ping 延迟并自动选取最优节点。
- 📋 **列表与指定节点**：支持 `-L` 查看附近服务器列表及延迟；支持 `-s <序号>` 手动指定特定测速节点。
- 📤 **支持下行与上行测试**：默认高速下行下载测速，支持 `-U` 开启下行+上行完整双向测速。
- 🛡️ **动态 Token 解析**：自动从 Fast.com 页面获取有效凭证，内置安全回退 Token 保障高可用。
- 📊 **实时统计与块数计算**：实时显示 Mbps / MB/s 速率、传输进度以及 25MB 数据块的完成数量。

---

## 🎯 支持架构与预编译文件列表

每次在 GitHub 提交 Release 标签时，GitHub Actions 会自动编译并发布以下 11 个平台的静态二进制文件：

| 系统 / 架构 | 二进制文件名 | 适用设备 |
| :--- | :--- | :--- |
| **Linux x86_64** | `bb-fast-linux-x86_64` | Intel / AMD 64位软路由、PC、VPS、服务器 |
| **Linux aarch64** | `bb-fast-linux-aarch64` | 树莓派 4/5、ARM 路由器 (Cudy/MT7981/MT7986/高通等)、Apple Silicon Linux、甲骨文 ARM |
| **Linux armhf** | `bb-fast-linux-armhf` | 树莓派 2/3、老款 ARMv7 路由器 |
| **Linux armel** | `bb-fast-linux-armel` | 老款 ARMv5TE / ARMv6 嵌入式设备 |
| **Linux mipsel** | `bb-fast-linux-mipsel` | MIPS 小端路由器 (MT7621 / MT7620 等经典 OpenWrt 路由) |
| **Linux mips** | `bb-fast-linux-mips` | MIPS 大端设备 (Atheros AR9344 等) |
| **Linux riscv64** | `bb-fast-linux-riscv64` | RISC-V 架构开发板与服务器 |
| **Linux i686** | `bb-fast-linux-i686` | 32位 x86 旧设备 |
| **macOS Apple Silicon** | `bb-fast-darwin-arm64` | Apple Silicon Mac (M1 / M2 / M3 / M4) |
| **Windows x86_64** | `bb-fast-windows-x86_64.exe` | Windows 10 / 11 / Server (x86_64 64位) |
| **Windows ARM64** | `bb-fast-windows-arm64.exe` | Windows 11 on ARM (骁龙 X Elite、Surface Pro ARM 等) |

---

## 🚀 快速上手

### 1. 下载并赋予执行权限

```bash
# 以 ARM64 路由器为例 (可在 Releases 页面下载最新版)
wget -O bb-fast https://github.com/kxjhwbb/fast/releases/latest/download/bb-fast-linux-aarch64
chmod +x bb-fast
```

### 2. 常用命令示例

```bash
# 1. 默认模式：自动优选最低延迟 Fast.com 服务器测速 (默认 4 线程，10 秒，仅测下行)
./bb-fast

# 2. 双向测速：先测下行下载，紧接着测上行上传
./bb-fast -U

# 3. 列出所有附近的测速节点及 Ping 延迟
./bb-fast -L

# 4. 手动指定服务器序号测速
./bb-fast -s 1

# 5. 高性能压测：使用 16 线程，持续 15 秒，进行双向测速
./bb-fast -t 16 -d 15 -U

# 6. 自定义测速源 URL 测试
./bb-fast -u "https://ipv4-c004-hkg001-hkbn-isp.1.oca.nflxvideo.net/speedtest?c=hk&n=9269&v=245&e=1791565619&t=..."
```

---

## 📖 命令行参数说明

```text
Usage: bb-fast [options]

Options:
  -u <url>           自定义测速 URL
  -s <index>         指定测速服务器序号 (从 -L 列表中选择，如 1)
  -L                 列出附近的所有 Fast.com 测速服务器及延迟并退出
  -U, --upload       开启完整测速 (先测下载，再测上传)
  -O, --only-upload  仅测试上传速度
  -t <threads>       并发线程数 (默认: 4)
  -d <seconds>       每个测试阶段持续时间 (默认: 10 秒)
  -b <bytes>         统计/分块大小 (默认: 26,214,400 字节 / 25MB)
  -T <sec>           网络连接与请求超时时间 (默认: 10 秒)
  -v, --version      显示版本信息并退出
  -h, --help         显示帮助信息并退出
```

---

## 🛠️ 本地编译构建

本项目依赖 OpenSSL 开发库（支持硬件加速）。

### 1. 安装编译依赖 (Debian / Ubuntu / 统信 UOS)

```bash
sudo apt-get update
sudo apt-get install -y build-essential pkg-config libssl-dev zlib1g-dev libzstd-dev
```

### 2. 本地直接编译

```bash
# 编译当前平台程序
gcc -O3 -flto -fomit-frame-pointer -Wall fast.c -o bb-fast -static -lssl -lcrypto -latomic -lz -lzstd -lpthread -ldl
strip bb-fast
```

或直接执行 Makefile：

```bash
make
```

---

## 📄 开源许可证

本项目基于 [MIT License](LICENSE) 开源。
