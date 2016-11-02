#!/bin/bash
cp rlwrap_alias.sh /etc/profile.d/

tar -xzvf rlwrap-0.37.tar.gz --directory=/tmp
cd /tmp/rlwrap-0.37/
./configure ; make install