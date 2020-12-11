#!/bin/bash
#travail en cours sur script d'organisation de répertoire

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

ls | grep -Eo "\..+$" | sort -u >> .listextension #on récupère les noms des extensions
cat .listextension | tr -d "." >> .listextension2 #On enlève les points
rm .listextension

for ext in $(cat .listextension2) ; do
	if [ ! -d TRI_$ext ]
	then
		mkdir TRI_$ext
	fi
	find $PWD -type f -iname "*.$ext" | grep -v "TRI_$ext" >> .liste_tri_$ext
	work=$(cat .liste_tri_$ext)

	for file in $work
	do
		mv $file TRI_$ext
	done
done
rm .listextension2
rm .liste_tri_*
exit 0
