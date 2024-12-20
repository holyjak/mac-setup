#!/usr/bin/env bash --norc

set -o nounset # fail on unset variables
set -o errexit # fail if any statement doesn't return 0

echo ">> Starting setup..."

# Here we go.. ask for the administrator password upfront and run a
# keep-alive to update existing `sudo` time stamp until script has finished
# Credits: https://gist.github.com/brandonb927/3195465
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

#--------------------------------- BREW
# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
  echo "Installing homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Update homebrew recipes
echo ">> Brew update..."
brew update
echo ">> Upgrading installed packages" # To prevent failures of install where already installed in an older version
brew upgrade

echo ">> Installing binaries and apps..."
## TODO brew upgrade --all # To stop failing when trying to install an already installed but older version
brew bundle install --file ./Brewfile
brew cleanup

#--------------------------------- DOTFILES
echo ">> Setting up dotfiles..."

if [ ! -d ~/dotfiles ]; then
  git clone -b dotf https://github.com/holyjak/dotfiles.git ~/dotfiles
  ( cd ~/dotfiles; git remote set-url origin git@github.com:holyjak/dotfiles.git )
  ~/dotfiles/symlink.sh
fi

#--------------------------------- CLOJURE
echo ">> Setting up clojure-deps-edn..."
if [ ! -d ~/.clojure ]; then
  git clone clone git@github.com:holyjak/clojure-deps-edn.git ~/.clojure
  ( cd ~/.clojure; git remote add upstream https://github.com/practicalli/clojure-deps-edn.git )
fi

#--------------------------------- NODE ITSELF
#echo ">> Installing Node.js ... "
#export NVM_DIR=~/.nvm
#file -E $NVM_DIR || mkdir $NVM_DIR
# Add a link to fix nvm.fish:
#ln -fs $(brew --prefix nvm)/nvm.sh $NVM_DIR/nvm.sh
#set +o nounset
#set +o errexit
#source $(brew --prefix nvm)/nvm.sh

#nvm install v8
#nvm install v10
#nvm alias default v10

set -o nounset
set -o errexit

#--------------------------------- RUBY

echo ">> Settin up ruby env (rbenv)"
# GEMs, linter-puppet-lint prereq
# Prereq: brew install rbenv ruby-build
if [ ! -f ~/.gemrc ]; then
  sudo gem update -n /usr/local/bin --system
  export RBENV_ROOT="$(brew --prefix rbenv)"
  export GEM_HOME="$(brew --prefix)/opt/gems"
  export GEM_PATH="$(brew --prefix)/opt/gems"
  echo "gem: -n/usr/local/bin" > ~/.gemrc
  gem install -n /usr/local/bin puppet-lint
  gem install -n /usr/local/bin github-pages
  gem install -n /usr/local/bin bundler
fi

#--------------------------------- PYTHON
echo ">> Installing python packages..."
python_packages=(
  boto
  boto3
 "ipython[notebook]"   # Atom Hydrogen dependency
 jinja2 tornado jsonschema pyzmq # IJavascript -> Atom Hydrogen dependency
 virtualfish # Fish wrapper around virtualenv, see http://virtualfish.readthedocs.org/en/latest/install.html
 jmespath-terminal # cat my.json | jpterm # => interactive json query
)
pip3 install ${python_packages[@]}

# --------------------------------- NODE PACKAGES
# echo ">> Installing npm packages..."
# npm_packages=(
#   #jshint
#   #javascript # Atom Hydrogen dependency
#   #node-inspector # debugger (=> node-debug <your app.js> => loads in Chrome)
#   #linux # run Linux on Yosemite easily from the CLI via the xyhve supervisor - https://github.com/maxogden/linux
#   #gulp
#   #grunt-cli # Requires to run `npm i` in the project first
#   #nodemon   # Monitor a dir for changes (with filters), exec a command
#   #mancy     # Awesome Electron-based Node REPL UI
#   #nesh nesh-lodash2 nesh-history-search nesh-co
#   #graphqurl # gq, CLI with autocomplete for talking to GraphQL servers
# )

# set +o nounset
# set +o errexit

# nvm use default
# npm install -g ${npm_packages[@]}

# set -o nounset
# set -o errexit

#--------------------------------- VAGRANT
# echo ">> Installing Vagrant plugins..."
# vagrant_plugins=(
#   vagrant-vbguest
#   vagrant-proxyconf
#   vagrant-hostmanager
# )

# vagrant plugin install ${vagrant_plugins[@]}

#--------------------------------- ATOM
#echo ">> Installing Atom plugins..."

atom_plugins=(
  linter
  linter-eslint
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
  #nuclide-installer # Until https://github.com/atom/atom/issues/3426#issuecomment-145201151 fixed
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
  git-blame
  js-hyperclick # alt-click navigation for JS via Facebook hyperclick
  split-diff
  atom-beautify
  cursor-history # or last-cursor-position ?
  react-es6-snippets # TODO eval
  default-language # to set Markdown as default for new files
  shell-it         # pass buffer through a shell command
  language-fish-shell
  sequential-number # insert seq. numbers across multiple cursors
  chlorine          # better Clojure(Script) REPL, see http://corfield.org/blog/2018/12/19/atom-chlorine/
    ink # NEEDED BY chlorine
  language-todo    # highlight TODO, FIXME etc.
  markdown-table-editor # tab -> next cell, ensure all columns same width
  markdown-writer  # fix numbering, fold, jump to heading, ...
  # Clojure:
  parinfer
  lisp-paredit # for ops on SEXPs
  # try: bracket-colorizer atom-cljs-doc  atom-cljfmt 

  asciidoc-preview language-asciidoc

)

#apm install ${atom_plugins[@]}
#---------------------------------

## Emacs Live
#if [ ! -d ~/.emacs.d ]; then
#  echo "INFO Installing Emacs Live ..."
#  git clone git@github.com:overtone/emacs-live.git ~/.emacs.d
#else
#  echo "NOTICE ~/.emacs.d/ present, not installing Emacs Live"
#fi

#--------------------------------- Allow newly installed apps
# TODO Allow running newly installed apps
#      But how to know which apps are new? Or just run always?
#      Ex.:
#      sudo xattr -dr com.apple.quarantine /Applications/iTerm.app

#--------------------------------- zsh
./zsh-setup.sh

#--------------------------------- LAST

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

if [ -f .initial-installation-done ]; then
   echo ">> DONE SETTING UP. HAVE FUN!"
else
   echo > .initial-installation-done
   cat <<- EOF
        >> DONE SETTING UP. HAVE FUN!

         TODO:
        * in iTerm: Prefrences > General > Preferences - check "Load preferences from a 
	custom folder..." and set it to <backups>/zalohy/iTerm-preferences; also set 
	"Save changes" to Automatically
        * Execute `fnm completions --shell fish`
EOF
fi
