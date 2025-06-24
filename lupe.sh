#!/bin/bash

LOG="/var/log/auth.log"

get_ip_info() {
    ip="$1"
    response=$(curl -s "https://ipinfo.io/$ip/json")
    country=$(echo "$response" | grep '"country":' | cut -d '"' -f4)
    org=$(echo "$response" | grep '"org":' | cut -d '"' -f4)
    echo "$ip - $country - $org"
}

echo "Analyzing $LOG..."
echo "============================ SSH LOGINS ============================"

echo -e "\nSuccessful logins (Accepted password/publickey):"
grep "Accepted" "$LOG" | grep -oP 'from \K[\d.]+' | sort | uniq -c | sort -nr

echo -e "\nFailed login attempts (Failed password):"
grep "Failed password" "$LOG" | grep -oP 'from \K[\d.]+' | sort | uniq -c | sort -nr

echo -e "\nInvalid user attempts:"
grep "Invalid user" "$LOG" | grep -oP 'from \K[\d.]+' | sort | uniq -c | sort -nr

echo -e "\nSudo commands executed:"
grep 'sudo:' "$LOG"

echo -e "\nMost active IPs (with country and ISP):"
for ip in $(grep -E 'Failed password|Accepted|Invalid user|Disconnected from' "$LOG" | grep -oP 'from \K[\d.]+' | sort | uniq); do
    count=$(grep -E 'Failed password|Accepted|Invalid user|Disconnected from' "$LOG" | grep -oP "from $ip" | wc -l)
    info=$(get_ip_info "$ip")
    echo "      $count $info"
done

echo -e "\nLogins as root:"
grep "Accepted" "$LOG" | grep "root"

echo -e "\nUsers that attempted to log in:"
(
    grep "Failed password" "$LOG" | grep -oP 'for \K\S+'
    grep "Invalid user" "$LOG" | grep -oP 'Invalid user \K\S+'
) | sort | uniq -c | sort -nr

echo -e "\nAnalysis completed."
