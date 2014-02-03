/usr/bin/VBoxClient-all &
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
# exec awesome

if [ x$1 != x ]; then
    exec $1
else
    exec cinnamon-session
fi
