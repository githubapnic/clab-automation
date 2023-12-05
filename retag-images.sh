#!/bin/bash

# Check if source and target registries are provided as arguments
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <source_registry> <target_registry>"
  exit 1
fi

# Set source and target registries from command-line arguments
SOURCE_REGISTRY="$1"
TARGET_REGISTRY="$2"

# Get a list of images in the source registry that are already present on the system
IMAGES=$(docker images --format "{{.Repository}}:{{.Tag}}" | grep "$SOURCE_REGISTRY")

# Loop through each image, retag it, and remove the original image
for IMAGE in $IMAGES; do
  SOURCE_TAG="$IMAGE"
  TARGET_TAG="$TARGET_REGISTRY/${IMAGE#"$SOURCE_REGISTRY/"}"

  # Retag the image
  docker tag "$SOURCE_TAG" "$TARGET_TAG"

  # Remove the local copy of the source image
  docker rmi "$SOURCE_TAG"
done

