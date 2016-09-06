#!/bin/bash

mldir="$HOME/.makeltx"
mlrc="$mldir/makeltx.rc"
mlpkg="$mldir/package-lists"
templates="$mldir/templates"

# Clean - for writing script only
rm -rf $mldir
if [ -d $mldir ] ; then
  echo "An installation already apperas to have taken place at $mldir."
  echo "    Remove it and retry."
  exit
fi

echo "Creating files..."
echo "$mldir/"
mkdir $mldir
echo "$mlrc"
touch $mlrc
echo "$templates/"
mkdir $templates
echo "$mlpkg/"
mkdir $mlpkg

echo "Setting up config file..."
echo "###############################################################################" > $mlrc
echo "###          MakeLTX configuration file. Edit at your own risk!!!           ###" >> $mlrc
echo "###############################################################################" >> $mlrc
echo "author:           $(whoami)" >> "$mlrc"
echo "organization:     Example Inc." >> "$mlrc"
echo "website:          example@example.com" >> "$mlrc"
echo "template-url:     http://benkushigian.com/makeltx/templates" >> "$mlrc"
echo "package-list-url: http://benkushigian.com/makeltx/package-list" >> "$mlrc"


echo "*** Catting $mlrc ***"
cat $mlrc

