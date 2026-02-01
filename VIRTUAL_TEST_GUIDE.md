# Virtual Test Drive - Try Before You Buy (or Before Your Pi Arrives)

**No Raspberry Pi? No problem.** Test the AI Restaurant Manager on your laptop first using QEMU emulation.

---

## What This Is

QEMU lets you emulate a Raspberry Pi on your Windows/Mac/Linux computer. You'll:
- Run the sales tracking scripts
- See the dashboard interface
- Test invoice scanning
- Verify everything works before hardware arrives

**Note:** Some real-time features (voice announcements) won't work in emulation, but the core automation scripts will.

---

## System Requirements

| | Minimum | Recommended |
|--|---------|-------------|
| RAM | 4GB | 8GB+ |
| Storage | 10GB free | 20GB+ |
| CPU | 4 cores | 8 cores |
| OS | Windows 10+ / macOS / Linux | Latest |

---

## Step 1: Install QEMU

### Windows
1. Download QEMU from https://www.qemu.org/download/
2. Run installer (accept defaults)
3. Add to PATH (installer usually does this)

### macOS
```bash
brew install qemu
```

### Linux
```bash
sudo apt install qemu-system-arm  # Ubuntu/Debian
# or
sudo dnf install qemu  # Fedora
```

---

## Step 2: Download Raspberry Pi OS

1. Go to https://www.raspberrypi.com/software/operating-systems/
2. Download **Raspberry Pi OS Lite** (no desktop, smaller)
3. Extract the .img file

---

## Step 3: Create Virtual Machine

### Run this command (adjust paths for your system):

```bash
# Create 32GB virtual disk
qemu-img create -f qcow2 pi5-test.qcow2 32G

# Run the emulator
qemu-system-aarch64 \
  -machine virt \
  -cpu cortex-a72 \
  -smp 4 \
  -m 4G \
  -drive file=pi5-test.qcow2,if=none,id=hd0 \
  -device virtio-blk,drive=hd0 \
  -net nic \
  -net user,hostfwd=tcp::2222-:22 \
  -device virtio-gpu-gl \
  -display sdl,gl=on \
  -cdrom 2025-02-04-raspios-bookworm-arm64.img \
  -boot order=d
```

---

## Step 4: Configure Pi OS

1. Wait for boot (2-5 minutes)
2. Login: `pi` / `raspberry`
3. Run setup:
```bash
sudo raspi-config
```
- Enable SSH
- Set keyboard/layout
- Expand filesystem

4. Update system:
```bash
sudo apt update && sudo apt upgrade -y
```

---

## Step 5: Install Prerequisites

```bash
# Install Python and deps
sudo apt install -y python3 python3-pip git

# Clone our repo
git clone https://github.com/zemiai/ai-restaurant-manager.git
cd ai-restaurant-manager/product-bundle
```

---

## Step 6: Test Scripts

```bash
# Test sales tracking (mock data)
cd Scripts
python3 test_sales_tracking.py

# Test invoice scanning (mock data)
python3 test_invoice_scan.py

# Check results
cat ../reports/daily_summary.md
```

---

## Step 7: Access Dashboard

Since QEMU uses virtual networking:
1. From Pi terminal, run:
```bash
ifconfig
```
2. Note the IP address
3. On your host computer, open browser to:
```
http://[PI-IP]:8000
```

---

## What Works in Emulation

| Feature | Works? | Notes |
|---------|--------|-------|
| Sales tracking | ✅ Yes | Mock data or real API |
| Labor monitoring | ✅ Yes | Mock data |
| Invoice scanning | ✅ Yes | Mock emails |
| Dashboard UI | ✅ Yes | Web interface |
| Voice TTS | ⚠️ Limited | May not work |
| Telegram alerts | ⚠️ Limited | Network dependent |

---

## Troubleshooting

### "QEMU command not found"
- Add QEMU to PATH, or use full path: `/usr/bin/qemu-system-aarch64`

### "Boot stuck at rainbow screen"
- Wait 5 minutes first boot
- Try less RAM: change `-m 4G` to `-m 2G`

### "Network not working"
- QEMU user networking can be slow
- Try: `-netdev user,id=net0,hostfwd=tcp::2222-:22`

### "Too slow"
- Close other applications
- Reduce RAM: `-m 2G` instead of `-m 4G`
- Use SSD instead of HDD

---

## Next Steps (After Testing)

1. **Buy Pi 5** ($60-80 on Amazon)
2. **Flash SD card** with our pre-built image
3. **Configure real APIs** (Toast, Gmail, Telegram)
4. **Go live!**

---

## Video Tutorial

Watch the full walkthrough:
[YouTube link - coming soon]

---

## Support

Questions? Email support@zemiai.com

