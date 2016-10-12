puppet-role_iontorrent
==================

iontorrent role manifest for puppet in a foreman environment.

Parameters
-------------
All parameters are read from defaults in init.pp and can be overwritten by hiera or The foreman


```
  $destination          = 'ionbackup@x.x.x.x:/data/ionbackup',    ' destination for backup
  $scriptdir            = '/opt/ionbackup"',                      ' directory where script + key will be installed
  $privatekeyname       = 'ionbackup.key',                        ' private key file name, should exist in files
  $throttle             = '6400',                                 ' throttle rsync max throughput
  $removefromarchive    = '730',                                  ' Remove files from archive older than x days


```


Classes
-------------
role_iontorrent

Dependencies
-------------


Result
-------------
Working iontorrent backup script based on rsync. 


Limitations
-------------
This module has been built on and tested against Puppet 3 and higher.

The module has been tested on:
- Ubuntu 14.04LTS 


Authors
-------------
Author Name <hugo.vanduijn@naturalis.nl>