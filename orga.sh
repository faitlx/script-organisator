#!/bin/bash
#script d'organisation de répertoire
#Par faitlx
#v2.0 le 15/12/2020

#initialisation des arguments

if [ $# -eq 1 ]
then
	Destination=$1
	if [ ! -d $Destination ]
	then
		echo "Le répertoire passé en argument n'existe pas"
		return 2
		exit
	fi
else
 	echo "Il faut passer un répertoire en argument"
	return 2
	exit
fi

cd $Destination #On se rend dans le repertoire voulu

ls | grep -Eo "\..*$" | sort -u >> .listextension #on récupère les noms des extensions

for ext in $(cat .listextension) ; do
	ext1=$(echo $ext | tr -d ".")
	if [ ! -d TRI_$ext1 ]
	then
		mkdir TRI_$ext1
	fi
	find $PWD -type f -iname "*$ext" | grep -v "TRI_$ext1" >> .liste_tri_$ext1
	work=$(cat .liste_tri_$ext1)

	for file in $work
	do
		mv $file TRI_$ext1
	done
done

find $PWD -type d -empty -print -delete

rm .listextension
rm .liste_tri_*
exit 0
