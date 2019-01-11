[![Build Status](https://travis-ci.com/philips-software/goss.svg?branch=master)](https://travis-ci.com/philips-software/goss)
[![Slack](https://philips-software-slackin.now.sh/badge.svg)](https://philips-software-slackin.now.sh)

# Docker images

This repo will contain docker images.

Current versions available:
```
.
├── 0.4.0
│   └── alpine
│       └── Dockerfile
```
## Usage

Images can be found on [https://hub.docker.com/r/philipssoftware/goss/](https://hub.docker.com/r/philipssoftware/goss/).

Make sure that a `goss.yaml` file is located in the repository root folder.
When running locally. This file should be located in the working directory of the container (e.g mount volume).

Example of such file:

```
file:
  /app/service.jar:
    exists: true
  /app/start.sh:
    exists: true

```

Name  | Description                                   | Required
------|-----------------------------------------------|----------------------------
-r    | The location of the docker repository         | true
-i    | The name of the image that needs to be tested | true
-t    | The tag of the image (e.g latest)             | true


```
docker run -it --rm philipssoftware/goss:0.3.6 -v $(pwd):/app test.sh -r https://hub.docker.com -i philipssoftware/bats -t 1.1.0 
```


## Content

The images obviously contain goss, but also two other files:
- `REPO`
- `TAGS`

### REPO

This file has a url to the REPO with specific commit-sha of the build.
Example: 

```
$ docker run -it --rm philipssoftware/goss:0.3.6 cat REPO
https://github.com/philips-software/goss/tree/36ea34634d022e26d87d3e6b3e0f0d2841327e00
```

### TAGS

This contains all the similar tags at the point of creation. 

```
$ docker run -it --rm philipssoftware/goss:0.3.6 cat TAGS
goss goss:0.3.6 goss:0.3.6-alpine
```

You can use this to pin down a version of the container from an existing development build for production. When using `goss:0.3.6` for development. This ensures that you've got all security updates in your build. If you want to pin the version of your image down for production, you can use this file inside of the container to look for the most specific tag, the last one.

## Simple Tags

### goss
- `goss`, `goss:0.3.6`, `goss:0.3.6-alpine` [0.3.6/alpine/Dockerfile](0.3.6/alpine/Dockerfile)

## Why

> Why do we have our own docker image definitions?

We often need goss to test our containers. There is no official docker image, so let's make a version for our build pipelines.

## Issues

- If you have an issue: report it on the [issue tracker](https://github.com/philips-software/goss/issues)

## Author

- Jeroen Knoops <jeroen.knoops@philips.com>
- Heijden, Remco van der <remco.van.der.heijden@philips.com>

## License

License is MIT. See [LICENSE file](LICENSE.md)

## Philips Forest

This module is part of the Philips Forest.

```
                                                     ___                   _
                                                    / __\__  _ __ ___  ___| |_
                                                   / _\/ _ \| '__/ _ \/ __| __|
                                                  / / | (_) | | |  __/\__ \ |_
                                                  \/   \___/|_|  \___||___/\__|  

                                                                 Infrastructure
```

Talk to the forestkeepers in the `docker-images`-channel on Slack.

[![Slack](https://philips-software-slackin.now.sh/badge.svg)](https://philips-software-slackin.now.sh)
