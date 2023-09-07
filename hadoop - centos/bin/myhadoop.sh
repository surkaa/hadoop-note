#!/bin/bash
if [ $# -lt 1 ]; then
  echo "No Args Input..."
  echo "Please Use: $0 [start|stop]"
  exit
fi
case $1 in
"start")
  echo " ====== 启动 hadoop集群 ======"
  echo " --------------- 启动 hdfs ---------------"
  ssh hadoop-ywn102 "/opt/module/hadoop-3.1.3/sbin/start-dfs.sh"
  echo " --------------- 启动 yarn ---------------"
  ssh hadoop-ywn103 "/opt/module/hadoop-3.1.3/sbin/start-yarn.sh"
  echo " --------------- 启动 historyserver ---------------"
  ssh hadoop-ywn102 "/opt/module/hadoop-3.1.3/bin/mapred --daemon start historyserver"
  ;;
"stop")
  echo " ===== 关闭 hadoop集群 ====="
  echo " --------------- 关闭 historyserver ---------------"
  ssh hadoop-ywn102 "/opt/module/hadoop-3.1.3/bin/mapred --daemon stop historyserver"
  echo " --------------- 关闭 yarn ---------------"
  ssh hadoop-ywn103 "/opt/module/hadoop-3.1.3/sbin/stop-yarn.sh"
  echo " --------------- 关闭 hdfs ---------------"
  ssh hadoop-ywn102 "/opt/module/hadoop-3.1.3/sbin/stop-dfs.sh"
  ;;
*)
  echo "Input Args Error..."
  ;;
esac
