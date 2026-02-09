
# Lupe - SSH Log Analyzer

**Lupe** is a lightweight Bash script that analyzes SSH authentication logs (`/var/log/auth.log`). It provides a summary of successful logins, failed login attempts, invalid users, sudo commands, and the most active IPs — including the country and ISP for each IP.

Repository: https://github.com/dynasmon/lupe

---

## Features

- Shows successful SSH logins
- Lists failed login attempts
- Detects invalid user attempts
- Displays sudo commands executed
- Lists most active IPs with **country** and **ISP**
- Lists users who attempted to log in
- Useful for server monitoring and security auditing

---

## Installation

### Clone the repository:

```bash
git clone https://github.com/dynasmon/lupe.git
cd lupe
```

### Make the script executable:

```bash
chmod +x lupe.sh
```

### (Optional) Move to `/usr/local/bin` to run from anywhere:

```bash
sudo mv lupe.sh /usr/local/bin/lupe
```

Now you can run it from any directory with:

```bash
lupe
```

or directly:

```bash
bash lupe.sh
```

---

## Requirements

- `curl`
- `grep`
- `awk`
- `whois` *(optional if using local lookups)*

Install them with:

```bash
sudo apt install curl grep awk whois -y
```

---

## Usage

Simply run:

```bash
bash lupe.sh
```

or, if installed globally:

```bash
lupe
```

---

## Example Output

```
IPs with country and ISP:
      9 203.0.113.10 - SG - Example ISP
      5 192.0.2.55 - BR - Example Provider
      2 198.51.100.23 - US - Example Cloud
```

---

## Notes

- Uses [ipinfo.io](https://ipinfo.io/) API for IP lookups (free tier allows 1,000 requests per day).
- Can be modified to use local `whois` instead of the API.

---

## Disclaimer

This tool is intended for **security auditing, monitoring, and educational purposes only**. Use responsibly.
