#!/bin/bash

showhelp () {
cat << EOF

This script creates a skeleton for a new module based on different Example42 foo module templates.
Run it from the directory that contains the foo module (moduledir).

By default it uses the "foo" module as template. Specify -t <source_module> to use a different template.

Example:
$0 -t foo-app

EOF
}

template="foo"

while [ $# -gt 0 ]; do
  case "$1" in
    -t)
      template=$2
      shift 2 ;;
  esac
done

showhelp

if [ ! -f $template/manifests/init.pp ] ; then
    echo "I don't find $template/manifests/init.pp "
    echo "Run this script from the base modules directory and specify a valid source module template"
    exit 1
fi

OLDMODULE="$template"
OLDMODULESTRING="$template"
echo
echo "Source module template is $template "
echo -n "Enter the name of the new module based on $template: "
read NEWMODULE

echo "COPYING MODULE"
mkdir $NEWMODULE
rsync -av --exclude=".git" $OLDMODULE/* $NEWMODULE/


echo "RENAMING FILES"
for file in $( find $NEWMODULE | grep $OLDMODULESTRING ) ; do 
	newfile=`echo $file | sed -e "s/$OLDMODULESTRING/$NEWMODULE/"`
	mv "$file" "$newfile" && echo "Renamed $file to $newfile"
done

echo "---------------------------------------------------"
echo "CHANGING FILE CONTENTS"
for file in $( grep -R $OLDMODULESTRING $NEWMODULE | cut -d ":" -f 1 | uniq ) ; do 
	sed -i "s/$OLDMODULESTRING/$NEWMODULE/g" $file && echo "Changed $file" # Use under Linux
	# sed -i "" -e "s/$OLDMODULESTRING/$NEWMODULE/g" $file && echo "Changed $file" # Use under MacOS
done

echo "Module $NEWMODULE created"
echo "Start to edit $NEWMODULE/manifests/params.pp to customize it"
