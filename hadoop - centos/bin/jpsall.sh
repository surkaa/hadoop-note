#!/bin/bash
for host in hadoop-ywn102 hadoop-ywn103 hadoop-ywn104
do
echo =============== $host ===============
ssh $host jps $@ | grep -v Jps
done