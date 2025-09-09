#!/bin/bash
# Description: This script organizes files in a specified directory into subdirectories based on their file types.

# Choosing the working directory
DIR=${1:-.}

#checking if directory exists
if [ ! -d "$DIR" ]; 
then 
  echo "Directory $DIR does not exist."
  exit 1
else
  echo "Directory $DIR exists."
  echo "Let's start working on it."
fi

#Defining extension groups for categorization
declare -A groups
groups=(
    [Documents]="txt pdf doc docx odt rtf"
    [Images]="jpg jpeg png gif bmp svg"
    [Music]="mp3 wav flac aac"
    [Videos]="mp4 mkv avi mov"
    [Archives]="zip tar gz bz2 rar 7z"
    [Scripts]="sh py js php rb pl"
)

#Loop through files
for file in "$DIR"/*; do
    [ -e "$file" ] || continue
    [ -d "$file" ] && continue

#Finding file name and extension
    filename=$(basename -- "$file")
    extension="${filename##*.}"

#Handling files without extensions Filename is equal to extension
    if [ "$filename" = "$extension" ]; then
        extension="others"
    fi

#Find matching category
    folder="Others"
    for category in "${!groups[@]}"; do
        for ext in ${groups[$category]}; do
            if [[ "$extension" == "$ext" ]]; then
                folder="$category"
                break 2  
            fi
        done
    done

#Create folder if not exists and moveing file
    mkdir -p "$DIR/$folder"
    mv "$file" "$DIR/$folder/"
    echo "Moved: $filename → $folder/"
done

echo "✅ Organization complete with grouped categories!"
