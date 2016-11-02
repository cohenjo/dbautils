#!/bin/bash
pids=`ps -ef | grep postg | grep idle | awk '{ print $2 }' `
for i in $pids ; do kill -15 $i; done