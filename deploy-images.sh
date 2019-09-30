source ./deploy-names.sh $1
set -e      # Fail if any command fails

# Build image
./build-image.sh $IMAGE_TAG

# Push image to dockerhub. Other machines will access image from there.
docker push $IMAGE_DOCKERHUB_NAME:$IMAGE_TAG

# Deploy 
./deploy-single-server.sh witek@10.30.8.246 30322 $IMAGE_TAG
./deploy-single-server.sh ubuntu@52.31.143.91 22 $IMAGE_TAG
