
# Fan Control for Thinkpad E16  
**Fully tested on E16 Gen1 (AMD)**  

This shell script enables manual control of the fan speed on Thinkpad E16 laptops. It uses `/proc/acpi/ibm/fan` to communicate and control fan speeds

---

## Features  
- Customizable fan speed control.  
- Temperature-based fan curve adjustment.  

---

## Requirements  
- **Thinkpad E16 Gen1 (AMD)** or compatible Thinkpad models.  
- Linux operating system (tested on Fedora).  
- `thinkpad_acpi` kernel module support.  

---

## Installation  

### Step 1: Enable Thinkpad ACPI Fan Control  

1. Add the required kernel option:  
   ```bash
   echo "options thinkpad_acpi fan_control=1" | sudo tee /etc/modprobe.d/thinkpad.conf
   sudo modprobe -r thinkpad_acpi  
   sudo modprobe thinkpad_acpi  
   ```
2. Reboot your system.  

3. Verify the module is loaded:  
   ```bash
   sudo modinfo thinkpad_acpi | grep fan_control
   ```

### Step 2: Clone the Repository  

```bash
git clone https://github.com/Haisen-VK/E16-Fan-Control
cd E16-Fan-Control
```

### Step 3: Run the Setup Script  

```bash
sudo ./setup.sh
```

---

## Usage  

1. Set the fan speed to automatic after setup:  
   ```bash
   sudo E16-FanControl -setSpeed auto
   ```

2. Customize your fan profile by editing the configuration file:  
   ```bash
   sudo nano /etc/E16FanControlConfig.txt
   ```

---



## Contributing  
Contributions are welcome! Feel free to fork the repository and submit a pull request.  

---

## License  
This project is licensed under the MIT License.  
