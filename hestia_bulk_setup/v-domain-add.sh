#!/bin/bash
# bash /home/linksnova007/tmp/domains/v-domain-add.sh

# Configuration
USER="linksnova007"
IP="REPLACE_WITH_YOUR_SERVER_IP" # Replace this with your server's actual IP curl ifconfig.me
DOMAIN_LIST="/home/linksnova007/tmp/domains/domains.txt"
LOG_FILE="/home/linksnova007/tmp/domains/domain_addition.log"

# Clear previous log
> "$LOG_FILE"

# Loop through domains
while IFS= read -r domain; do
    # Skip empty lines
    [ -z "$domain" ] && continue

    echo "Processing: $domain"

    # Add domain with DNS and mail (no SSL)
    v-add-domain "$USER" "$domain" "$IP" 'yes' 'no' 'no' 'no' 'no' '' '' 'yes' 'no' 'yes' >> "$LOG_FILE" 2>&1

    # Check exit status
    if [ $? -eq 0 ]; then
        echo "Success: $domain" >> "$LOG_FILE"
    else
        echo "Error: Failed to add $domain (already exists?)" >> "$LOG_FILE"
    fi

    # Add 1-second delay before processing the next domain
    sleep 2
done < "$DOMAIN_LIST"

echo "Bulk domain addition completed. Check log: $LOG_FILE"
