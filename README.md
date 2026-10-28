# 🚀 bb-fast (English Documentation)

[**English**](README.md) | [**中文文档**](README_CN.md)

**bb-fast** is an ultra-fast, lightweight, zero-dependency, cross-platform Fast.com / Netflix Open Connect speed testing client written natively in pure C. Designed specifically for embedded Linux devices (OpenWrt / Padavan / Cudy routers, etc.), NAS, development boards (Raspberry Pi / RISC-V), and servers.

---

## ✨ Features

- ⚡ **High Performance**: Native C implementation optimized with `-O3 -flto` and hardware crypto acceleration (ARMv8 Crypto / AES-NI), easily saturating Gigabit, 2.5G, and 10G networks.
- 📦 **Fully Static Binaries**: Zero external runtime dependencies, built-in TLS/SSL protocol engine. Works out of the box on any Linux distribution (glibc, musl libc, OpenWrt, Alpine, Debian, CentOS, etc.), macOS, and Windows.
- 🔍 **Smart Server Selection**: Automatically queries Fast.com (Netflix Open Connect CDN) for nearby servers, measures ping latency concurrently, and picks the fastest node.
- 📋 **List & Custom Server**: Supports `-L` to inspect candidate nodes and latencies; supports `-s <index>` to target a specific server.
- 📤 **Bidirectional Testing**: Default high-speed download test; supports `-U` for full download + upload benchmarking.
- 🛡️ **Dynamic Token Extraction**: Automatically parses fresh tokens from Fast.com with built-in fallback security.
- 📊 **Real-Time Statistics**: Live display of Mbps / MB/s throughput, transfer progress, and 25MB block metrics.

---

## 🎯 Supported Architectures & Prebuilt Binaries

On every release tag on GitHub, GitHub Actions automatically builds and publishes static standalone binaries for 11 platforms:

| OS / Architecture | Binary Name | Target Hardware |
| :--- | :--- | :--- |
| **Linux x86_64** | `bb-fast-linux-x86_64` | Intel / AMD 64-bit Routers, PCs, VPS, Servers |
| **Linux aarch64** | `bb-fast-linux-aarch64` | Raspberry Pi 4/5, ARM Routers (Cudy/MT7981/MT7986/Qualcomm), Apple Silicon Linux |
| **Linux armhf** | `bb-fast-linux-armhf` | Raspberry Pi 2/3, Legacy ARMv7 Routers |
| **Linux armel** | `bb-fast-linux-armel` | Legacy ARMv5TE / ARMv6 Embedded Hardware |
| **Linux mipsel** | `bb-fast-linux-mipsel` | MIPS Little-Endian Routers (MT7621 / MT7620 OpenWrt) |
| **Linux mips** | `bb-fast-linux-mips` | MIPS Big-Endian Routers (Atheros AR9344, etc.) |
| **Linux riscv64** | `bb-fast-linux-riscv64` | RISC-V SBCs & Servers |
| **Linux i686** | `bb-fast-linux-i686` | Legacy 32-bit x86 Hardware |
| **macOS Apple Silicon** | `bb-fast-darwin-arm64` | Apple Silicon Mac (M1 / M2 / M3 / M4) |
| **Windows x86_64** | `bb-fast-windows-x86_64.exe` | Windows 10 / 11 / Server (x86_64 64-bit) |
| **Windows ARM64** | `bb-fast-windows-arm64.exe` | Windows 11 on ARM (Snapdragon X Elite, Surface Pro ARM, etc.) |

---

## 🚀 Quick Start

### 1. Download and Grant Execution Permissions

```bash
# Example for ARM64 Linux routers (available on GitHub Releases)
wget -O bb-fast https://github.com/kxjhwbb/fast/releases/latest/download/bb-fast-linux-aarch64
chmod +x bb-fast
```

### 2. Common Usage Examples

```bash
# 1. Default mode: auto-select best Netflix Fast.com server (4 threads, 10s download)
./bb-fast

# 2. Bidirectional test: download followed by upload
./bb-fast -U

# 3. List candidate servers with real-time ping latencies
./bb-fast -L

# 4. Target a specific server index from -L list
./bb-fast -s 1

# 5. Stress test with 16 threads for 15 seconds (download + upload)
./bb-fast -t 16 -d 15 -U

# 6. Test with a custom speedtest URL
./bb-fast -u "https://ipv4-c004-hkg001-hkbn-isp.1.oca.nflxvideo.net/speedtest?c=hk&n=9269&v=245&e=1791565619&t=..."
```

---

## 📖 Command Line Options

```text
Usage: bb-fast [options]

Options:
  -u <url>           Custom speedtest URL
  -s <index>         Specify server index from -L list (e.g. 1)
  -L                 List nearby Fast.com servers and their latencies
  -U, --upload       Enable full test (download then upload)
  -O, --only-upload  Upload test only
  -t <threads>       Number of concurrent streams (Default: 4)
  -d <seconds>       Test duration in seconds per stage (Default: 10)
  -b <bytes>         Chunk / block size in bytes (Default: 26,214,400 / 25MB)
  -T <sec>           Connection & request timeout in seconds (Default: 10)
  -v, --version      Show version information and exit
  -h, --help         Show help message and exit
```

---

## 🛠️ Building from Source

This project requires OpenSSL development headers and static libraries.

### 1. Install Build Dependencies (Debian / Ubuntu)

```bash
sudo apt-get update
sudo apt-get install -y build-essential pkg-config libssl-dev zlib1g-dev libzstd-dev
```

### 2. Compile Locally

```bash
gcc -O3 -flto -fomit-frame-pointer -Wall fast.c -o bb-fast -static -lssl -lcrypto -latomic -lz -lzstd -lpthread -ldl
strip bb-fast
```

Or build with `make`:

```bash
make
```

---

## 📄 License

This project is licensed under the [MIT License](LICENSE).
