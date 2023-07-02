PREFIX = /usr/local

SCRIPTS =       addressgrep \
		battery-checknow \
		battery-status \
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
		feed \
		ffmpeg-screenrecord \
		ffmpeg-facecam \
		mail-compose \
		mergepdf \
		notify \
		open-file \
		open-stdin \
		open-url \
		popup-cal12 \
		popup-cal3 \
		popup-terminal \
		secret \
		sel \
		sfeed-browser \
		share \
		spawn \
		status \
		templess \
		terminal \
		translate \
		trash \
		urlgrep \
		virename \
		websearch \
		xedit \
		xedit-filter \
		xplumb \
		xprop-active-window-id \
		xroot-update \
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
