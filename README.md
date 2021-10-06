[![CircleCI](https://circleci.com/gh/Rubusch/docker__sifive-unmatched.svg?style=shield)](https://circleci.com/gh/Rubusch/docker__sifive-unmatched)
[![License: GPL v3](https://img.shields.io/badge/License-GPL%20v3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0.html)



UNDER CONSTRUCTION   
------------------



# Docker for Sifive Unmatched BSP

The container shall provide a host system which serves to execute a specific build environment. The build environment itself then shall be mounted in, and kept plain outside the conainer image  


## References

official documentation, links to the reference manuals and datasheets of U740 and CO  
https://www.sifive.com/boards/hifive-unmatched

dynamic, growing, community guide  
https://github.com/carlosedp/riscv-bringup/tree/master/unmatched

sifive yocto layer  
https://github.com/sifive/meta-sifive


## Tools Needed

```
$ sudo curl -L "https://github.com/docker/compose/releases/download/1.28.6/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
$ sudo chmod a+x /usr/local/bin/docker-compose
```

NB: Where 1.28.6 is the latest version (currently not supported by devian/ubuntu package management)  


## Preparations

multistaged docker container: make sure you have the specified baseimage! first
obtain the baseimage name and tag, e.g.
```
$ cat ./docker/build_context/Dockerfile
    ...
    ARG DOCKER_BASE="sandbox"
    ARG DOCKER_BASE_TAG="20211006"
    ...

$ cd /usr/src
$ git clone https://github.com/Rubusch/docker__sandbox.git
$ cd ./docker__sandbox
$ git co 20211006
    <build container as described in README.md there>
```

## Build

```
$ cd docker
$ docker-compose up
```

## Usage

```
$ cd ./docker__yocto
$ docker-compose -f ./docker-compose.yml run --rm sifive-unmatched /bin/bash

docker$ build.sh
```

## Development

```
$ cd docker
$ docker-compose -f ./docker-compose.yml run --rm sifive-unmatched /bin/bash
```

optionally/initially: update setup  
```
docker$ cd /home/user/poky
docker$ chmod a+x ./meta-sifive/setup.sh
docker$ ./meta-sifive/setup.sh
```

```
docker$ cd /home/user/poky
docker$ . ./openembedded-core/oe-init-build-env build"
docker$ bitbake <YOCTO IMAGE>"
    ...
```
(alternatively call ``build.sh``)  

e.g. build the sdk toolchain for _demo-coreip-cli_  
```
docker$ bitbake demo-coreip-cli -c populate_sdk
```


## Yocto

Login user: 'root'  
TODO  


### SD Card

TODO  
