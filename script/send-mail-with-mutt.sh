#!/bin/sh

# Desc:shell script for sending mail with mutt
# Author:J.S. Aulakh
# Mail:tune2rhca@gmail.com


# check mutt 
mutt=$(which mutt)

if [ "$mutt" == "" ];then
	yum -y install mutt
fi

from="sender@example.com"
# more receiver like a@example.com b@example.com ...
to=( "reciever@example.com" )
subject="Your email title"
#you can also read content from the file just use $(cat yourfile)
body="This is body content of your email"

declare -a attachments
attachments=( "a.pdf" "b.zip" )

# deal with attachments
declare -a attargs
for att in "${attachments[@]}"; do
  [ ! -f "$att" ] && echo "Warning: attachment $att not found, skipping" >&2 && continue
  attargs+=( "-a"  "$att" )
done


# send using mutt
mutt -e "set from=$from" -s "$subject" "$attargs" -- "${to[@]}" <<< "$body"  
