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




## Yocto

Login user: 'root'  
TODO  

### Build

```
$ cd yocto
$ docker-compose up
```

### Usage

```
$ docker-compose -f ./docker-compose.yml run --rm sifive-unmatched /bin/bash

$ build.sh
```

### Development

```
$ cd ./yocto

$ docker-compose -f ./docker-compose.yml run --rm sifive-unmatched /bin/bash
    Creating yocto_sifive-unmatched_run ... done
    To run a command as administrator (user "root"), use "sudo <command>".
    See "man sudo_root" for details.

$ build.sh
    ...
```


### SD Card

TODO  
