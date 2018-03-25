# docker-nginx

> Forked from kyma/docker-nginx

A high-performance Alpine-based Nginx base image for Docker to serve static websites. It will serve anything in the `/var/www` directory.

To build a Docker image for your site, you'll need to create a `Dockerfile`. For example, if your site is in a directory called `dist`, you could create this `Dockerfile`:
```Dockerfile
FROM duluca/minimal-nginx-web-server
COPY dist /var/www
CMD 'nginx'
```
Then build and run it:
```Bash
$ docker build -t mysite .
...
Successfully built 5ae2fb5cf4f8
$ docker run -p 80:80 -d mysite
da809981545f
$ curl localhost
...
```
## SSL

To use SSL, put your certs in `/etc/nginx/ssl` and enable the `default-ssl` site:

```Dockerfile
ADD server.crt /etc/nginx/ssl/
ADD server.key /etc/nginx/ssl/
RUN ln -s /etc/nginx/sites-available/default-ssl /etc/nginx/sites-enabled/default-ssl
```

When you run it, you'll want to make port 443 available, e.g.:

```Bash
    $ docker run -p 80:80 -p 443:443 -d mysite
```

_Beware:_ Setting up `HTTPS` in production is not a straight forward process. For the most part you'll be relying on your cloud provider to do the complicated stuff for you, like housing your private keys, reverse proxying or load balancing. In that case use the guide below.
### HTTPS Forwarding (Work in progress - nonfunctional)
Modify your `Dockerfile` per the guide below to copy different nginx configurations from the container's `tmp` directory given your specific cloudhost:

| Environment | Header | Config File |
| --- | --- | --- |
| Generic |   | Not implemented |
| AWS, Heroku, Nginx, LoadBalancer, etc. | x-forwarded-proto | `default-xproto` |
| Azure | x-arr-ssl | Not implemented |
| Custom | X-Forwarded-Host | Not implemented |

#### AWS, Heroku, Nginx, LoadBalancer, etc.
```Dockerfile
FROM duluca/minimal-nginx-web-server
RUN cp /tmp/default-xproto /etc/nginx/sites-enabled/default
COPY dist /var/www
CMD 'nginx'
```
For instance health checks use `/healthCheck` to bypass HTTPS enforcement.

## nginx.conf

The nginx.conf and mime.types are pulled with slight modifications from
the h5bp Nginx HTTP server boilerplate configs project at
https://github.com/h5bp/server-configs-nginx

## Customized configs

To modify the NGINX config, you would just create a custom Dockerfile like the following
where you copy in your modified config files.

```dockerfile
# Guide here:
# https://github.com/KyleAMathews/docker-nginx

# Build docker file
# docker build -t CONTAINERNAME .

# Build from this repo's image
FROM duluca/minimal-nginx-web-server

# Example if you wanna swap the default server file.
COPY path/to/your/default /etc/nginx/sites-enabled/default

# Add dist
COPY dist /var/www

CMD 'nginx'
```

## For Developers

### Build & Publish
Execute `./publish.sh`