#!/bin/bash

EMAIL="$1,$4"
SUBJECT="Recomputation request $2"
URL=$3
BODY="Dear Admins and user,\nA new recomputation request has been registered :\n$URL\n\n-- Mail generated automatically by the ARGO application"
CC=$4

if [ $# -eq 4 ]
  then
    echo "$BODY" | /usr/bin/mail "$EMAIL"  -s "$SUBJECT"  -a "FROM: $1" ;
    echo "<EmailSent></EmailSent>";
else
    echo "<Error>The number of parameters is not correct</Error>";
 fi




