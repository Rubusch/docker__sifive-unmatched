[![License: GPL v3](https://img.shields.io/badge/License-GPL%20v3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0.html)

# Docker for Sifive Unmatched BSP

## References

official documentation, links to the reference manuals and datasheets of U740 and CO  
https://www.sifive.com/boards/hifive-unmatched

dynamic, growing, community guide  
https://github.com/carlosedp/riscv-bringup/tree/master/unmatched

sifive yocto layer  
https://github.com/sifive/meta-sifive


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
$ docker-compose -f ./docker-compose.yml run --rm sifive-linux /bin/bash

$ build.sh
```

### SD Card

TODO  
