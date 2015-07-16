#!/bin/sh

FRESH_SETUP="false"

if [ "$FRESH_SETUP" = "true" ]; then
  echo "Wipe all (default) app icons from the Dock"
  defaults write com.apple.dock persistent-apps -array # TODO Add finder, notes, iterm, ...
fi

echo "Requiring password immediately after sleep or screen saver begins"
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 3

echo ""
echo "DONE"
echo ""
echo "Beware: Some of these might require restart / re-login"


## TODO Try
# networksetup -setcomputername <name>
