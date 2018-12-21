#!/bin/sh
VERSION=1.15.7
docker image build . -t duluca/minimal-nginx-web-server:$VERSION-alpine
docker image tag duluca/minimal-nginx-web-server:$VERSION-alpine duluca/minimal-nginx-web-server:latest
docker image push duluca/minimal-nginx-web-server:$VERSION-alpine
docker image push duluca/minimal-nginx-web-server:latest


# git push origin :refs/tags/$VERSION
# git tag -fa $VERSION
# git push origin master --tags