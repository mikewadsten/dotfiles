/usr/bin/VBoxClient-all &
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
exec awesome
