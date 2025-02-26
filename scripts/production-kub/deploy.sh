#
# Builds, publishes and deploys all microservices to a production Kubernetes instance.
#
# Usage:
#
#   ./scripts/production-kub/deploy.sh
#

set -u # or set -o nounset
: "flixtubekitti.azurecr.io"

#
# Build Docker images.
#
docker build -t flixtubekitti.azurecr.io/metadata:1 --file ../../metadata/Dockerfile-prod ../../metadata
docker push flixtubekitti.azurecr.io/metadata:1

docker build -t flixtubekitti.azurecr.io/history:1 --file ../../history/Dockerfile-prod ../../history
docker push flixtubekitti.azurecr.io/history:1

docker build -t flixtubekitti.azurecr.io/mock-storage:1 --file ../../mock-storage/Dockerfile-prod ../../mock-storage
docker push flixtubekitti.azurecr.io/mock-storage:1

docker build -t flixtubekitti.azurecr.io/history:1 --file ../../history/Dockerfile-prod ../../history
docker push flixtubekitti.azurecr.io/history:1

docker build -t flixtubekitti.azurecr.io/video-streaming:1 --file ../../video-streaming/Dockerfile-prod ../../video-streaming
docker push flixtubekitti.azurecr.io/video-streaming:1

docker build -t flixtubekitti.azurecr.io/video-upload:1 --file ../../video-upload/Dockerfile-prod ../../video-upload
docker push flixtubekitti.azurecr.io/video-upload:1

docker build -t flixtubekitti.azurecr.io/gateway:1 --file ../../gateway/Dockerfile-prod ../../gateway
docker push flixtubekitti.azurecr.io/gateway:1

docker build -t flixtubekitti.azurecr.io/advertise:1 --file ../../advertise/Dockerfile-prod ../../advertise
docker push flixtubekitti.azurecr.io/advertise:1

# 
# Deploy containers to Kubernetes.
#
# Don't forget to change kubectl to your production Kubernetes instance
#
kubectl apply -f rabbit.yaml
kubectl apply -f mongodb.yaml 
envsubst < metadata.yaml | kubectl apply -f -
envsubst < history.yaml | kubectl apply -f -
envsubst < mock-storage.yaml | kubectl apply -f -
envsubst < video-streaming.yaml | kubectl apply -f -
envsubst < video-upload.yaml | kubectl apply -f -
envsubst < gateway.yaml | kubectl apply -f -
envsubst < advertise.yaml | kubectl apply -f -