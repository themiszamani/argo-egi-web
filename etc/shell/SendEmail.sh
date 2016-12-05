#!/bin/bash


SUBJECT="Recomputation request #$2"
URL=$3
EMAIL="$1,$4"



if [ $# -eq 4 ]
  then
     /usr/bin/mail "$EMAIL"  -s "$SUBJECT"  -a "FROM: $1"  << EOF

Dear User,

Your recomputation request has been registered :
$URL

ARGO Team

-- Mail generated automatically by the ARGO application
EOF
    echo "<EmailSent>The email has been sent</EmailSent>";
else
    echo "<Error>The Email has not been sent</Error>";
fi

