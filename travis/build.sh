#!/bin/bash
set -e -x

# Get the certificate to sign the releases from secret Travis variable
# From: https://medium.com/juan-cruz-viotti/how-to-code-sign-os-x-electron-apps-in-travis-ci-6b6a0756c04a
# But modified to actually work!
export KEYCHAIN = build.keychain;
export KEYCHAIN_PASS = travisci;

security create-keychain -p $KEYCHAIN_PASS $KEYCHAIN;
security default-keychain -s $KEYCHAIN;
security unlock-keychain -p $KEYCHAIN_PASS $KEYCHAIN;
security set-keychain-settings -t 3600 -u $KEYCHAIN;

# Add our secret private and public key/cert
security import ./travis/codesign/PrivKey.p12 -P rgi1512 -k $KEYCHAIN -A;

# This is required to make sure the codesign doesn't hang
security set-key-partition-list -S apple-tool:,apple: -s -k $KEYCHAIN_PASS $KEYCHAIN

# Run that builder
cd builder
python package.py 'app'

# Now build the DMG
python make_dmg.py