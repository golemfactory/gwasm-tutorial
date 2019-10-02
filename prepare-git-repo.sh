REPOSITORY_NAME=$1

# Check if repository exists.
if [ -d $REPOSITORY_NAME/.git ]; then
    echo "$REPOSITORY_NAME - Repository exists. Not cloning."
else
    git clone git@github.com:golemfactory/$REPOSITORY_NAME.git
fi

cd $REPOSITORY_NAME

git checkout master
git pull origin master

cd ..
