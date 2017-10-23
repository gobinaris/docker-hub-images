#!/usr/bin/env bash

set -e

base="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [[ $# -ne 1 ]]; then
    echo "You must set a version number"
    echo "./deploy.sh <terraform version>"
    exit 1
fi

version=$1
dockerfile_version=$(grep TERRAFORM_VERSION= ${base}/Dockerfile-full | cut -d= -f2)

if [[ $version != $dockerfile_version ]]; then
    echo "Version mismatch in 'Dockerfile-light'"
    echo "found ${dockerfile_version}, expected ${version}."
    echo "Make sure the versions are correct."
    exit 1
fi

echo "Building docker images for terraform ${version}..."
docker build -f "${base}/Dockerfile-full" -t gobinaris/terraform:full .
# docker build -f "${base}/Dockerfile-light" -t gobinaris/terraform:light .
docker tag gobinaris/terraform:full gobinaris/terraform:${version}
docker tag gobinaris/terraform:full gobinaris/terraform:latest

echo "Uploading docker images for terraform ${version}..."
docker push gobinaris/terraform:${version}
docker push gobinaris/terraform:latest
docker push gobinaris/terraform:full
