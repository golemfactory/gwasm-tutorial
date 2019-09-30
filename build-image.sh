IMAGE_TAG=$1

# Create directory for repositories
rm -r -f repos/
mkdir repos/
cd repos/

# Clone private repositories.
git clone git@github.com:golemfactory/hello-gwasm-runner.git
git clone git@github.com:golemfactory/gudot.git
git clone git@github.com:golemfactory/key_cracker_cpp.git
git clone git@github.com:golemfactory/key_cracker_demo.git
git clone git@github.com:golemfactory/key_cracker_gen.git
#git clone https://github.com/golemfactory/gwasm-runner.git

# Build docker image
cd ../
docker build -t golemfactory/gwasm-tutorial:$IMAGE_TAG .
