#!/bin/bash
set -e -x

# First remove python to have clean system install
brew update
brew uninstall --ignore-dependencies python
brew install python

# Pandoc to create the readme and bazaar for the translation files
brew install pandoc bazaar

# Display Python version
python -c "import sys; print sys.version"
python -c "import ssl; print ssl.OPENSSL_VERSION"

## Python modules
pip install --upgrade -r requirements.txt
pip install --upgrade -r travis/requirements_osx.txt

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
find . -name 'he.po' -delete
find . -name 'hr.po' -delete
find . -name 'cy.po' -delete
find . -name 'cs.po' -delete
find . -name '*.pot' -delete
cd ..

# Move translations
cp -Rf 0.8.x.tr/po builder/src