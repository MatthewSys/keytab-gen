#!/bin/sh

USER=''
PASSWORD=''
SPN_LIST=''
KEYTAB_FILE="/etc/krb5.keytab"
KVNO=""
ENCTYPES="arcfour-hmac aes128-cts-hmac-sha1-96 aes256-cts-hmac-sha1-96"

rm -rf $KEYTAB_FILE

add_entry() {
   printf "%b" "addent -password -p $1 -k $2 -e $3\n$4\nwrite_kt $KEYTAB_FILE" | ktutil
}

for ENCTYPE in $ENCTYPES;do
   add_entry $USER $KVNO $ENCTYPE $PASSWORD
done

for ENCTYPE in $ENCTYPES;do
    for SPN in $SPN_LIST;do
        add_entry $SPN $KVNO $ENCTYPE $PASSWORD
    done
done
