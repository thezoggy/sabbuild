#!/bin/bash
set -e -x

# No need for brew update
export HOMEBREW_NO_AUTO_UPDATE=1

# Pandoc to create the readme and bazaar for the translation files
brew install pandoc bazaar

# First remove python to have clean system install
brew uninstall --ignore-dependencies python

# Get Python and install
curl https://www.python.org/ftp/python/2.7.13/python-2.7.13-macosx10.6.pkg -o "python.pkg"
sudo installer -pkg python.pkg -target /

# Display Python version
python -c "import sys; print sys.version"

#################################
# Python modules
pip install --upgrade -r requirements.txt
pip install --upgrade -r travis/requirements_osx.txt

#################################
# Sleepless module install
cd builder/osx/sleepless/
python setup.py install
cd ../../../

#################################
# Push new translations to Launchpad for translations
bzr launchpad-login safihre
bzr whoami "Safihre <safihre@sabnzbd.org>"
bzr checkout --lightweight lp:~sabnzbd/sabnzbd/0.8.x < "yes"
cp -f builder/src/po/email/SABemail.pot 0.8.x/po/email/SABemail.pot
cp -f builder/src/po/main/SABnzbd.pot 0.8.x/po/main/SABemail.pot
cp -f builder/src/po/nsis/SABnsis.pot 0.8.x/po/nsis/SABnsis.pot

cd 0.8.x
bzr add po/email/SABemail.pot
bzr add po/main/SABemail.pot
bzr add po/nsis/SABnsis.pot
bzr commit -m "Automatic POT update"
bzr push lp:~sabnzbd/sabnzbd/0.8.x
cd ..

#################################
# Get the translations from Launchpad
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
