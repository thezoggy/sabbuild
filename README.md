SABBuilder
==========

This repository is used to build and package releases of SABnzbd using TravisCI (macOS) and AppVeyor (Windows). Releases will be pushed as drafts to this repository, after which they can be moved to the main `sabnzbd` repo.

# DO NOT USE THIS.


# For future reference:

## macOS build (Travis)

- In order to get `codesign` to work you need to login to your Apple Developer account, create a new `OSX production certificate` which will make you create a certificate signing request on a Mac.
After the certificate is generated you need to import that certificate on the Mac. Then you can export the key-certificate pair by right-clicking on it in the Keychain manager. This `p12` file is what you will need.
- This file should NEVER be published, you need to use `travis encrypt-file --add` to create a version to commit.
WARNING: encrypted files generated with `travis encrypt-file` on Windows do not work!

## Windows build

- WIP