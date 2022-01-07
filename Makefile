PREFIX = /usr/local

SCRIPTS =       addressgrep \
		backup-config \
		battery-checknow \
		battery-status \
		brightness \
		dmenu-bookmarks \
		dmenu-dwm-sessionmanager \
		dmenu-filepicker \
		dmenu-mail-aliases \
		dmenu-screenshot \
		dmenu-unmount \
		dmenu-urlselect \
		dmenu-websearch \
		dunst-toggle \
		mail-checknow \
		mail-compose \
		notify-battery \
		notify-time \
		open-file \
		open-stdin \
		open-url \
		popup-cal12 \
		popup-cal3 \
		popup-terminal \
		sfeed-browser \
		spawn \
		templess \
		togglemute \
		translate \
		trashrm \
		trashempty \
		urlgrep \
		volume \
		websearch \
		xedit-filter \
		xkboptions \
		xplumb \
		xprop-active-window-id \
		xwallpaper-random-notify

install:
	for s in ${SCRIPTS}; do\
		cp -f $$s ${DESTDIR}${PREFIX}/bin ; \
		chmod 755 ${DESTDIR}${PREFIX}/bin/$$s ; \
	done

uninstall:
	for s in ${SCRIPTS}; do rm -rf ${DESTDIR}${PREFIX}/bin/$$s ; done

.PHONY: install uninstall
