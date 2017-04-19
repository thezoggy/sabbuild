#!/bin/bash
set -e -x

# First remove to have clean installs
brew reinstall openssl python

# Pandoc to create the readme and bazaar for the translation files
brew install pandoc bazaar

# Display Python version
python --version

## Python modules
pip install --upgrade -r requirements.txt
pip install --upgrade -r travis/requirements_osx.txt

# Required for py2app to find PyObjCTools!
touch /usr/local/lib/python2.7/site-packages/PyObjCTools/__init__.py

# Sleepless module install
cd builder/osx/sleepless/
python setup.py install
cd ../../../

# Get the translations
bzr checkout --lightweight lp:~sabnzbd/sabnzbd/0.8.x.tr

# Remove unwanted translations
cd 0.8.x.tr
find . -name 'en*.po' -delete
find . -name 'pt.po' -delete
find . -name 'ar.po' -delete
find . -name 'ja.po' -delete
find . -name 'th.po' -delete
find . -name 'lo.po' -delete
find . -name 'hy.po' -delete
find . -name 'hu.po' -delete
find . -name 'hr.po' -delete
find . -name 'cy.po' -delete
find . -name 'cs.po' -delete
find . -name '*.pot' -delete
cd ..

# Move translations
cp -Rf 0.8.x.tr/po builder/src