#!/bin/sh
name="$1"
if [[ $name =~ ^unite-.* ]]; then
  ptype='unite'
else
  ptype='unite'
fi
echo "${name} (${ptype})"

case "${name}" in
  unite*)
    bare_name=$(echo "${name}" | sed -e 's/^unite-//')
    echo 'mkdir -p "./autoload/unite/sources/"'
    mkdir -p "./autoload/unite/sources/"
    echo "...making initial './autoload/unite/sources/${bare_name}.vim'"
    echo 'hi' > "./autoload/unite/sources/${bare_name}.vim"
    echo 'mkdir -p "./doc/"'
    mkdir -p "./doc/"
    echo "...making initial './doc/${name}.txt'"
    echo 'hihi' > "./doc/${name}.txt"
    ;;
  *)
    echo "${name} Didn't match anything"
esac
