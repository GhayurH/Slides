import os
import re

def rename_files(directory):
    for filename in os.listdir(directory):
        old_filepath = os.path.join(directory, filename)
        if os.path.isfile(old_filepath):
            # Extract filename without extension
            name, extension = os.path.splitext(filename)
            # Remove preceding numbers, underscores, and punctuation
            new_name = re.sub(r'^[\d\s._-]+', '', name)
            # Replace underscores between words with spaces
            new_name = re.sub(r'_', ' ', new_name)
            new_name += extension
            # Rename the file if the new name is different
            if new_name != filename:
                new_filepath = os.path.join(directory, new_name)
                # Append a number to the end until finding a unique name
                count = 1
                while os.path.exists(new_filepath):
                    new_name = re.sub(r'^[\d\s._-]+', '', name)
                    new_name = re.sub(r'_', ' ', new_name) + str(count) + extension
                    new_filepath = os.path.join(directory, new_name)
                    count += 1
                os.rename(old_filepath, new_filepath)

# Replace 'directory_path' with the path of your directory
directory_path = r'C:\Audio\a'
rename_files(directory_path)
