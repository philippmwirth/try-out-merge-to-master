#!/usr/bin/env bash
CURRBRANCH=$(git rev-parse --abbrev-ref HEAD)
if [ $CURRBRANCH = "main" ]
then
	echo "Already on master, aborting..."
	exit 1
fi

while true; do
	read -p "Merging $CURRBRANCH into main... Continue? y/n " yn
	case $yn in
		[Yy]* ) break;;
		[Nn]* ) exit;;
		* ) echo "Please answer y/n";;
	esac
done

git checkout main && git rebase origin/main
git merge --ff-only $CURRBRANCH && git log | less
echo "Done"
