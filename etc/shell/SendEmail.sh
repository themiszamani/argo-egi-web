#!/bin/bash


SUBJECT="Recomputation request #$2"
URL=$3



if [ $# -eq 4 ]
  then
     /usr/sbin/sendmail -t "$4" << EOF
Return-Path: $1
Reply-To: $1
Subject: $SUBJECT
From: $1
Cc: $1

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