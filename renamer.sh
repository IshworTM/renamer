#!/bin/bash

#User input for the path where the the file(s) exist.
read -p "Enter the path to the file(s) to be renamed: " dir

#Check if the given directory exist.
if [ ! -d "$dir" ]; then
    echo "The directory '$dir' doesn't exist."
    exit 1
fi

#Text that is supposed to be replaced.
read -p "Enter the text to be replaced: " text_to_be_replaced

#Text that is supposed to replace the previous text.
read -p "Enter the text that replaces '$text_to_be_replaced': " new_text

#Confirmation of the provided data.
echo "Entered data: "
echo "Directory: $dir"
echo "Text to replace: $text_to_be_replaced"
echo "New text: $new_text"

#Confirmation for proceeding.
read -p "Do you wish to proceed? This will rename all the files with the text '$text_to_be_replaced' on their name. (y/n): " confirmation

#Exit if the user inputs "NO"
if [ "$confirmation" != "y" ]; then
    echo "Operation cancelled..."
    exit 0
fi

#Loop through all the files in the directory and replace the text.
find "$dir" -type f -name "*$text_to_be_replaced*" | while read -r file; do
    newfile=$(echo "$file" | sed "s/$text_to_be_replaced/$new_text/")
    mv "$file" "$newfile"
done

echo "All files have been renamed."
