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
$ sudo apt-get install -y libffi-dev libssl-dev
$ sudo apt-get install -y python3-dev
$ sudo apt-get install -y python3 python3-pip
$ pip3 install docker-compose
```
Make sure, ``~/.local`` is within ``$PATH`` or re-link e.g. it to ``/usr/local``.  


## Build

```
$ ./setup.sh
```


## Usage

```
$ cd ./docker
$ docker-compose -f ./docker-compose.yml run --rm sifive-unmatched /bin/bash

docker$ build.sh
```


## Development

```
$ cd ./docker
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
