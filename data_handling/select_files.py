# Description: This script copies a list of files from a source folder to a sample folder
"""
You have a folder containing all the files, and from that, you want to select specific files as samples and save them in a separate folder. 
You also have a list specifying which files should be used and saved in the sample folder.
"""

import os
import shutil

# Paths to your source folder with original wav files and the text file of sample file names
source_folder = 'path/to/source_folder'
text_file = 'path/to_your_text_file.txt'
sample_folder = 'path/to/sample_folder'

# Read the list of file names from the text file
with open(text_file, 'r') as file:
    sample_files = file.read().splitlines()

# Iterate through the list of file names and copy them to the sample folder
for filename in sample_files:
    source_path = os.path.join(source_folder, filename)
    destination_path = os.path.join(sample_folder, filename)

    try:
        shutil.copy2(source_path, destination_path)
        print(f'Copied {filename} to sample folder')
    except FileNotFoundError:
        print(f'File {filename} not found in source folder')
print('Copy process completed.')
