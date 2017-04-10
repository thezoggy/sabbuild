#!/bin/bash
set -e -x

# Pandoc to create the readme
brew install pandoc

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

