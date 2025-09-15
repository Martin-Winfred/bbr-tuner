# BBR Congestion Control Configuration Tool
---
[中文](Readme.md)
---
This tool is an interactive BBR congestion control algorithm configuration script. It supports both Chinese and English interfaces and helps users easily enable and configure BBR network optimization features on Linux systems.

## Features

- **Interactive Operation** - Clear menu interface, easy to use
- **Bilingual (Chinese and English)** - Automatically detects the system language, supports manual switching
- **BBR Auto-Configuration** - Enables the BBR congestion control algorithm with one click
- **Queue Scheduler Optimization** - Intelligently recommends the optimal queue scheduler configuration
- **Best Practices** - Clearly identifies configuration solutions suitable for different scenarios
- **Configuration Persistence** - Supports saving configurations permanently to the system

## System Requirements

- Linux kernel 4.9+ (4.20+ recommended)
- Root privileges
- Bash shell or another shell compatible with Bash syntax

## 🚀 Quick Start

```bash
# Download the script

wget https://raw.githubusercontent.com/Martin-Winfred/bbr-tuner/main/bbr-tuner.sh

# Add execution permissions

chmod +x bbr-tuner.sh

# Run the script (requires root privileges)

sudo ./bbr-tuner.sh
```

## Usage Instructions

### Recommended Usage Process

1. After running the script, select Option 4 (Quickly Enable BBR)
2. Confirm that the BBR module is loaded
3. Confirm that the algorithm is set to `bbr` and the queue scheduler is set to `fq`
4. Select Option 6 to save the configuration permanently
5. Restart the system for the configuration to take effect

### Manual Configuration

- **Option 1**: Check and load the BBR module
- **Option 2**: Manually select the congestion control algorithm
- **Option 3**: Manually select the queue scheduler
- **Option 4**: Quickly enable BBR (recommended)
- **Option 5**: View the current system status
- **Option 6**: Permanently save the configuration
- **Option 7**: Switch the language

## 🛠 Configuration Recommendations

### Optimal BBR Configuration
```
Congestion Control Algorithm: bbr
Queue Scheduler: fq
```

## Supported Algorithms and Schedulers

### Congestion Control Algorithms
- `bbr` - Google's bottleneck bandwidth and round-trip time algorithm. ★ Recommended
- `cubic` - The default CUBIC algorithm
- `reno` - The traditional Reno algorithm
- `westwood` - The Westwood+ algorithm, suitable for wireless environments

### Queue Schedulers
- `fq` - Fair Queue. ★ Best matched with BBR
- `fq_codel` - Fair Queue with CoDel
- `cake` - General application retention enhancements
- `pfifo_fast` - The Linux default scheduler. ★ Best for batch processing
- `bfifo` - Byte First-In-First-Out
- `pfifo` - Packet First-In-First-Out

## Language Support

- 🇨🇳 Chinese (Simplified)
- 🇬🇧 English

The script automatically detects the system language, which can also be manually switched at runtime.

## Verify the Configuration

After completing the configuration, you can verify it with the following command:

```bash
# View the current congestion control algorithm
sysctl net.ipv4.tcp_congestion_control

# View the current queue scheduler
sysctl net.core.default_qdisc

# View the BBR module status
lsmod | grep tcp_bbr
```

## ⚠️ Notes

1. **Kernel Support**: Ensure your Linux kernel version supports BBR (4.9+)
2. **Permission Requirements**: This script requires root privileges to modify system configurations
3. **Reboot to Take Effect**: Some configurations may require a system reboot to fully take effect
4. **Backup Configuration**: A backup file is automatically created when the configuration is permanently saved

## 📝 License

GPLV3 - See the [LICENSE](LICENSE) file for details

## 🙏 Acknowledgements

- Google BBR Team
- Linux Kernel Networking Team