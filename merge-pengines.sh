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
git rm --cached run.pl
git rm --cached daemon.pl
git rm --cached debug.pl
git rm --cached load.pl
git rm --cached server.pl
git rm --cached storage.pl
git rm -r --cached ./apps/genealogist
git rm -r --cached ./apps/scratchpad
git rm -r --cached ./apps/swish
git rm -r --cached ./lib
git rm -r --cached ./systemd
git rm -r --cached ./upstart
git rm -r --cached ./www

#remove unneeded stuff
rm run.pl
rm load.pl
rm -rf ./apps/genealogist
rm -rf ./apps/scratchpad
rm -rf ./apps/swish
