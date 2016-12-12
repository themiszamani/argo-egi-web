#!/bin/bash


SUBJECT="Recomputation request #$2"
URL=$3
EMAIL="$1,$4"



if [ $# -eq 5 ]
  then
     /usr/bin/mail "$EMAIL"  -s $SUBJECT  -S "reply-to=$5"  -S "From=$5" << EOF

Dear User,

Your recomputation request has been registered :
$URL

ARGO Team

-- Mail generated automatically by the ARGO application
EOF
    echo "<EmailSent><param>$1</param><param>$2</param><param>$3</param><param>$4</param><param>$5</param></EmailSent>"  |& tee -a logMail.log ;
else
    echo "<Error><param>$1</param><param>$2</param><param>$3</param><param>$4</param><param>$5</param></Error>" |& tee -a logMail.log ;
fi