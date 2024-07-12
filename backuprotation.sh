#!/bin/bash

<< readme
 this is a Script with rotation of 5 days 

 Useage:
  ./backup.sh <path to your source > < path to backup folder>

readme 

function  display_usage {

   echo " Useage:
  ./backup.sh <path to your source > < path to backup folder>"
}

if [ $# -eq 0 ]; then 
        display_usage
fi

source_dir=$1
timestamp=$(date '+%Y-%m-%d-%H-%M-%S')
backupdir=$2

function create_backup {

    zip -r "${backupdir}/backup_${timestamp}.zip" "${source_dir}" > /dev/null

    if [ $? -eq 0 ];then
              echo "backup generated successfully for ${timestamp}"
    fi
}
function perform_rotation {
    backups=($(ls -t "${backupdir}/backup_"*.zip 2>/dev/null))
    echo "${backups[@]}"

    if [ "${#backups[@]}"  -gt 5 ];then

        echo " performing backups rotation "

        backups_to_remove=("${backups[@]:5}")
        echo "${backups_to_remove}"

        for backup in "${backups_to_remove[@]}";
        do
              rm -f ${backup}
        done
    fi 
  echo "backup cleanup is uptodate"
}
create_backup
perform_rotation