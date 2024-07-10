#!/bin/bash

# modified from https://stackoverflow.com/a/74823523

S3CMD=/usr/bin/s3cmd

while getopts s:r: flag
do
  case "${flag}" in
    s) server=${OPTARG};;
    r) retention=${OPTARG};;
  esac
done

if [ -z ${server+x} ];
then
  echo "please specify the server name (ie, cobalt) using the -s flag"
  exit 1
fi

if [ -z ${retention+x} ];
then
  retention=30
fi

echo "cleaning up old backups on $server s3 bucket"

$S3CMD ls --recursive s3://wp-$server-daily-backups | while read -r line;
  do
    createDate=`echo $line|awk {'print $1" "$2'}`
    createDate=`date -d"$createDate" +%s`
    olderThan=`date --date "$retention days ago" +%s`

    if [[ $createDate -lt $olderThan ]]
      then
        fileName=`echo $line|awk {'print $4'}`

          if [[ $fileName != "" ]]
            then
              s3cmd rm $fileName
          fi
    fi

  done;