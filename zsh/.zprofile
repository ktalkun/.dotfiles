export PATH=~/.local/bin:$PATH					# add bin files of powerline (f.ex. powerline-config, powerline-daemon)
# Запуск демона powerline. Необходимо, чтобы не было прерываний при зажатии комбинации Ctrl+C
powerline-daemon -q						# run powerline-daemon to fix the interruption error connected with hold down CTRL+C

# Tex Live 
export PATH=/usr/local/texlive/2019/bin/x86_64-linux:$PATH
export MANPATH=/usr/local/texlive/2019/texmf-dist/doc/man:$MANPATH
export INFOPATH=/usr/local/texlive/2019/texmf-dist/doc/info:$INFOPATH

# Add dirs with desktop files (for i3)
export XDG_DATA_DIRS=/usr/local/share:/usr/share:$XDG_DATA_DIRS

# Snap (for i3)
export PATH=/snap/bin:$PATH					# add bin files of snap's apps to have access from terminal and default dmenu (rofi)
export XDG_DATA_DIRS=/var/lib/snapd/desktop:$XDG_DATA_DIRS	# add desktop files of snap's apps to have access form dmenu (rofi) in desktop mode
