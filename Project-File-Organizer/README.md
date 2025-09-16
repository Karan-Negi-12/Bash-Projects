📁 File Organizer Script
📝 Description
This Bash script organizes files in a specified directory into subdirectories based on their file types (extensions). It helps keep directories clean and structured.

🚀 How It Works — Line-by-Line Explanation



Shell
#!/bin/bash

Defines the interpreter as Bash.




Shell
# Description: This script organizes files in a specified directory into subdirectories based on their file types.

Comment describing the script’s purpose.




Shell
DIR=${1:-.}

Sets the working directory:

If a directory is passed as an argument ($1), it uses that.
Otherwise, it defaults to the current directory (.).



Shell
if [ ! -d "$DIR" ]; 
then 
  echo "Directory $DIR does not exist."
  exit 1
else
  echo "Directory $DIR exists."
  echo "Let's start working on it."
fi

Checks if the directory exists:

If not, exits with an error.
If yes, confirms and proceeds.



Shell
for file in "$DIR"/*; do
    [ -e "$file" ] || continue

Loops through each item in the directory and skips if the file doesn’t exist.




Shell
    if [ -d "$file" ]; 
    then
        continue
    fi

Skips directories — only files are processed.




Shell
    filename=$(basename -- "$file")
    extension="${filename##*.}"

Extracts:

filename: the name of the file.
extension: the part after the last dot (.).



Shell
    if [ "$filename" = "$extension" ]; then
        extension="others"
    fi

Handles files without extensions by assigning them to an "others" category.




Shell
    folder="$(tr '[:lower:]' '[:upper:]' <<< ${extension:0:1})${extension:1}s"

Creates a folder name:

Capitalizes the first letter of the extension.
Adds an s at the end (e.g., jpg → Jpgs).



Shell
    mkdir -p "$DIR/$folder"
    mv "$file" "$DIR/$folder/"
    echo "Moved: $filename → $folder/"

Creates the folder if it doesn’t exist, moves the file into it, and prints a message.




Shell
done

Ends the loop.




Shell
echo "Organization complete!"

Final message after organizing all files.

📦 Example Usage



Shell
bash organize.sh /home/karan/downloads

This will:

Move .jpg files to Jpgs/
.pdf files to Pdfs/
Files without extensions to Others/
