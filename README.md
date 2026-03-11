# Presearch Node Watchdog

An automated stability watchdog designed for **Presearch Nodes** running via **Docker**. This script is specifically optimized for **Raspberry Pi** and other Linux-based systems to ensure 24/7 uptime and consistent rewards.

## Why use this Watchdog?

Decentralized nodes like Presearch can sometimes experience container crashes or connectivity issues due to system updates or hardware fluctuations. This script acts as a self-healing layer, detecting these issues and fixing them within minutes without manual intervention, ensuring your node stays online and eligible for staking rewards.

## Key Features

* **Docker Container Monitoring:** Periodically verifies that the `presearch-node` container is active and running.
* **Hardware Telemetry:** Monitors and reports Raspberry Pi CPU temperature to track environmental health.
* **Automated Recovery:** If the Docker container stops or crashes, the watchdog attempts an immediate restart.
* **Remote Alerts:** Sends a heartbeat signal to an Uptime Kuma dashboard. If the node goes dark or requires a restart, you receive an instant notification.

## Quick Installation

**1. Download the script:**
```bash
curl -O [https://raw.githubusercontent.com/tomatdb52/presearch-watchdog/main/watchdog.sh](https://raw.githubusercontent.com/tomatdb52/presearch-watchdog/main/watchdog.sh)
```
**2. Make it executable:**  
```bash
chmod +x watchdog.sh
```
**3. Configure your Heartbeat (Optional):**  
Edit the file and add your Uptime Kuma Push URL in the KUMA_URL field.  
```bash
nano watchdog.sh
```
**4. Schedule it:**  
Add the script to your crontab to run every 5 minutes:

```bash
(crontab -l 2>/dev/null; echo "*/5 * * * * /bin/bash $HOME/presearch-watchdog/watchdog.sh >/dev/null 2>&1") | crontab -
```
## Proven Reliability  
This system has been verified to catch and resolve container failures automatically, restoring node services within 5 minutes of a downtime event and providing historical uptime data via Uptime Kuma.
