#!/usr/bin/env bash

#################################
# include the -=magic=-
# you can pass command line args
#
# example:
# to disable simulated typing
# . ../demo-magic.sh -d
#
# pass -h to see all options
#################################
. ./utils/demo-magic.sh
DEMO_PROMPT="${GREEN}➜${CYAN}[heroes]$ ${COLOR_RESET}"
TYPE_SPEED=20
USE_CLICKER=true

# Define colors
BLUE='\033[38;2;102;204;255m' #'\033[38;5;153m' #'\033[0;34m'
GREEN='\033[38;5;41m' #'\033[0;32m'
YELLOW='\033[0;33m'
RESET='\033[0m'

# ------------------------------------
# 1.  SUPPRESS DEPRECATION WARNINGS
# ------------------------------------
oc() {                          # wrapper
    command oc "$@" 2>&1 | sed '/^Warning:/d'
    return ${PIPESTATUS[0]}     # preserve oc’s exit status
}
export -f oc                    # if demo-magic forks subshells

# Function to print lines with color based on their content
print_colored_output() {
    while IFS= read -r line; do
        if [[ $line == skipping:* || $line == included:* ]]; then
            echo -e "${BLUE}${line}${RESET}"
        elif [[ $line == ok:* ]]; then
            echo -e "${GREEN}${line}${RESET}"
        elif [[ $line == changed:* ]]; then
            echo -e "${YELLOW}${line}${RESET}"
        else
            echo "$line"
        fi
    done
}

# Hide the evidence
clear

# Enter the ansible directory
wait
figlet -f starwars -S "demo"| lolcat -a -s 100
wait
redhatsay "Lets deploy a vm using GitOps"
wait
echo -e "\n"
viu images/ocp-v-gitops.png
wait
echo -e "\n"
pei "oc get vms -n dell-heroes"
wait
echo -e "\n"
pei "tree vms"
echo -e "\n"
wait
pei "cat vms/application.yaml"
echo -e "\n"
wait
pei "cat vms/fedora-vlan.yaml"
echo -e "\n"
wait
pei "oc apply -f vms/application.yaml"
echo -e "\n"
wait
pei "oc get vm -n dell-heroes"
echo -e "\n"
wait
cowsay "Yay, it's there"
wait
clear
figlet -f starwars -S "end of demo"| lolcat -a -s 100
wait
