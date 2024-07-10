# Amazon s3 automated cleanup



## Getting started

This script depends on the s3cmd binary that is already authenticated. It's can be run directly or scheduled with crontab. It accepts two arguments: 

* server
* retention in days

`bash s3-cleanup.sh -s cobalt -r 30`

Naming convention of s3 buckets is: 

`wp-{ SERVER NAME }-daily-backups`