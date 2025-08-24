#!/usr/bin/env bash
# This bash script makes it easy to launch Textractor and hook into Steam games
# Two free Japanese Visual Novels are included to provide a sample of the
# format. You will likely need to add your own games here unless the defaults
# work for every game you play and you prefer using the appid.
if [[ -z $1 ]]; then
    echo "No appid or name."
else
    # Set the default Proton and Textractor here. Typically the latest Proton
    # and the 32 bit version Textractor.
    # You can override it for a specific app if needed.
    proton="$HOME/.steam/debian-installation/steamapps/common/Proton 9.0 (Beta)"
    textractor="/path/to/default/textractor"
    # Set the default compat data path here (where all the wine prefixes are).
    # You only need to override this on a per-game basis if you install your
    # games on different drives.
    compat_data_path="$HOME/.steam/debian-installation/steamapps/compatdata/"
    case "$1" in
    	# If a different version of Proton/Textractor/Compat data path is needed,
    	# make sure to include the appid in the match too,
    	# otherwise it'll default to fallback below.
        "Narcissu"|"264380")
            appid="264380"
            # Example of how to override
            proton="$HOME/.steam/debian-installation/steamapps/common/Proton - Experimental"
    		textractor="/path/to/other/textractor"
            
        ;;
        # Use whatever name works for you, no need to type the full name out
        "Higurashi 1")
        	appid="310360"
        ::
        # If no other matches, fall back on using the App ID.
        *)
            appid="$1"
        ;;
    esac
    # compat data
    export STEAM_COMPAT_DATA_PATH="$compat_data_path/$appid"
    export WINEPREFIX="$STEAM_COMPAT_DATA_PATH/pfx"
    cmd=("$proton" runinprefix "$textractor")    
    "${cmd[@]}"
fi
