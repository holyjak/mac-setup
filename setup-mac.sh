#!/bin/bash
set -e
set -u

# Here we go.. ask for the administrator password upfront and run a
# keep-alive to update existing `sudo` time stamp until script has finished
# Credits: https://gist.github.com/brandonb927/3195465
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update homebrew recipes
brew update

#---------------------------------

# Install GNU core utilities (those that come with OS X are outdated)
brew install coreutils

# Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
brew install findutils

# Install Bash 4
#brew install bash

# Install more recent versions of some OS X tools
brew tap homebrew/dupes
brew install homebrew/dupes/grep

#---------------------------------
binaries=(
 git
 nvm
 editorconfig
 fish
 wget
)

echo "installing binaries..."
brew install ${binaries[@]}

brew cleanup

#---------------------------------

brew install caskroom/cask/brew-cask

# Apps
apps=(
  alfred
  dropbox
  google-chrome
  slack
  firefox
  vagrant
  iterm2
  #sublime-text3
  virtualbox
  atom
  vlc
  skype
  rowanj-gitx
  emacs
  tunnelblick
  p4merge
)

# Install apps to /Applications
# Default is: /Users/$user/Applications
echo "installing apps..."
brew cask install --appdir="/Applications" ${apps[@]}

# For alternative versions: brew tap caskroom/versions

#---------------------------------
echo "Installing Node.js ... "
export NVM_DIR=~/.nvm
set +u
set +e
source $(brew --prefix nvm)/nvm.sh
set -u
set -e

nvm install v0.10       # FIXME Does not work for soem reason?!
nvm alias default v0.10

#---------------------------------

echo "Settin up ruby env (rbenv)"
# GEMs, linter-puppet-lint prereq
brew install rbenv ruby-build
if [ ! -f ~/.gemrc ]; then
  sudo gem update --system
  export RBENV_ROOT="$(brew --prefix rbenv)"
  export GEM_HOME="$(brew --prefix)/opt/gems"
  export GEM_PATH="$(brew --prefix)/opt/gems"
  echo "gem: -n/usr/local/bin" > ~/.gemrc
  gem install puppet-lint
fi

#---------------------------------
echo "Installing Atom plugins..."

atom_plugins=(
  linter
  jshint
  react
  lodash-snippets
  javascript-snippets
  script
#  refactor  js-refactor # BROKEN AS OF 2015-04-17
  npm-autocomplete
  autocomplete-snippets
  test-status
  editorconfig
  language-puppet
  linter-puppet-lint
)

apm install ${atom_plugins[@]}
#---------------------------------

echo "Setting up dotfiles..."

if [ ! -d ~/dotfiles ]; then
  git clone -b dotf https://github.com/jakubholynet/dotfiles.git ~/dotfiles
  ( cd ~/dotfiles; git remote set-url origin git@github.com:jakubholynet/dotfiles.git )
  ~/dotfiles/symlink.sh
fi

#---------------------------------

if which java > /dev/null; then 
  brew install leiningen
  lein --version &> /dev/null # download Clojure if needed 
else
  echo "WARN: Not installing Leiningen - no java found"
fi

#---------------------------------

## TODO: Update path in .profile
# $PATH=$(brew --prefix coreutils)/libexec/gnubin:$PATH
# Add rbenv to bash, zsh, fish: https://coderwall.com/p/6bqzvq/sudoless-brewed-rubygems-on-os-x
# export NVM_DIR=~/.nvm
#    source $(brew --prefix nvm)/nvm.sh

## TODO Install
# Junos, Sophos
## TODO Config OSX, apps
