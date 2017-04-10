# Parse parameters
param(
   [string] $release
)

# Set location of virtual env
$env_path = 'C:\Users\IEUser\Documents\win32\Scripts\'

# Remove previous output
if (Test-Path 'installer_output') {
    Remove-Item -Recurse -Force 'installer_output'
}

# Make sure it's deactivated
if (Get-Command deactivate -errorAction SilentlyContinue) {
    deactivate
}

# Lets run it 64 bit first
python package.py installer $release

# All done?
# Then we activate the 32bit virtualenv
Invoke-Expression "${env_path}activate.ps1"

# Now we make the 32bit binary
python package.py installer $release

# Now we build the installer (from 32 bit)
python make_windows_installer.py $release

# Remove current output
if (Test-Path 'installer_output') {
    Remove-Item -Recurse -Force 'installer_output'
}

# Then we deactivate the env again
deactivate

# Let's also build the source package
python package.py source $release