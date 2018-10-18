cask_args appdir: "/Applications"

########################## TAPS
tap "homebrew/bundle"
tap "homebrew/cask"
tap "homebrew/cask-versions"
tap "homebrew/core"
#tap "nlf/dhyve"
tap "shopify/shopify"
tap "simeji/jid"

cask "java"  # before brewing lein / clojure
cask "java8" # TMP until Clojure projects updated to 9+

brew "ack" # Jakob's deploy checklist
brew "adr-tools" # simple tool for managing Architecture Decision Records (.md files) for a project
brew "ansible"
brew "awscli"
brew "coreutils"
brew "corkscrew"  # ssh tunneling
brew "direnv"       # so I can have dir-specific env vars .envrc in fish/bash/...
brew "editorconfig"
brew "findutils"
# ngrok v2 is closed source, install manually; # expose a local server behind a NAT or firewall to the internet

brew "ranger"
    brew "atool"
    brew "highlight"
    brew "media-info"
    brew "w3m"

brew "rlwrap"  # For better Clojure CLI
brew "clojure" # Clojure and its clj CLI
brew "curl", args: ["with-openssl"]
brew "ffmpeg" # ffprobe for extracting audio from video with youtube-dl
brew "fish"
brew "git"
brew "gnupg"
brew "gnuplot", args: ["with-aquaterm", "with-x11", "with-qt"]
#brew "gradle"
brew "grep" # replace outdated OSX's one
brew "imagemagick"
brew "jq"   # json processing from CLI
#brew "kubernetes-cli"
brew "leiningen"
brew "maven"
brew "nvm"
#brew "packer"  # create AMIs etc
brew "planck"   # ClojureScript REPL
brew "pre-commit" # see http://pre-commit.com/ - used by some projects
brew "python"
brew "python2"
brew "rsync" # 3.1 - while Yosemite still has 2.6
brew "rbenv"
brew "ruby"  # updated from OSX'
brew "ruby-build"
brew "s-nail" # CLI for sending emails (with custom From, remote SMTP server)
brew "terraform" # HashiCorp infrastructure as a code provisioning
#brew "terragrunt" # terraform wrapper
brew "vaulted"  # secrets manager for AWS
brew "wget"
brew "youtube-dl"  # youtube downloader https://rg3.github.io/youtube-dl/
#brew "yq" # Process YAML from CLI
brew "zeromq" # Atom Hydrogen dependency
brew "shopify/shopify/toxiproxy"
brew "simeji/jid/jid" # Json Incremental Digger - drill down JSON interactively by using filtering queries like jq
brew "git-extras"    # `git effort` for change hot spots etc

########################## APPS
#cask "chefdk" # chef development kit: chef + other tools
#cask "gitup" # better GitX, Git GUI
#cask "reactotron" # UI for inspecting React JS/Native apps
#cask "rowanj-gitx"
#cask "sublime-text3"
#cask "virtualbox"
cask "alfred"
cask "atom"
cask "audacity"
cask "docker" # Docker for Mac (i.e. Docker.app) as opposed to the `brew docker` CLI
cask "dropbox"
cask "emacs"
cask "firefox"
cask "google-chrome"
cask "handbrake" # Video ripping / transforming
cask "iterm2" #iterm2-beta
cask "jetbrains-toolbox"
cask "keybase"
cask "libreoffice"
cask "lighttable"
cask "p4v" # formerly p4merge
cask "qlmarkdown" # Markdown support for OSX Quikc Look previews
cask "skitch"
cask "skype"
cask "slack"
#cask "soundflower" # OSX extension so apps can pass audio to other ones, needs to permit ext. isntall; auth: Matt Ingalls
cask "spectacle" # Resize, move windows via keyboard shortcut; Donate!
cask "spideroak"
cask "transmission" # Torrent client
cask "tunnelblick"
cask "vagrant"
cask "vlc"
cask "mucommander"
cask "aquaterm"   # for gnuplot without X11
