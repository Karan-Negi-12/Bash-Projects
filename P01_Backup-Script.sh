#!/bin/bash 

# Description: This script creates a backup of a specified directory and saves it to a designated backup location.

# Usage: ./P01_Backup-Script.sh /path/to/source /path/to/backup

SOURCE_DIR="$1"
BACKUP_DIR="$2"
DATE=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_NAME="backup_${DATE}.tar.gz"

# Check if source directory is provided
if [ -z "$SOURCE_DIR" ] || [ -z "$BACKUP_DIR" ]; then
    echo "Usage: $0 /path/to/source /path/to/backup"
    exit 1
fi

# Check if source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Source directory does not exist: $SOURCE_DIR"
    exit 2
fi

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Create the backup
tar -czf "$BACKUP_DIR/$BACKUP_NAME" -C "$SOURCE_DIR" .

if [ $? -eq 0 ]; then
    echo "Backup successful: $BACKUP_DIR/$BACKUP_NAME"
else
    echo "Backup failed."
    exit 3