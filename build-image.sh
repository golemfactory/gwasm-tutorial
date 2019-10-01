IMAGE_TAG=$1

# Create directory for repositories
mkdir -p repos/
cd repos/

# Clone private repositories.
./../prepare-git-repo.sh hello-gwasm-runner
./../prepare-git-repo.sh gudot
./../prepare-git-repo.sh key_cracker_cpp
./../prepare-git-repo.sh key_cracker_demo
./../prepare-git-repo.sh key_cracker_gen

# Build docker image
cd ../
docker build -t golemfactory/gwasm-tutorial:$IMAGE_TAG .
