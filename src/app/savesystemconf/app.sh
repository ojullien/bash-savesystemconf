## -----------------------------------------------------------------------------
## Linux Scripts.
## SaveSystemConf app functions
##
## @package ojullien\bash\app\savesystemconf
## @license MIT <https://github.com/ojullien/bash-savesystemconf/blob/master/LICENSE>
## -----------------------------------------------------------------------------

SaveSystemConf::showHelp() {
    String::notice "Usage: $(basename "$0") [options] <directory 1> [directory 2 ...]"
    String::notice "\tSave a host-specific system-wide configuration located in /etc/"
    Option::showHelp
    String::notice "\t-d | --destination\tDestination folder. The default is /home/<user>"
    String::notice "\t<directory 1>\tConfiguration directory located in /etc/"
    return 0
}

SaveSystemConf::save() {

    # Parameters
    if (($# != 2)) || [[ -z "$1" ]] || [[ -z "$2" ]]; then
        String::error "Usage: SaveSystemConf::save <conf directory> <save directory>"
        return 1
    fi

    # Init
    local sSource="$1" sDestination="$2"
    local m_Save=""
    local -i iReturn=1

    # Source does not exist
    if [[ ! -d "${m_SYSTEM_CONFIGURATION_FOLDER}/${sSource}" ]]; then
        String::error "ERROR: Directory '${m_SYSTEM_CONFIGURATION_FOLDER}/${sSource}' does not exist!"
        return 1
    fi

    # Destination does not exist
    if [[ ! -d "${sDestination}" ]]; then
        String::error "ERROR: Destination '${sDestination}' does not exist!"
        return 1
    fi

    # Change directory
    cd "${m_SYSTEM_CONFIGURATION_FOLDER}" || return 18

    # Saving
    m_Save="${sDestination}/$(uname -n)-${sSource}-$(date +"%Y%m%d").tar.bz2"
    String::notice -n "Saving ${sSource} to ${m_Save}:"
    tar cjf "${m_Save}" "${sSource}"
    iReturn=$?
    String::checkReturnValueForTruthiness ${iReturn}

    # Go to previous directory
    cd - || return 18

    return ${iReturn}
}
