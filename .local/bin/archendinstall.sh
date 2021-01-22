#!/bin/sh

echo "Add fuzzbox crontab"
echo "*/1 * * * * /home/fuzzbox/.local/bin/check_upgrades
*/2 * * * * /home/fuzzbox/.local/bin/low_bat_notify
*/2 * * * * /home/fuzzbox/.local/bin/low_internal_bat_notify" > /var/spool/cron/fuzzbox

echo "Add root crontab"
echo "*/15 * * * * /usr/bin/pacman -Sy >> /dev/null 2>&1" > /var/spool/cron/root

echo "Configure pam for fingerprint"
echo "auth sufficient pam_fprintd.so" >> /etc/pam.d/system-auth
echo "auth sufficient pam_fprintd.so" >> /etc/pam.d/system-login
echo "auth sufficient pam_fprintd.so" >> /etc/pam.d/system-local-login
echo "auth sufficient pam_fprintd.so" >> /etc/pam.d/sudo

echo "Configuring tty1 auto-login"
mkdir -p /etc/systemd/system/getty@tty1.service.d/
echo "
[Service]
ExecStart=
ExecStart=-/usr/bin/agetty --autologin fuzzbox --noclear %I $TERM" > /etc/systemd/system/getty@tty1.service.d/override.conf

