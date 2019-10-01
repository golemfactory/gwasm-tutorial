REPOSITORY_NAME=$1

cd $REPOSITORY_NAME

# Check if repository exists.
if [ -d .git ]; then
    echo "$REPOSITORY_NAME - Repository exists. Not cloning."
else
    git clone git@github.com:golemfactory/$REPOSITORY_NAME.git
fi

git checkout master
git pull origin master

cd ..
