#
# Messaging
#

BLUE='\033[0;34m'
CYAN='\033[0;36m'
RED='\033[0;31m'
RESET='\033[0m'

function message()
{
	COLOR=${2:-$CYAN}
	echo -e "${COLOR}$@$RESET"
	if [ "$LOG" != '/dev/stdout' ]; then
		echo "$1" >> "$LOG"
	fi
}

function comma-separated()
{
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

#
# Platform
#

function os-name()
{
	local OS=$(lsb_release --id --short)
	if [ -z "$OS" ]; then
		OS=$(cat /etc/*-release | grep '^NAME=' | cut --delimiter='=' --fields=2 | sed -e 's/^"//' -e 's/"$//')
	fi
	if [ -z "$OS" ]; then
		OS=$(head -1 /etc/issue | cut --delimiter=' ' --fields=1)
	fi
	echo "$OS"
}

function gnome-version()
{
	gnome-shell --version 2>/dev/null | cut --delimiter=' ' --fields=3 | cut --delimiter='.' --fields=1,2
}

function gtk-version()
{
	local VERSION=$(dpkg-version libgtk-3-0)
	if [ -z "$VERSION" ]; then
		VERSION=$(dpkg-version libgtk2.0-0)
	fi
	echo "$VERSION"
}

function dpkg-version()
{
	local PKG=$1
	dpkg -s "$PKG" 2>/dev/null | grep '^Version' | cut --delimiter=' ' --fields=2- | cut --delimiter='.' --fields=1,2
}

#
# Git Repositories
#

function repository-timestamp()
{
	git log --max-count=1 --date=short --pretty=format:%cr
}

function repository-id()
{
	git log --max-count=1 --pretty=format:%H
}

#
# Key-value
#

function get-value() # [key] [db]
{
	local KEY=$1
	local DB=$2
	if [ -f "$DB" ]; then
		sed --quiet "s/^$KEY \(.*\)/\1/p" "$DB"
	fi
}

function set-value() # [key] [value] [db]
{
	local KEY=$1
	local VALUE=$2
	local DB=$3
	if grep --quiet --no-messages "^$KEY " "$DB"; then
		sed --in-place "s/^\($KEY \)\(.*\)/\1$VALUE/" "$DB"
	else
		echo "$KEY $VALUE" >> "$DB"
	fi
}

#
# Themes
#

function prepare() # [account] [repo] [branch] [themes...]
{
	local ACCOUNT=$1
	local REPO=$2
	local BRANCH=$3

	local URL="https://github.com/$ACCOUNT/$REPO"
	local KEY="$ACCOUNT|$REPO|$BRANCH"
	local LAST_ID=$(get-value "$KEY" "$CACHE_FILE")
	local NAMES=$(comma-separated "${@:4}")

	message "Fetching repository: $URL..."

	# Shallow git clone
	cleanup "$REPO"
	mkdir --parents "$WORK"
	cd "$WORK"
	git clone "$URL" --branch "$BRANCH" --depth 1 "$REPO" &>> "$LOG"
	cd "$WORK/$REPO"

	local CURRENT_ID=$(repository-id)
	if [ "$CURRENT_ID" == "$LAST_ID" ]; then
		message "$NAMES:"
		message "  Last updated $(repository-timestamp)."
		message "  Already installed."
		cleanup "$REPO"
		return 1
	else
		message "$NAMES:" "$BLUE"
		message "  Last updated $(repository-timestamp)." "$BLUE"
		message "  Installing..." "$BLUE"
		if [ "$REPO" == Adapta ] || [ "$REPO" == pop-gtk-theme ]; then
			message "  WARNING: Installation takes an especially long time due to rendering of all assets, please be patient!" "$BLUE"
		fi
		set-value "$KEY" "$CURRENT_ID" "$CACHE_FILE"
		cd "$THEMES"
		rm --recursive --force "${@:4}"
		cd "$WORK/$REPO"
		return 0
	fi
}

function cleanup() # [repo]
{
	local REPO=$1
	rm --recursive --force "$WORK/$REPO"
}

function theme-cp() # [account] [repo] [branch] [themes...]
{
	local REPO=$2
	if ! prepare "$@"; then
		return
	fi
	cp --recursive "${@:4}" "$THEMES/"
	cleanup "$REPO"
}

function theme-mv() # [account] [repo] [branch] [theme]
{
	local REPO=$2
	local THEME=$4
	if ! prepare "$@"; then
		return
	fi
	mv "$WORK/$REPO" "$THEMES/$THEME"
	cleanup "$REPO"
}

function theme-run() # [account] [repo] [branch] [cmd]
{
	local REPO=$2
	local COMMAND=$4
	if ! prepare "$@"; then
		return
	fi
	cd "$WORK/$REPO"
	"./$COMMAND" &>> "$LOG"
	cleanup "$REPO"
}

function theme-make() # [account] [repo] [branch] [theme]
{
	local REPO=$2
	local THEME=$4
	if ! prepare "$@"; then
		return
	fi
	make install INSTALL_DIR="$THEMES/$THEME" &>> "$LOG"
	cleanup "$REPO"
}

function theme-autogen-prefix() # [account] [repo] [branch] [themes...]
{
	local REPO=$2
	if ! prepare "$@"; then
		return
	fi
	./autogen.sh --enable-parallel --prefix=$(pwd) $AUTOGEN_ARGS &>> "$LOG"
	make &>> "$LOG"
	# Adapta/Pop need to run "make install" separately
	make install &>> "$LOG"
	cp --recursive "$WORK/$REPO/share/themes/"* "$THEMES/"
	cleanup "$REPO"
}

function theme-autogen-destdir() # [account] [repo] [branch] [themes...]
{
	local REPO=$2
	if ! prepare "$@"; then
		return
	fi
	./autogen.sh --enable-parallel $AUTOGEN_ARGS &>> "$LOG"
	make install DESTDIR=$(pwd) &>> "$LOG"
	cp --recursive "$WORK/$REPO/usr/share/themes/"* "$THEMES/"
	cleanup "$REPO"
}

