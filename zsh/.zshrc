# >>> ghost-complete initialize >>>
# !! Contents within this block are managed by 'ghost-complete install' !!
if [[ -f '/Users/uros/.config/ghost-complete/shell/init.zsh' ]]; then
  builtin source '/Users/uros/.config/ghost-complete/shell/init.zsh'
else
  echo "ghost-complete: init script missing: "'/Users/uros/.config/ghost-complete/shell/init.zsh' >&2
  echo "ghost-complete: run 'ghost-complete install' to restore it" >&2
fi
# <<< ghost-complete initialize <<<
export JAVA_HOME=/Library/Java/JavaVirtualMachines/temurin-21.jdk/Contents/Home

#if command -v tmux >/dev/null 2>&1; then
#  if [ -z "$TMUX" ]; then
#    tmux attach -t main || tmux new -s main
#  fi
#fi
# Secrets are stored in the macOS Keychain, not in this file.
# Add a new one with: security add-generic-password -U -a "$USER" -s NAME -w
keychain_secret() { security find-generic-password -a "$USER" -s "$1" -w 2>/dev/null; }
export ANTHROPIC_API_KEY="$(keychain_secret ANTHROPIC_API_KEY)"
export AWS_ACCESS_KEY_ID="$(keychain_secret AWS_ACCESS_KEY_ID)"
export AWS_SECRET_ACCESS_KEY="$(keychain_secret AWS_SECRET_ACCESS_KEY)"

# Misc Alias
alias cc="claude"
alias code="/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code"
alias dbReset="pipenv run alembic downgrade base && pipenv run alembic upgrade head"

# General Terminal
alias ls="ls -ltraG --color"
alias c="clear"
alias f="firewall-cmd"
alias d="docker"
alias nightlight="redshift-gtk -O 5000"

# Gradle
alias ts="./gradlew test"
alias br="./gradlew bootRun"
alias cpj="./gradlew compileJava"
alias cptj="./gradlew compileTestJava"
alias grd="./gradlew"
alias grdc="./gradlew clean"
alias grdb="./gradlew build"
alias grdbr="./gradlew bootRun"
alias sp="./gradlew spotlessApply"

# NPM
alias nrs="npm run start"
alias nrd="npm run dev"
alias nrc="npm run clean"
alias nrf="npm run format"
alias nrt="npm run test"
alias nrb="npm run build"
alias nri="npm run install --force"
alias nrw="npm run web"
alias nrp="npx prettier . --write"
alias nrl="npm run lint"
alias nrlf="npm run lint:fix"

# git
alias gst="git stash"
alias gstp="git stash pop"
alias g="git"
alias ga="git add"
alias gpl="git pull"
alias gps="git push"
alias gc="git commit"
alias gr="git fetch --all --force : git pull"
alias grs="git reset --hard"
alias gb="git branch"
alias gch="git checkout"
alias gs="git status"
alias gd="git diff origin/main"
alias gl="git log --oneline"

# docker
alias dcu="docker-compose up"
alias dcd="docker-compose down"
alias dcr="docker-compose restart"
alias dcl="docker-compose logs"
alias dce="docker-compose exec"
alias dcb="docker build"
alias dip="docker image prune -a"
alias dvp="docker volume prune -a"
alias dcp="docker container prune -a"
alias dcc="docker container prune -f && docker volume prune -f && docker image prune -af"

export HISTSIZE=1000000
export SAVEHIST=1000000
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS
alias hg='history | grep'

eval "$(starship init zsh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH="$HOME/.local/bin:$PATH"
# >>> ghost-complete shell integration >>>
# !! Contents within this block are managed by 'ghost-complete install' !!
source '/Users/uros/.config/ghost-complete/shell/ghost-complete.zsh'
# <<< ghost-complete shell integration <<<
