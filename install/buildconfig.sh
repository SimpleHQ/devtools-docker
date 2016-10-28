function minimal_apt_get_install()
{
	if [[ ! -e /var/lib/apt/lists/lock ]]; then
		apt-get update
	fi
	apt-get install -y --no-install-recommends "$@"
}

function header()
{
	local title="$1"
	echo "${BLUE_BG}${YELLOW}${BOLD}${title}${RESET}"
	echo "------------------------------------------"
}

function run()
{
	echo "+ $@"
	"$@"
}
