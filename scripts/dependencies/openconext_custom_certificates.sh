#!/bin/bash

# CA_KEY_PASSWORD is set in oc_config

KEY_DIR=/etc/httpd/keys

CA_DIR=/opt/www/openconext-ca
mkdir -p $CA_DIR

echo "handling certificates for the domain $OC_DOMAIN."

rm -rf /etc/httpd/keys/* &&
install -d /etc/httpd/keys &&
mkdir -p $CA_DIR
  
case "$CERTCHOICE" in
  "1" ) generate_new_certs ;;
  "2" ) explain_bring_your_own ;;
  * )  generate_new_certs ;;
esac

# make the CA trust store available for the welcome page (and thus the browser)
cp $KEY_DIR/openconext_ca.pem /opt/www/welcome/openconext_ca.crt

# Make certificate/key available for other script parts, as variables
OC_CACERT=`sed -e '1d;$d' $KEY_DIR/openconext_ca.pem | tr -d '\n'`
OC_CERT=`sed -e '1d;$d' $KEY_DIR/openconext.pem | tr -d '\n'`
OC_KEY=`sed -e '1d;$d' $KEY_DIR/openconext.key | tr -d '\n'`
