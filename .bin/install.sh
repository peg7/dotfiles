# original: https://bitbucket.org/durdn/cfg/src/master/.bin/install.sh
REPO=https://github.com/peg7/dotfiles.git

cd ~
git clone --bare ${REPO} ${HOME}/.dotfiles
function dotctl {
   /usr/bin/git --git-dir=${HOME}/.dotfiles/ --work-tree=${HOME} $@
}
mkdir -p .dotfiles-backup
dotctl checkout
if [ $? = 0 ]; then
  echo "Checked out dotfiles.";
else
  echo "Backing up pre-existing dotfiles.";
  dotctl checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .dotfiles-backup/{}
fi;
dotctl checkout
dotctl config status.showUntrackedFiles no
