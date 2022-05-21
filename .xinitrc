xcape -e 'Super_L=Escape;Caps_Lock=Escape'
SSH_ASKPASS="$HOME/scripts/ssh-secret-service.sh" SSH_ASKPASS_REQUIRE=prefer exec ssh-agent dbus-launch i3

# vim: ft=sh
