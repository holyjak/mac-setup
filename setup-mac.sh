#!/usr/bin/env bash --norc
set -o nounset # fail on unset variables
set -o errexit # fail if any statement doesn't return 0

echo ">> Starting setup..."

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
echo ">> Brew update..."
brew update
echo ">> Upgrading installed packages" # To prevent failures of install where already installed in an older version
brew upgrade

#---------------------------------

# Install GNU core utilities (those that come with OS X are outdated)
brew install coreutils

# Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
brew install findutils

# Install Bash 4
#brew install bash

# Add non-standard versions
brew tap caskroom/versions

# Install more recent versions of some OS X tools
brew tap homebrew/dupes
brew install homebrew/dupes/grep

# Extra taps
brew tap shopify/shopify
brew tap nlf/dhyve

#--------------------------------- BREW
binaries=(
 git
 nvm
 editorconfig
 fish
 wget
 jq
 ansible
 docker
 boot2docker
 python # updated, with pip
 ack # Jakob's deploy checklist
 zeromq # Atom Hydrogen dependency
 # ngrok v2 is closed source, install manually; # expose a local server behind a NAT or firewall to the internet
 rsync # 3.1 - while Yosemite still has 2.6
 planck # ClojureScript REPL
 youtube-dl # youtube downloader https://rg3.github.io/youtube-dl/
 toxiproxy # Tap shopify
 # brew tap nlf/dhyve; brew install --HEAD dhyve # boot2docker inside a lightweight container instead of VB
)

echo ">> Installing binaries..."
## TODO brew upgrade --all # To stop failing when trying to install an already installed but older version
## TODO brew cleanup
brew install ${binaries[@]}

brew cleanup

#--------------------------------- CASK

brew install caskroom/cask/brew-cask

# Apps
apps=(
  alfred
  dropbox
  google-chrome
  slack
  firefox
  vagrant
  #sublime-text3
  virtualbox
  atom
  vlc
  skype
  rowanj-gitx
  emacs
  tunnelblick
  p4merge
  spideroak
  libreoffice
  skitch
  handbrake
  chefdk # chef development kit: chef + other tools
  intellij-idea-ce
  iterm2-beta #iterm2
)

# Install apps to /Applications
# Default is: /Users/$user/Applications
echo ">> Installing apps..."
brew cask install --appdir="/Applications" ${apps[@]}

# For alternative versions: brew tap caskroom/versions

#--------------------------------- NODE ITSELF
echo ">> Installing Node.js ... "
export NVM_DIR=~/.nvm
# Add a link to fix nvm.fish:
ln -fs $(brew --prefix nvm)/nvm.sh $NVM_DIR/nvm.sh
set +o nounset
set +o errexit
source $(brew --prefix nvm)/nvm.sh

nvm install v0.12
nvm install iojs
nvm alias default v0.12

set -o nounset
set -o errexit

#--------------------------------- RUBY

echo ">> Settin up ruby env (rbenv)"
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

#--------------------------------- PYTHON
echo ">> Installing python packages..."
python_packages=(
  boto
  boto3
 "ipython[notebook]"   # Atom Hydrogen dependency
 jinja2 tornado jsonschema pyzmq # IJavascript -> Atom Hydrogen dependency
 virtualfish # Fish wrapper around virtualenv, see http://virtualfish.readthedocs.org/en/latest/install.html
)
pip install ${python_packages[@]}

# --------------------------------- NODE PACKAGES
echo ">> Installing npm packages..."
npm_packages=(
  jshint
  ijavascript # Atom Hydrogen dependency
  node-inspector # debugger (=> node-debug <your app.js> => loads in Chrome)
  linux # run Linux on Yosemite easily from the CLI via the xyhve supervisor - https://github.com/maxogden/linux
)
iojs_packages=(
  jshint
  # ijavascript # Atom Hydrogen dependency; not supported on iojs as yet
  # node-inspector # debugger (=> node-debug <your app.js> => loads in Chrome) # Not supported yet
)

set +o nounset
set +o errexit

nvm use default
npm install -g ${npm_packages[@]}
nvm use iojs
npm install -g ${iojs_packages[@]}

set -o nounset
set -o errexit

#--------------------------------- VAGRANT
echo ">> Installing Vagrant plugins..."
vagrant_plugins=(
  vagrant-vbguest
  vagrant-proxyconf
  vagrant-hostmanager
)

vagrant plugin install ${vagrant_plugins[@]}

#--------------------------------- ATOM
echo ">> Installing Atom plugins..."

atom_plugins=(
  linter
  #jshint
  linter-jshint # Requires 'npm install -g jshint' ?
  react
  lodash-snippets
  javascript-snippets
  script
  # refactor  js-refactor # BROKEN AS OF 2015-04-17 # refactor is not available anymore?!
  #npm-autocomplete # Not yet compatible with Atom 1.0 API
  # autocomplete-snippets # bundled with Atom
  #test-status
  editorconfig
  language-puppet
  linter-puppet-lint
  language-docker
  sublime-style-column-selection
  incremental-search
  dash # Search for word at cursor with ctrl-h (ctx-sensitive, see the plugin config)
  #paredit
  hydrogen
  # iojs-debugger
  nuclide-installer
  symbol-gen # => generate ctags file & jump to a definition
  # synced-sidebar # scroll to the open file in the tree view # Does not work with Nuclide File Tree as of 0.4.0
  imdone-atom # trello-like dashboard for tasks in the code and a todo file
  clipboard-plus # remember past clipboard entries
  pigments # display colors in CSS/...
  autocomplete-paths # E.g. in require("..") 
  highlight-selected # 2-click a word to highlight its occurences in the file
  docblockr # doc writing support: on Enter, insert * + keep indent., ...
  trailing-spaces # highlight them
  atom-ternjs # smarter autocomplete using the Tern code analyzer
  # NEWISH:
  jumpy # ~ ace-jump; shift-enter
  scratch # Open scratch file with C-A-, -> .atom/scratch
  # Consider: quick-editor # edit css/less/sass directly from the HTML using it
  # Interesting: tasks; 
)

apm install ${atom_plugins[@]}
#---------------------------------

if which java > /dev/null && java -version ; then
  brew install leiningen
  lein --version &> /dev/null # downloads Clojure if needed
else
  echo "WARN: Not installing Leiningen - no java found"
fi

#---------------------------------

## Emacs Live
if [ ! -d ~/.emacs.d ]; then
  echo "INFO Installing Emacs Live ..."
  git clone git@github.com:overtone/emacs-live.git ~/.emacs.d
else
  echo "NOTICE ~/.emacs.d/ present, not installing Emacs Live"
fi

#--------------------------------- LAST

echo ">> Setting up dotfiles..."

if [ ! -d ~/dotfiles ]; then
  git clone -b dotf https://github.com/jakubholynet/dotfiles.git ~/dotfiles
  ( cd ~/dotfiles; git remote set-url origin git@github.com:jakubholynet/dotfiles.git )
  ~/dotfiles/symlink.sh
fi

## TODO: Update path in .profile
# $PATH=$(brew --prefix coreutils)/libexec/gnubin:$PATH
# Add rbenv to bash, zsh, fish: https://coderwall.com/p/6bqzvq/sudoless-brewed-rubygems-on-os-x
# export NVM_DIR=~/.nvm
#    source $(brew --prefix nvm)/nvm.sh

#--------------------------------- TODOs

## TODO Install
# Junos, Avira, ? JDK
## TODO Config OSX, apps
# TODO tunnelblick must be directly in /Applications => mv mv /opt/homebrew-cask/Caskroom/tunnelblick/3.5.0_build_4265/Tunnelblick.app there

echo ">> DONE SETTING UP. HAVE FUN!"
