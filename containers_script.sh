#!/bin/sh

GREEN=$'\e[0;32m'
RED=$'\e[0;31m'
PINK=$'\e[0;35m'
RESET=$'\e[0m'

APP_CONTAINER=nj_client
GATEWAY_CONTAINER=nj_gateway
PRODUCT_CONTAINER=ng_product

build_packages() {
  echo "${RED}Building Client Packages and Scripts...${RESET}"
  cd ./client && npm install && npm run build ;
  cd .. ;
  echo "${RED}Building Gateway Packages and Scripts...${RESET}"
  cd ./services/api-gateway && npm install ;
  cd .. ;
  echo "${RED}Building Product Packages ...${RESET}"
  cd ./product && composer install && php artisan migrate && php artisan inventory:import && php artisan orders:import:new --skipProcessing ;
}

docker_menu () {
  PS3="${RESET}${PINK}Select a container and press enter: ${RESET}"
  options=("Client" "Gateway" "Product" "Cancel")
  opt
  select opt in "${options[@]}"
  do
    case "$REPLY" in
        1 )
            echo "${RED}Connecting to Client Container...${RESET}"
            docker exec -it $APP_CONTAINER bash
            break
            ;;
        2 )
            echo "${RED}Connecting to Gateway Container...${RESET}"
            docker exec -it $GATEWAY_CONTAINER bash
            break
            ;;
        3 )
            echo "${RED}Connecting to Product Container...${RESET}"
            docker exec -it $PRODUCT_CONTAINER bash
            break
            ;;
        4 )
            echo "${RED}Canceled${RESET}"
            break
            ;;
        *) echo "This is not a valid option, retry";;
      esac
  done
}

PS3="${RESET}${PINK}Select an option and press enter: ${RESET}"
OPTIONS=("Restart Containers" "Start Containers" "Stop Containers" "Connect to a Container" "Cancel");
select opt in "${OPTIONS[@]}"; do
    case "$REPLY" in
        1 )
            echo "${RED}Restarting Docker Containers...${RESET}"
            build_packages ;
            docker-compose restart;
            break
            ;;
        2 )
            echo "${RED}Starting Docker Containers...${RESET}"
            build_packages ;
            docker-compose up;
            break
            ;;
        3 )
            echo "${RED}Stopping Docker Containers...${RESET}"
            docker-compose down;
            break
            ;;
        4 )
            docker_menu
            break
            ;;
        5 )
            echo "${RED}Canceled${RESET}"
            break
            ;;
        *) echo "This is not a valid option, retry";;
    esac
done

