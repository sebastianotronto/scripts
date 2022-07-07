PREFIX = /usr/local

SCRIPTS =       addressgrep \
		battery-checknow \
		battery-status \
		brightness \
		clip \
		config-backup \
		cth \
		dmenu-bookmarks \
		dmenu-dwm-sessionmanager \
		dmenu-filepicker \
		dmenu-mail-aliases \
		dmenu-screenshot \
		dmenu-unmount \
		dmenu-urlselect \
		dmenu-websearch \
		ffmpeg-screenrecord \
		ffmpeg-facecam \
		mail-compose \
		notify-status \
		open-file \
		open-stdin \
		open-url \
		popup-cal12 \
		popup-cal3 \
		popup-terminal \
		secret \
		sel \
		sfeed-browser \
		spawn \
		status \
		templess \
		terminal \
		togglemute \
		translate \
		trash \
		urlgrep \
		virename \
		volume \
		websearch \
		xedit \
		xedit-filter \
		xplumb \
		xprop-active-window-id \
		xwallpaper-random-notify

all: install

install:
	for s in ${SCRIPTS}; do\
		cp -f $$s ${DESTDIR}${PREFIX}/bin ; \
		chmod 755 ${DESTDIR}${PREFIX}/bin/$$s ; \
	done

uninstall:
	for s in ${SCRIPTS}; do rm -rf ${DESTDIR}${PREFIX}/bin/$$s ; done

.PHONY: all install uninstall
