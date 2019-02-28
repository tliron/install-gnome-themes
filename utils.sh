#
# Messaging
#

BLUE='\033[0;34m'
CYAN='\033[0;36m'
RED='\033[0;31m'
RESET='\033[0m'

function message () {
	COLOR=${2:-$CYAN}
	echo -e "${COLOR}$@$RESET"
	if [ "$LOG" != '/dev/stdout' ]; then
		echo "$1" >> "$LOG"
	fi
}

function comma-separated () {
	local R
	for A in "$@"; do
		if [ -z "$R" ]; then
			R=$1
		else
			R="$R, $A"
		fi
	done
	echo $R
}

function sed-escape () {
	echo $1 | sed 's/[\/&]/\\&/g'
}

#
# Platform
#

function os-name () {
	local OS=$(lsb_release --id --short)
	if [ -z "$OS" ]; then
		OS=$(cat /etc/*-release | grep '^NAME=' | cut --delimiter='=' --fields=2 | sed -e 's/^"//' -e 's/"$//')
	fi
	if [ -z "$OS" ]; then
		OS=$(head -1 /etc/issue | cut --delimiter=' ' --fields=1)
	fi
	echo "$OS"
}

function gnome-version () {
	gnome-shell --version 2> /dev/null | cut --delimiter=' ' --fields=3 | cut --delimiter='.' --fields=1,2
}

function gtk-version () {
	local VERSION=$(dpkg-version libgtk-3-0)
	if [ -z "$VERSION" ]; then
		VERSION=$(dpkg-version libgtk2.0-0)
	fi
	if [ -z "$VERSION" ]; then
		VERSION=$(rpm-version gtk3)
	fi
	if [ -z "$VERSION" ]; then
		VERSION=$(rpm-version gtk2)
	fi
	if [ -z  "$VERSION" ]; then
		VERSION=$(pacman-version gtk3)
	fi
	echo "$VERSION"
}

function dpkg-version () {
	local PKG=$1
	dpkg -s "$PKG" 2> /dev/null | grep '^Version' | cut --delimiter=' ' --fields=2- | cut --delimiter='.' --fields=1,2
}

function rpm-version () {
	local PKG=$1
	rpm --query --queryformat %{VERSION} "$PKG" 2> /dev/null | cut --delimiter='.' --fields=1,2
}

function pacman-version () {
	local PKG=$1
	pacman -Si "$PKG" | grep Version | awk '{ print $3; }' | cut --delimiter='.' --fields=1,2
}


#
# Git Repositories
#

function repository-timestamp () {
	git log --max-count=1 --date=short --pretty=format:%cr
}

function repository-id () {
	git log --max-count=1 --pretty=format:%H
}

#
# Key-value
#

function get-value () { # [key] [db]
	local KEY=$1
	local DB=$2
	if [ -f "$DB" ]; then
		sed --quiet "s/^$KEY \(.*\)/\1/p" "$DB"
	fi
}

function set-value () { # [key] [value] [db]
	local KEY=$1
	local VALUE=$2
	local DB=$3
	if grep --quiet --no-messages "^$KEY " "$DB"; then
		sed --in-place "s/^\($KEY \)\(.*\)/\1$(sed-escape "$VALUE")/" "$DB" &>> "$LOG"
	else
		echo "$KEY $VALUE" >> "$DB"
	fi
}

#
# Themes
#

function prepare () { # [site] [account] [repo] [branch] [themes...]
	local SITE=$1
	local ACCOUNT=$2
	local REPO=$3
	local BRANCH=$4

	local URL="https://$SITE.com/$ACCOUNT/$REPO"
	local KEY="$SITE|$ACCOUNT|$REPO|$BRANCH"
	local LAST_ID=$(get-value "$KEY" "$CACHE_FILE")
	local NAMES=$(comma-separated "${@:5}")

	message "$NAMES:"

	message "  Fetching repository: $URL..."

	# Shallow git clone
	cleanup "$@"
	mkdir --parents "$WORK" &>> "$LOG"
	cd "$WORK"
	git clone "$URL" --branch "$BRANCH" --depth 1 "$REPO" &>> "$LOG"
	cd "$WORK/$REPO"

	CURRENT_ID=$(repository-id)
	if [ "$CURRENT_ID" == "$LAST_ID" ]; then
		message "  Last updated $(repository-timestamp)."
		message "  Already installed."
		cleanup "$@"
		return 1
	else
		message "  Last updated $(repository-timestamp)." "$BLUE"
		message "  Installing..." "$BLUE"
		if [ "$REPO" == Adapta ] ||
		   [ "$REPO" == arc-theme ] ||
		   [ "$REPO" == pocillo-gtk-theme ] ||
		   [ "$REPO" == plata-theme ] ||
		   [ "$ACCOUNT" == pop-os ]; then
			message "  WARNING: Installation takes an especially long time due to rendering of all assets, please be patient!" "$BLUE"
		fi
		cd "$THEMES"
		rm --recursive --force "${@:5}" &>> "$LOG"
		cd "$WORK/$REPO"
		return 0
	fi
}

function cleanup () { # [site] [account] [repo] [branch]
	local SITE=$1
	local ACCOUNT=$2
	local REPO=$3
	local BRANCH=$4

	local KEY="$SITE|$ACCOUNT|$REPO|$BRANCH"

	rm --recursive --force "$WORK/$REPO" &>> "$LOG"
	set-value "$KEY" "$CURRENT_ID" "$CACHE_FILE"
}

function theme-cp () { # [site] [account] [repo] [branch] [themes...]
	local SITE=$1
	local REPO=$3
	if ! prepare "$@"; then
		return
	fi
	cp --recursive "${@:5}" "$THEMES/" &>> "$LOG"
	cleanup "$@"
}

function theme-mv () { # [site] [account] [repo] [branch] [theme]
	local SITE=$1
	local REPO=$3
	local THEME=$5
	if ! prepare "$@"; then
		return
	fi
	mv "$WORK/$REPO" "$THEMES/$THEME" &>> "$LOG"
	cleanup "$@"
}

function theme-mv-dir () { # [site] [account] [repo] [branch] [theme]
	local SITE=$1
	local REPO=$3
	local THEME=$5
	if ! prepare "$1" "$2" "$3" "$4" "$(basename "$THEME")"; then
		return
	fi
	mv "$WORK/$REPO/$THEME" "$THEMES/" &>> "$LOG"
	cleanup "$@"
}

function theme-tarball () { # [site] [account] [repo] [branch] [file] [dir] [themes...]
	local SITE=$1
	local REPO=$3
	local FILE=$5
	local DIR=$6
	if ! prepare "$1" "$2" "$3" "$4" "${@:7}"; then
		return
	fi
	cd "$WORK/$REPO" &>> "$LOG"
	tar xvf "$FILE" "$DIR" &>> "$LOG"
	cd "$DIR" &>> "$LOG"
	mv * "$THEMES/" &>> "$LOG" 
	cleanup "$@"
}

function theme-execute () { # [site] [account] [repo] [branch] [file] [themes...]
	local SITE=$1
	local REPO=$3
	local FILE=$5
	if ! prepare "$1" "$2" "$3" "$4" "${@:6}"; then
		return
	fi
	cd "$WORK/$REPO" &>> "$LOG"
	chmod +x "$FILE" &>> "$LOG"
	"./$FILE" &>> "$LOG"
	cleanup "$@"
}

function theme-script () { # [site] [account] [repo] [branch] [script] [themes...]
	local SITE=$1
	local REPO=$3
	local SCRIPT=$5
	if ! prepare "$1" "$2" "$3" "$4" "${@:6}"; then
		return
	fi
	cd "$WORK/$REPO" &>> "$LOG"
	eval $SCRIPT &>> "$LOG"
	cleanup "$@"
}

function theme-make () { # [site] [account] [repo] [branch] [theme]
	local SITE=$1
	local REPO=$3
	local THEME=$5
	if ! prepare "$@"; then
		return
	fi
	make install INSTALL_DIR="$THEMES/$THEME" &>> "$LOG"
	cleanup "$@"
}

function theme-make-destdir () { # [site] [account] [repo] [branch] [theme]
	local SITE=$1
	local REPO=$3
	local THEME=$5
	if ! prepare "$@"; then
		return
	fi
	mkdir --parents "$WORK/$REPO/usr/share/themes" &>> "$LOG"
	make &>> "$LOG"
	make install DESTDIR="$WORK/$REPO" &>> "$LOG"
	cp --recursive "$WORK/$REPO/usr/share/themes/"* "$THEMES/" &>> "$LOG"
	cleanup "$@"
}

function theme-autogen-prefix () { # [site] [account] [repo] [branch] [themes...]
	local SITE=$1
	local REPO=$3
	if ! prepare "$@"; then
		return
	fi
	./autogen.sh --enable-parallel --prefix=$(pwd) $AUTOGEN_ARGS &>> "$LOG"
	make &>> "$LOG"
	# Adapta/Pop need to run "make install" separately
	make install &>> "$LOG"
	cp --recursive "$WORK/$REPO/share/themes/"* "$THEMES/" &>> "$LOG"
	cleanup "$@"
}

function theme-autogen-destdir () { # [site] [account] [repo] [branch] [themes...]
	local SITE=$1
	local REPO=$3
	if ! prepare "$@"; then
		return
	fi
	./autogen.sh --enable-parallel $AUTOGEN_ARGS &>> "$LOG"
	make install DESTDIR=$(pwd) &>> "$LOG"
	cp --recursive "$WORK/$REPO/usr/share/themes/"* "$THEMES/" &>> "$LOG"
	cleanup "$@"
}
