#!/usr/bin/env python -OO
#
# Copyright 2008-2016 The SABnzbd-Team <team@sabnzbd.org>
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

import os
import shutil
import sys
import filecmp
import pkginfo
from filecmp import dircmp

# Extract version info
release = pkginfo.Develop('./src/').version
prod = 'SABnzbd-' + release
fileIns = prod + '-win-setup.exe'

# Paths
X64_PATH = os.path.join('installer_output', 'x64')
W32_PATH = os.path.join('installer_output', 'win32')
CMN_PATH = os.path.join('installer_output', 'common')

# Check if we have all
if not os.path.exists(X64_PATH) or not os.path.exists(W32_PATH):
    print 'Not all data available!'
    sys.exit(1)

# Make the common folder
if os.path.exists(CMN_PATH):
    # Retry at least a couple of times
    # Failes a lot on Windows
    for r in range(10):
        try:
            shutil.rmtree(CMN_PATH)
            break
        except:
            pass
os.mkdir(CMN_PATH)

############################
# Combine all the common files

# Do the comparison and move the files
for folder, sub_folders, files in os.walk(X64_PATH):
    # Make path to counterpart
    folder_w32 = folder.replace(X64_PATH, W32_PATH)
    # Only compare when there's files
    if files:
        for file in files:
            # Create full pathnames
            x64_full_path = os.path.join(folder, file)
            w32_full_path = os.path.join(folder_w32, file)
            # Some files are only in 1 of the folders
            if os.path.exists(x64_full_path) and os.path.exists(w32_full_path):
                # Identical?
                if filecmp.cmp(x64_full_path, w32_full_path, shallow=False):
                    cmn_full_path = x64_full_path.replace(X64_PATH, CMN_PATH)
                    # See if we already have this folder
                    if not os.path.exists(os.path.dirname(cmn_full_path)):
                        os.makedirs(os.path.dirname(cmn_full_path))
                    # Move
                    os.rename(x64_full_path, cmn_full_path)
                    # Remove the other one
                    os.remove(w32_full_path)

############################
# Make the installer

# This will have been made by package.py
os.rename('src/NSIS_Installer.nsi.tmp', 'installer_output/NSIS_Installer.nsi')
os.chdir('installer_output')

# Run NSIS
os.system('makensis.exe /v3 /DSAB_PRODUCT=%s /DSAB_VERSION=%s /DSAB_FILE=%s NSIS_Installer.nsi' % \
           (prod, release, fileIns))

# Remove if it's already exists
if os.path.exists('../src/' + fileIns):
    os.remove('../src/' + fileIns)

# Move result
os.rename(fileIns, '../src/' + fileIns)
os.chdir('..')

# Remove the NSI files
os.remove('installer_output/NSIS_Installer.nsi')
os.remove('src/NSIS_Installer.nsi')

