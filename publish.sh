#!/bin/sh
docker image build . -t duluca/minimal-nginx-web-server:1.13.8-alpine
docker image tag duluca/minimal-nginx-web-server:1.13.8-alpine duluca/minimal-nginx-web-server:latest
docker image push duluca/minimal-nginx-web-server:1.13.8-alpine
docker image push duluca/minimal-nginx-web-server:latest