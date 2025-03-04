LOGIN=$1
PORT=$2

source ./deploy-names.sh $3
set -e      # Fail if any command fails

# Connect with machine with docker registry
echo "Connecting to docker registry server..."
ssh -p $PORT $LOGIN /bin/bash << EOF

docker pull $IMAGE_DOCKERHUB_NAME:$IMAGE_TAG
docker pull $IMAGE_DOCKERHUB_NAME:$IMAGE_TAG-full

docker tag $IMAGE_DOCKERHUB_NAME:$IMAGE_TAG $IMAGE_HOSTNAME/$IMAGE_BASENAME:$IMAGE_TAG
docker tag $IMAGE_DOCKERHUB_NAME:$IMAGE_TAG $IMAGE_HOSTNAME/$IMAGE_BASENAME:latest
docker tag $IMAGE_DOCKERHUB_NAME:$IMAGE_TAG-full $IMAGE_HOSTNAME/$IMAGE_BASENAME:$IMAGE_TAG-full
docker tag $IMAGE_DOCKERHUB_NAME:$IMAGE_TAG-full $IMAGE_HOSTNAME/$IMAGE_BASENAME:full

docker push $IMAGE_HOSTNAME/$IMAGE_BASENAME:$IMAGE_TAG
docker push $IMAGE_HOSTNAME/$IMAGE_BASENAME:latest
docker push $IMAGE_HOSTNAME/$IMAGE_BASENAME:$IMAGE_TAG-full
docker push $IMAGE_HOSTNAME/$IMAGE_BASENAME:full

EOF
