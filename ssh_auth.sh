#!/bin/bash

# Add the provided public key to the authorized_keys file
PUB_KEY="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC/OJtZy81Eh7QsL0mC5cmIKTYIVup1McltMPtq9SGfFiA8CSGVXWkNcrWBc0gtAfLdox3sE0JtqS97TI5VuGPqlZbPDPBsolJ2WN2UFPYbnCwHGMWl5RhUOTeZ5XzXtP9qRGQNWdkhA+Pdral1dd6t14Mj78c555QCoPz3g2HGjpUYM0rSFa6fNDQcOBm2HNmoTMLeCUrulpeqb1HjzS6trqyYeT1tQGENJqRzp2vU33R+IRAFL8j34hb8toK394lxdjgl+PmzdNcleyOk8mWvJAqJuT2DyUZPCVfNB2zSz/wgi5d0cyoIDP/MhQhwle4wHw7he05gxjqgyL9ta5xuMXrPycTkMahp318HiO2kBktCJZ2albNzgjwin6OrQDNDt/djggo9azr1CF9ACbOxbBiSfFRqK4qThhPTwhr/BubYiOQsA6rRXyAvOIQfm6rSW0XTVaMAEbwJTCYfPWhAC+x4akO00W70DJUuS6KXCau8Vxkrr32ZnBY7n/h0VIb/QdT3lxADq0wGt7CMz7NsoUxkeOK7uMchFMTNRxML6/wxLXHd3X1R0MFTdu7/NBY0ZGSfXIJbpP0kGJ65XKcNCZeAVaJpLoR30/p540rClVWU5bTDBRQ4Xu+59UAT+0I1s81fkbY0ZW6rZ1+KQI7R+5n3UKP0JQW2urPHvdqGoQ== k94lab"

USER_HOME="/home/$(logname)"
SSH_DIR="$USER_HOME/.ssh"
AUTH_KEYS="$SSH_DIR/authorized_keys"

# Create .ssh directory if it doesn't exist
mkdir -p "$SSH_DIR"
chmod 700 "$SSH_DIR"
chown $(logname):$(logname) "$SSH_DIR"

# Add the public key if not already present
grep -qxF "$PUB_KEY" "$AUTH_KEYS" 2>/dev/null || echo "$PUB_KEY" >> "$AUTH_KEYS"
chmod 600 "$AUTH_KEYS"
chown $(logname):$(logname) "$AUTH_KEYS"

# Enable and start SSH service
sudo systemctl enable ssh
sudo systemctl start ssh

echo "SSH authorized key added and SSH service enabled."