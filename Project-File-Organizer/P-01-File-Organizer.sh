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

#The file exists. It’s not a directory. Its extension is correct.
for file in "$DIR"/*; do
    [ -e "$file" ] || continue
    if [ -d "$file" ]; 
    then
        continue
    fi

#Finding file name and extension
    filename=$(basename -- "$file")
    extension="${filename##*.}"

#Handling files without extensions Filename is equal to extension
    if [ "$filename" = "$extension" ]; then
        extension="others"
    fi

#Creating folder name based on extension and moving file
    folder="$(tr '[:lower:]' '[:upper:]' <<< ${extension:0:1})${extension:1}s"
    mkdir -p "$DIR/$folder"
    mv "$file" "$DIR/$folder/"
    echo "Moved: $filename → $folder/"
    
done

echo "Organization complete!"






