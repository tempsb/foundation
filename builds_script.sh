#!/bin/sh

GREEN=$'\e[0;32m'
RED=$'\e[0;31m'
PINK=$'\e[0;35m'
RESET=$'\e[0m'

PS3="${RESET}${PINK}Select an option and press enter: ${RESET}"
OPTIONS=("Watch Client JS Files" "Watch Gateway Files"  "Cancel");
select opt in "${OPTIONS[@]}"; do
    case "$REPLY" in
        1 )
            echo "${RED}Watching Client JS Files...${RESET}"
            cd ./client && npm run watch
            break
            ;;
        2 )
            echo "${RED}Watching Gateway JS Files...${RESET}"
            cd ./services/api-gateway && npm run watch
            break
            ;;
        3 )
            echo "${RED}Canceled${RESET}"
            break
            ;;
        *) echo "This is not a valid option, retry";;
    esac
done

