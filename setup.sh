#!/bin/bash

### Only for use on UNIX systems. For windows, download explicitly
mldir="$HOME/.makeltx"
mlrc="$mldir/makeltx.rc"
mlpkg="$mldir/package-lists"
templates="$mldir/templates"
url="http://benkushigian.com/makeltx"

#echo "Creating files..."
#echo "$mldir/"
#mkdir $mldir
#echo "$mlrc"
#touch $mlrc
#echo "$templates/"
#mkdir $templates
#echo "$mlpkg/"
#mkdir $mlpkg

echo "Setting up config file..."
echo "###############################################################################" > $mlrc
echo "###          MakeLTX configuration file. Edit at your own risk!!!           ###" >> $mlrc
echo "###############################################################################" >> $mlrc
echo "author:           $(whoami)" >> "$mlrc"
echo "organization:     Example Inc." >> "$mlrc"
echo "website:          example@example.com" >> "$mlrc"
echo "template-url:     http://benkushigian.com/makeltx/templates" >> "$mlrc"
echo "package-list-url: http://benkushigian.com/makeltx/package-list" >> "$mlrc"

if [ -d $mldir ] ; then
  echo "Pulling down $mldir/templates.tar.gz..."
  wget -O "$mldir/templates.tar.gz" "$url/templates/templates.tar.gz"
  echo "Extracting tarball to $mldir/templates"
  tar -xzvf $mldir/templates.tar.gz $mldir/templates
  echo "Deleting tarball"
  rm $mldir/templates.tar.gz
else
  echo "Error, couldn't find $mldir directory. Is it writeable?"
  exit
fi

echo "Install completed, welcome to MakeLTX - the latex template generator!!!"

