REPOSITORY_NAME=$1

cd $REPOSITORY_NAME

git clone git@github.com:golemfactory/$REPOSITORY_NAME.git
git checkout master
git pull origin master

cd ..
