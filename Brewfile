# brew bundle --file=~/setup/Brewfile
cask_args appdir: "/Applications"

########################## TAPS
tap "homebrew/bundle"
tap "homebrew/cask-versions"
#tap "nlf/dhyve"
tap "shopify/shopify"
tap "simeji/jid"
tap "adoptopenjdk/openjdk"
tap "aws/tap"
tap "go-task/tap"
tap "clojure/tools"
tap "borkdude/brew"
tap "clojure-lsp/brew"

brew "go-task" # better make, for Channel API

########################## Mac App Store
# See mas list
brew "mas"
# `mas list` - apps installed via M.A.S., `mas search 1Password`
# mas "1Password 7", id: 1333542190 # FIXME 1Password 8 not available in the store yet (only for iDevices)
#412522123 com.littlepotatosoftware.BabyProof
mas "Evernote", id: 406056744
mas "MenubarClock", id: 492167985 # display up to 5 world times in the Mac top bar
mas "Octofile", id: 1463726615    # Android <> Mac file transfer mobile & desktop app

######################### Apps & CLIs

cask "temurin" # OpenJDK by Eclipse, LTS; install before brewing lein / clojure; TODO: Change to temurin17 once v18 out

#brew "ack" # used by Jakob's deploy checklist
brew "adr-tools" # simple tool for managing Architecture Decision Records (.md files) for a project
#brew "ansible"
brew "awscli"
brew "coreutils"
brew "corkscrew"  # ssh tunneling
brew "direnv"       # so I can have dir-specific env vars .envrc in fish/bash/...
brew "editorconfig"
brew "findutils"
# ngrok v2 is closed source, install manually; # expose a local server behind a NAT or firewall to the internet

brew "ranger" # EXPERIMENT - console file manager with VI key bindings
    brew "atool"
    brew "highlight"
    brew "media-info"
    brew "w3m"

brew "rlwrap"  # For better Clojure CLI
brew "clojure/tools/clojure" # Official Clojure tap for clj, clojure CLIs
brew "clojure-lsp/brew/clojure-lsp-native" # clojure-lsp LSP server for use with Cursive etc., kondo built in
# Babashka: > `bb` GraalVM quick Clojure subset interpreter for shell scripts
# Avail. aliases: clojure.*str*ing, clojure.*set*, clojure.*edn* [read-string only],
# clojure.java.*shell* [sh only], clojure.java.*io* [as-relative-path, copy, delete-file, file]
# Java's: System[exit, set/getProperty(ies), getenv, File[canRead/Write,delete[onExit], exists, getName/Parent[File]/Path, is*, list[Files], mkdir[s], ...]
# Spec vars: *in*, *out*, *command-line-args*
brew "borkdude/brew/babashka" 
brew "borkdude/brew/jet" # JSON <> EDN <> Transit
brew "babashka/brew/neil"
# brew install borkdude/brew/clj-kondo

brew "curl" #, args: ["with-openssl"] - not supported anymore?
brew "ffmpeg" # ffprobe for extracting audio from video with youtube-dl
brew "fish"
brew "git"
brew "gnupg"
#brew "gnuplot", args: ["with-aquaterm", "with-x11", "with-qt"] # OBS: with-aquaterm not supported anymore?
#brew "gradle"
brew "grep" # replace outdated OSX's one
brew "ripgrep" # -> binary `rg`; faster grep in Rust
brew "imagemagick"
brew "jq"   # json processing from CLI; see also `jid` below
#brew "kubernetes-cli"
brew "leiningen"
brew "maven"
brew "nvm"
#brew "packer"  # create AMIs etc
#brew "planck"   # ClojureScript REPL
brew "pre-commit" # see http://pre-commit.com/ - used by some projects
brew "python"
#brew "python2" # not avail anymore?
brew "rsync" # 3.1 - while Yosemite still has 2.6
brew "rbenv"
brew "ruby"  # updated from OSX'
brew "ruby-build"
brew "s-nail" # CLI for sending emails (with custom From, remote SMTP server)
#brew "terraform" # HashiCorp infrastructure as a code provisioning
#brew "terragrunt" # terraform wrapper
#brew "vaulted"  # secrets manager for AWS
brew "wget"
brew "youtube-dl"  # youtube downloader https://rg3.github.io/youtube-dl/
#brew "yq" # Process YAML from CLI
brew "shopify/shopify/toxiproxy"
brew "simeji/jid/jid" # Json Incremental Digger - drill down JSON interactively by using filtering queries like jq
brew "git-extras"    # `git effort` for change hot spots etc
brew "git-secrets"   # `git secrets --install` in a repo do add a git hook that will check for secrets and prevent commiting them

#brew "kubectl"
#brew "kubernetes-helm"


#brew "fzf"               # Interactive fuzzy search of stdin list: `ls | fzf` # Perf issues?!
brew "rustup-init"        # Rust the programming lang tooling - run to install/update rust ('rust' lacks 'rustup)

#brew "aws-sam-cli"       # AWS Lambda local dev etc.

brew "starship"          # cross-OS shell promt

#brew "plantuml"    # transform textual repres. into a diagram, see http://plantuml.com/ ; via Kenneth Pedersen
brew "geckodriver"  # WebDriver for Firefox - for https://github.com/igrishaev/etaoin
brew "bat"          # better cat, w/ git integr. and syntax highl.: --language clojure
brew "graphviz"     # incl. `dot` used by VS Code PlantUML plugin
brew "fd"           # better find - https://github.com/sharkdp/fd
brew "act"          # run GitHub actions locally - https://github.com/nektos/act
brew "fnm"          # fast Node version mgr in Rust, https://github.com/Schniz/fnm
# brew httpie # smarter, far better alternative to curl for playing w/ APIs, see httpie.org - TRY OUT
brew "buildpacks/tap/pack" # buildpacks.io CLI tool for running Docker-based builds of code
brew "flyctl" # the fly CLI for fly.io (of the same name as Concourse CI one)
brew "git-delta" # syntax-highlighting diff pager for git etc
#brew "difftastic" # syntax-highlighting diff pager for git, with change minimization (delta does that too?)
########################## APPS
#cask "macfuse" # user-space filesystem support; sshfs needs to be installed manually from https://osxfuse.github.io/ ?
#cask "chefdk" # chef development kit: chef + other tools
#cask "gitup" # better GitX, Git GUI
#cask "reactotron" # UI for inspecting React JS/Native apps
#cask "rowanj-gitx"
#cask "sublime-text3"
#cask "virtualbox"
#cask "alfred" # replaced by raycast
#cask "atom"
cask "visual-studio-code"
#brew "zeromq" # Atom Hydrogen dependency
brew "sass/sass/sass" # For my blog; Dart SASS
#cask "audacity"  # requires the old Snow Leopard version of OSX?
cask "docker" # Docker for Mac (i.e. Docker.app) as opposed to the `brew docker` CLI
cask "dropbox"
#cask "emacs"
cask "firefox"
cask "google-chrome"
cask "handbrake" # Video ripping / transforming
cask "iterm2" #iterm2-beta
cask "jetbrains-toolbox"
cask "keybase"
cask "libreoffice" # due to a failing update to 7.5
#cask "lighttable"
cask "p4v" # formerly p4merge
cask "qlmarkdown" # Markdown support for OSX Quikc Look previews
cask "skype"
cask "slack"
#cask "soundflower" # OSX extension so apps can pass audio to other ones, needs to permit ext. isntall; auth: Matt Ingalls
#cask "spideroak"   # Fails 1/2020: "Error: Cask 'spideroak' definition is invalid: Token '{:v1=>"spideroak"}' in header line does not match the file name."
#cask "transmission" # Torrent client
#cask "tunnelblick"
#cask "vagrant"
cask "vlc"
cask "mucommander"
cask "aquaterm"   # for gnuplot without X11
cask "adobe-acrobat-reader"
cask "freeze"    # AWS Glacier client
# cask "keycast" # display keys typed on screen - for screencasts
cask "rsyncosx"  # rsync UI
cask "gpg-suite-no-mail" # make working with GPG signing (eg git commits) easier and integr. with Keychain
cask "dash"      # document browser
cask "sourcetree" # git repo browser etc
cask "veracrypt" # ardoq
cask "vivaldi"   # browser
# cask "pop"   # https://pop.com/ - ScreenHero reborn - remote pairprogrammin
cask "obsidian"  # https://obsidian.md - Markdown-based note mgmt app
cask "temurin11" # OpenJDK by Eclipse, v.11 LTS; install before brewing lein / clojure
cask "flux"      # change color, light scheme in the evening
cask "raycast"   # app & cmd launcher, window management & much more
cask "1password/tap/1password-cli" # 1Password 8+ CLI, called `op`
