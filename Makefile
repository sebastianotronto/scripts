PREFIX = /usr/local

SCRIPTS =       addressgrep \
		alg \
		battery-checknow \
		battery-status \
		clip \
		config-backup \
		cth \
		cubeviz \
		dmenu-bookmarks \
		dmenu-dwm-sessionmanager \
		dmenu-filepicker \
		dmenu-screenshot \
		dmenu-unmount \
		dmenu-urlselect \
		event \
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
		share \
		spawn \
		status \
		status-openbsd \
		status-void \
		templess \
		terminal \
		trash \
		urlgrep \
		virename \
		xedit \
		xedit-filter \
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
