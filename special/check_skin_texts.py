# NEEDS TO BE RUN FROM WITHIN SAB DIRECTORY

from sabnzbd.skintext import SKIN_TEXT
import os

# Make one giant string of all the text for semi-efficient search
main_giant_file = '';

for dirname, dirnames, filenames in os.walk('interfaces') :
    for filename in filenames:
        # Only .tmpl and .htm(l) files
        if '.tmpl' in filename or '.htm' in filename:
            with open (os.path.join(dirname, filename), "r") as myfile:
                data = myfile.read().replace('\n', '')
            main_giant_file = main_giant_file + data;

# What do we have here?
not_found = [];
for key in SKIN_TEXT:
    if "'"+key+"'" not in main_giant_file and '"'+key+'"' not in main_giant_file:
        not_found.append(key)

# What line?
not_found_numbers = [];
for lookup in not_found:
    with open('sabnzbd/skintext.py') as myFile:
        for num, line in enumerate(myFile, 1):
            if "'"+lookup+"'" in line:
                not_found_numbers.append(num)

# Make a normal human sorting, based on file-line
re_sorted = sorted(zip(not_found_numbers,not_found), key=lambda pair: pair[0]);

# Print!
for a,b in re_sorted:
    print a,b