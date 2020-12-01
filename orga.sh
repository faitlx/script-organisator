#!/bin/bash

ls | grep -Eo "\..+$" >> .listextension
cat .listextension | tr -d "." >> .listextension2
rm .listextension
for ext in $(cat .listextension2) ; do 
	if [ ! -d TRI_$ext ]
	then
		mkdir TRI_$ext
	fi
done
rm .listextension2
