IMAGE_TAG=$1

# Create directory for repositories
mkdir -p repos/
cd repos/

# Clone private repositories.
./../prepare-git-repo.sh hello-gwasm-runner
./../prepare-git-repo.sh gudot
./../prepare-git-repo.sh key_cracker_cpp
./../prepare-git-repo.sh key_cracker_rust

# Build docker image
cd ../
docker build --target=lightweight -t golemfactory/gwasm-tutorial:$IMAGE_TAG .
docker build --target=presenter -t golemfactory/gwasm-tutorial:$IMAGE_TAG-presenter .
