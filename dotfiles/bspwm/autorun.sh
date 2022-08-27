# ----------------------------------------
#Autostart
#----------------------------------------

declare -A apps

apps=(
  [steam]="steam"
  [discord]="flatpak run com.discordapp.Discord"
  [spotify]="spotify"
  [eww daemon]="eww daemon"
  [noisetorch]="noisetorch -i"
  [flameshot]="flameshot"
  [solaar]="solaar -w hide"
  [lxpolkit]="lxpolkit"
)

# Detect if applications are already running. If not, start them.
for app in "${!apps[@]}"; do
  running="$(pgrep "$app")"

  if [[ ! "$running" ]]; then
    ${apps["$app"]} &
  fi

done
