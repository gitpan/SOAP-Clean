#! /usr/bin/env bash

# This file is placed in the public domain.

WSDL='cgifile:./soap-server.cgi?wsdl'
SERVER="./wsdl-client.pl -v -v -v $WSDL"

A='<a>123</a>'

########################################################################

echo "--------------------------------------------------"
echo "Usage"
echo "--------------------------------------------------"

$SERVER --usage

########################################################################

echo "--------------------------------------------------"
echo "Synchronous"
echo "--------------------------------------------------"

$SERVER Call sleep_for=0 w="$A" x=1 y=2

########################################################################

echo "--------------------------------------------------"
echo "Synchronous - test for namespaces in embedded XML"
echo "--------------------------------------------------"

$SERVER Call sleep_for=0 w="<a xmlns=\"urn:random\">123</a>" x=1 y=2

########################################################################

echo "--------------------------------------------------"
echo "Asynchronous"
echo "--------------------------------------------------"

$SERVER Spawn sleep_for=5 w="$A" x=1 y=2 uid:uid.txt

while $SERVER Running uid:uid.txt 'is_running?' ; do
     echo "Waiting..."
     sleep 1
done    

$SERVER Results uid:uid.txt

rm -f uid.txt

########################################################################

echo "--------------------------------------------------"
echo "Done"
echo "--------------------------------------------------"