#avoid merge conflict
mv .gitignore .gitignore-copy

#merge pengines
git remote add pengines-master https://github.com/SWI-Prolog/pengines.git
git add *
git stash
git fetch pengines-master --tags
git merge --allow-unrelated-histories pengines-master/master
git remote remove pengines-master

#recover .gitignore
rm .gitignore
mv .gitignore-copy .gitignore

#remove inappropriate git tracking
git rm -f run.pl
git rm --cached daemon.pl
git rm --cached debug.pl
git rm -f load.pl
git rm --cached server.pl
git rm --cached storage.pl
git rm -r -f ./apps/genealogist
git rm -r -f ./apps/scratchpad
git rm -r -f ./apps/swish
git rm -r --cached ./lib
git rm -r --cached ./systemd
git rm -r --cached ./upstart
git rm -r --cached ./www
git rm -f .gitmodules
git rm -f LICENSE
git rm -f README.md
git rm -f TODO.md
