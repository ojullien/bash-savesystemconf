#!/bin/bash
## -----------------------------------------------------------------------------
## Linux Scripts.
## Save host-specific system-wide configuration.
##
## @package ojullien\bash\bin
## @license MIT <https://github.com/ojullien/bash-savesystemconf/blob/master/LICENSE>
## -----------------------------------------------------------------------------
#set -o errexit
set -o nounset
set -o pipefail

## -----------------------------------------------------------------------------
## Shell scripts directory, eg: /root/work/Shell/src/bin
## -----------------------------------------------------------------------------
readonly m_DIR_REALPATH="$(realpath "$(dirname "$0")")"

## -----------------------------------------------------------------------------
## Load constants
## -----------------------------------------------------------------------------
# shellcheck source=/dev/null
. "${m_DIR_REALPATH}/../sys/constant.sh"

## -----------------------------------------------------------------------------
## Includes sources & configuration
## -----------------------------------------------------------------------------
# shellcheck source=/dev/null
. "${m_DIR_SYS}/runasroot.sh"
# shellcheck source=/dev/null
. "${m_DIR_SYS}/string.sh"
# shellcheck source=/dev/null
. "${m_DIR_SYS}/filesystem.sh"
# shellcheck source=/dev/null
. "${m_DIR_SYS}/option.sh"
# shellcheck source=/dev/null
. "${m_DIR_SYS}/config.sh"
Config::load "savesystemconf"
# shellcheck source=/dev/null
. "${m_DIR_APP}/savesystemconf/app.sh"

## -----------------------------------------------------------------------------
## Help
## -----------------------------------------------------------------------------
((m_OPTION_SHOWHELP)) && SaveSystemConf::showHelp && exit 0
(( 0==$# )) && SaveSystemConf::showHelp && exit 1

## -----------------------------------------------------------------------------
## Start
## -----------------------------------------------------------------------------
String::separateLine
String::notice "Today is: $(date -R)"
String::notice "The PID for $(basename "$0") process is: $$"
Console::waitUser

## -----------------------------------------------------
## Parse the app options and arguments
## -----------------------------------------------------
declare -i iReturn=1
declare sPWD sDestination="${m_SAVESYSTEMCONF_DESTINATION_DEFAULT}"
sPWD=$(pwd)

while (( "$#" )); do
    case "$1" in
    -d|--destination) # app option
        sDestination="$2"
        shift 2
        FileSystem::checkDir "The destination directory is set to:\t${sDestination}" "${sDestination}"
        ;;
    -t|--trace)
        shift
        String::separateLine
        Constant::trace
        SaveSystemConf::trace
        iReturn=0
        ;;
    --*|-*) # unknown option
        shift
        String::separateLine
        SaveSystemConf::showHelp
        exit 0
        ;;
    *) # We presume its a /etc/conf directory
        String::separateLine
        SaveSystemConf::save "$1" "${sDestination}"
        iReturn=$?
        ((0!=iReturn)) && exit ${iReturn}
        shift
        Console::waitUser
        ;;
    esac
done

## -----------------------------------------------------------------------------
## END
## -----------------------------------------------------------------------------
String::notice "Now is: $(date -R)"
exit 0
