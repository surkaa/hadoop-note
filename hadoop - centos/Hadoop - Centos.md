# Hadoop 真分布式安装笔记

## 所需软件及安装包


- `VMware`:  [VMware® Workstation 17 Pro](https://www.vmware.com/go/getworkstation-win)

- `Linux`: [centos-7-5-1804](https://www.centos.org/download/)

- `Hadoop`: [hadoop-3.3.5.tar.gz](https://archive.apache.org/dist/hadoop/common/hadoop-3.1.3/hadoop-3.1.3.tar.gz)

- `jdk1.8`:  [jdk-8u212-linux-x64.tar.gz](https://www.oracle.com/rs/java/technologies/javase/javase8u211-later-archive-downloads.html)

- `XShell & XFtp`: [XShell XFtp](https://www.xshell.com/zh/free-for-home-school/)

- 存储虚拟机的空间留够`30GB` (仅安装, 建议50GB)

## 基础知识:

- 掌握 `vim` 编辑器 : [b站教程](https://www.bilibili.com/video/BV13t4y1t7Wg/)

- Linux 的基本命令操作 以及 Linux 如何添加环境变量

- 以下内容的用户名皆使用`centos`用户

- 计算机网络相关知识(ip 子网掩码 dns等)

- hosts文件是什么

## 安装虚拟机

### 在VMware创建虚拟机并配置

![image-20230905150644931](./assets/image-20230905150644931.png)

选择 17.x

![image-20230905150719565](./assets/image-20230905150719565.png)

![image-20230905150733037](./assets/image-20230905150733037.png)

![image-20230905150745228](./assets/image-20230905150745228.png)

![image-20230905150946753](./assets/image-20230905150946753.png)

![image-20230905151002798](./assets/image-20230905151002798.png)

![image-20230905151016660](./assets/image-20230905151016660.png)

![image-20230905151025641](./assets/image-20230905151025641.png)

![image-20230905151033755](./assets/image-20230905151033755.png)

![image-20230905151042417](./assets/image-20230905151042417.png)

![image-20230905151053661](./assets/image-20230905151053661.png)

![image-20230905151106126](./assets/image-20230905151106126.png)

![image-20230905151115743](./assets/image-20230905151115743.png)

![image-20230905151127771](./assets/image-20230905151127771.png)

![image-20230905151208247](./assets/image-20230905151208247.png)

![image-20230905151235392](./assets/image-20230905151235392.png)

### 开启虚拟机

#### 选择语言

![image-20230905151659733](./assets/image-20230905151659733.png)

#### 选择时区

![image-20230905151737452](./assets/image-20230905151737452.png)

#### 配置轻量版桌面

![image-20230905151918569](./assets/image-20230905151918569.png)



![image-20230905151935178](./assets/image-20230905151935178.png)

#### 禁用Kdump

![image-20230905152014905](./assets/image-20230905152014905.png)

![image-20230905152027330](./assets/image-20230905152027330.png)



#### 磁盘分区

![image-20230905152103680](./assets/image-20230905152103680.png)

![image-20230905152129281](./assets/image-20230905152129281.png)

#### 网路配置

![image-20230905152156814](./assets/image-20230905152156814.png)



![image-20230905152221308](./assets/image-20230905152221308.png)

#### 开始安装虚拟机

![image-20230905152244103](./assets/image-20230905152244103.png)

#### 设置Root密码

![image-20230905152317483](./assets/image-20230905152317483.png)

![image-20230905152330118](./assets/image-20230905152330118.png)

#### 添加`test`用户

这里`test`可以是其他非关键字的用户名

![image-20230905152434210](./assets/image-20230905152434210.png)

![image-20230905152448964](./assets/image-20230905152448964.png)

等待安装...

![image-20230905152712736](./assets/image-20230905152712736.png)

#### 安装完成重启即可

![image-20230905153832987](./assets/image-20230905153832987.png)

![image-20230905154044684](./assets/image-20230905154044684.png)

![image-20230905154107037](./assets/image-20230905154107037.png)

### 静态ip配置

centos7.5的网络配置文件的位置是

登录root用户

![image-20230905154432675](./assets/image-20230905154432675.png)

在桌面右键打开终端

![image-20230905154523484](./assets/image-20230905154523484.png)

配置vim

```sh
vim /etc/vimrc
```



![image-20230905154622661](./assets/image-20230905154622661.png)

在文件末尾输入以下内容并保存退出:

```sh
set number
set relativenumber
```

![image-20230905154729185](./assets/image-20230905154729185.png)

#### 配置静态ip

```sh
vim /etc/sysconfig/network-scripts/ifcfg-ens33
```

改成如下 (`注意不要在等号前后留有空格`):

```sh
TYPE="Ethernet"
PROXY_METHOD="none"
BROWSER_ONLY="no"
BOOTPROTO="static"
DEFROUTE="yes"
IPV4_FAILURE_FATAL="no"
IPV6INIT="yes"
IPV6_AUTOCONF="yes"
IPV6_DEFROUTE="yes"
IPV6_FAILURE_FATAL="no"
IPV6_ADDR_GEN_MODE="stable-privacy"
NAME="ens33"
UUID="这是id不需要修改 保持原来的值!!!"
DEVICE="ens33"
ONBOOT="yes"
IPADDR=192.168.1.100
GATEWAY=192.168.1.2
DNS1=192.168.1.2
```

<img src="./assets/image-20230905155709276.png" alt="image-20230905155709276" style="zoom: 67%;" />

#### 重启网络

```sh
service network restart
```

![image-20230905155905586](./assets/image-20230905155905586.png)

出现`OK`即代表完成

可输入

```sh
ifconfig
```

查看ip地址:

<img src="./assets/image-20230905160301583.png" alt="image-20230905160301583" style="zoom: 67%;" />

若仍未配置成功参考Ubuntu的[网络适配器](./hadoop - ubuntu/Hadoop - Ubuntu.md)

配置`hosts`文件

```sh
vim /etc/hosts
```

输入以下内容:

![image-20230905160545662](./assets/image-20230905160545662.png)

同时建议将物理机的hosts文件也做修改成上文

Windows的host文件位置在`C:\Windows\System32\drivers\etc\hosts`

![image-20230905160803440](./assets/image-20230905160803440.png)

#### 重启启用配置

```sh
reboot
```

### XShell连接

XShell连接可以更方便的操作 比如复制 文件的传输

#### 在物理机尝试连接(ping)虚拟机

这一步是测试物理机能否访问虚拟机

```sh
ping centos100
```

![image-20230905161315821](./assets/image-20230905161315821.png)

可以连接说明物理机能访问虚拟机成功

#### 打开XShell配置连接信息

![image-20230906160954909](./assets/image-20230906160954909.png)

#### 输入连接名称

![image-20230906160803752](./assets/image-20230906160803752.png)

#### 连接

![image-20230906161047072](./assets/image-20230906161047072.png)

![image-20230906161130350](./assets/image-20230906161130350.png)

#### 输入连接用户名

![image-20230906161157873](./assets/image-20230906161157873.png)

#### 输入连接用户密码

![image-20230906161305570](./assets/image-20230906161305570.png)

若输入错误可以在`所有会话`页面更改:

![image-20230906161418554](./assets/image-20230906161418554.png)

#### 连接成功

![image-20230906161454471](./assets/image-20230906161454471.png)

### 传输后续用到的安装包

#### 建立目录

建立如下目录 `/opt/software/` 和 `/opt/module/`目录

##### 目录用途:

- `/opt/software/`: 用于存放安装包
- `/opt/module/`: 安装软件的安装位置

```sh
mkdir /opt/software/
mkdir /opt/module/
ll /opt/
```

![image-20230906161746203](./assets/image-20230906161746203.png)

在 `XShell` 打开 `Xftp`: 

![image-20230906162021877](./assets/image-20230906162021877.png)

在左侧(左侧是物理机的文件管理器)进入安装包的位置

在右侧进入`/opt/software/`目录

![image-20230906162154907](./assets/image-20230906162154907.png)

开始传输(选择左侧需要传输的, 拖入右侧即可):

![image-20230906162221417](./assets/image-20230906162221417.png)

#### 在控制台查看:

```sh
cd /opt/software/
ll
```

![image-20230906162317016](./assets/image-20230906162317016.png)

### 开始安装JDK

#### 解压安装包

```sh
tar -zxvf jdk-8u212-linux-x64.tar.gz -C /opt/module/
```

安装成功示例:

![image-20230906162646764](./assets/image-20230906162646764.png)

#### 添加Java的环境变量

```sh
vim /etc/profile.d/my_env.sh
```

输入以下内容

```sh
# JAVA_HOME
export JAVA_HOME=/opt/module/jdk1.8.0_212
export PATH=$PATH:$JAVA_HOME/bin
```

![image-20230906163330001](./assets/image-20230906163330001.png)

#### 加载环境变量

```sh
source /etc/profile
java -version
```

![image-20230906163427379](./assets/image-20230906163427379.png)

### 安装Hadoop

#### 解压安装包

```sh
cd /opt/software/
tar -zxvf hadoop-3.1.3.tar.gz -C /opt/module/
```

#### 添加Hadoop环境变量

```sh
vim /etc/profile.d/my_env.sh
```

添加以下内容:

```sh
# HADOOP_HOME
export HADOOP_HOME=/opt/module/hadoop-3.1.3
export PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin
```

![image-20230906164145900](./assets/image-20230906164145900.png)

#### 加载环境变量

```sh
source /etc/profile
hadoop version
```

![image-20230906164235776](./assets/image-20230906164235776.png)

如果输入 `hadoop version` 出错则先 `sycn` 后重启( `reboot` )

#### hadoop目录结构

- bin: 存放对Hadoop相关服务（HDFS,YARN）进行操作的脚本
- etc: Hadoop的配置文件目录，存放Hadoop的配置文件
- lib: 存放Hadoop的本地库（对数据进行压缩解压缩功能）
- sbin: 存放启动或停止Hadoop相关服务的脚本 
- share: 存放Hadoop的依赖jar包、文档、和官方案例

```sh
ll
```

![image-20230906165627143](./assets/image-20230906165627143.png)

### 授予 `test` 用户 `sudo时免密` 权限

编辑sudoers文件

```sh
vim /etc/sudoers
```

在`root ALL=(ALL) ALL`这一行下面添加

```sh
test    ALL=(ALL)       NOPASSWD:ALL
```

![image-20230906193421102](./assets/image-20230906193421102.png)

### 将 `module` 目录权限交给 `test`

```sh
chown test:test -R /opt/module/
```

查看目录权限

```sh
ll
```

![image-20230906170951973](./assets/image-20230906170951973.png)

### 测试本地运行

#### 创建测试输入用例

```sh
mkdir wcinput
cd wcinput/
vim word.txt
```

输入任意单词的内容

![image-20230906170102521](./assets/image-20230906170102521.png)

然后回到hadoop安装目录

```sh
cd $HADOOP_HOME
```

#### 执行本地运行测试

`wordcount`是一个统计单词数量的命令

```sh
hadoop jar share/hadoop/mapreduce/hadoop-mapreduce-examples-3.1.3.jar wordcount wcinput/ wcoutput
```

#### 成功输出样例

![image-20230906170406523](./assets/image-20230906170406523.png)

查看输出结果

```sh
cat wcoutput/part-r-00000
```

![image-20230906170517087](./assets/image-20230906170517087.png)

### 克隆虚拟机

上一步已经测试完成, 接下来将虚拟机克隆, 以完成完全分布式运行

#### 关闭centos100虚拟机

```sh
poweroff
```

#### 克隆

然后在 `VMware` 的 `我的计算机` 中选择 `centos100` `右键` 选择 `管理` 在选择 `克隆`

![image-20230906194235133](./assets/image-20230906194235133.png)

![image-20230906194458508](./assets/image-20230906194458508.png)

![image-20230906194511949](./assets/image-20230906194511949.png)

![image-20230906194526388](./assets/image-20230906194526388.png)

![image-20230906194540751](./assets/image-20230906194540751.png)

![image-20230906194606830](./assets/image-20230906194606830.png)

![image-20230906194614613](./assets/image-20230906194614613.png)

同样的方法克隆三台

- `centos101`: 暂时无用(空间不足可以不备份)

- `centos102`: TODO

- `centos103`: TODO

- `centos104`: TODO

#### 修改设备克隆出来的设备名及其静态IP

现在总共有5台虚拟机

我们将从 `centos102` 轮流启动

- 修改设备名: 需要以 `root` 用户编辑 `/etc/hostname` 文件
- 修改静态IP配置: 需要以 `root` 用户编辑 `/etc/`

`centos102` 启动完成: 

![image-20230906195607790](./assets/image-20230906195607790.png)

在 `XShell` 中连接 (**此时应该确保只有 `centos102` 在启动状态 其他的虚拟机都应保持关机**):

![image-20230906195710675](./assets/image-20230906195710675.png)

这里选择 `XShell` 中的 `centos100` 是因为现在虚拟机 `centos102` 的ip仍是 `centos100` 的 也即 `192.168.1.100`

![image-20230906195839725](./assets/image-20230906195839725.png)

##### 编辑设备名

```sh
vim /etc/hostname
```

输入以下内容

```sh
centos102
```

![image-20230906195952856](./assets/image-20230906195952856.png)

##### 编辑静态IP

```sh
vim /etc/sysconfig/network-scripts/ifcfg-ens33
```

将 `IPADDR` 的值改成 `192.168.1.102`: 

![image-20230906200125641](./assets/image-20230906200125641.png)

#### 然后重启虚拟机

```sh
reboot
```

重启后虚拟机 `centos102` 的ip将更改为 `192.168.1.102` 

在 `XShell` 中再次使用先前配置的 `centos100` 就无法再次连接  

可以复制 `XShell` 中的配置:

![image-20230906200516495](./assets/image-20230906200516495.png)

![image-20230906200547609](./assets/image-20230906200547609.png)

然后将副本重命名成 `centos102`

同时将对应的主机改成 `centos102`:

![image-20230906201113408](./assets/image-20230906201113408.png)

然后选择连接:

![image-20230906201229277](./assets/image-20230906201229277.png)

验证:

![image-20230906201413206](./assets/image-20230906201413206.png)

#### 重复上述 `克隆虚拟机` 的操作:

重复上述 `克隆虚拟机` 的操作得到 `centos102` 和 `centos103` (若上述操作没有错误, 可以保持已完成配置的虚拟机的开启状态):

![image-20230906201821047](./assets/image-20230906201821047.png)

![image-20230906201746477](./assets/image-20230906201746477.png)

![image-20230906201800167](./assets/image-20230906201800167.png)

### 编写集群文件分发脚本

这个脚本将十分方便的帮助我们在集群中个各个节点 `传输/同步` 文件

```sh
su test    # 切换用户
cd         # 进入用户主目录
mkdir bin  # 创建脚本文件夹
cd bin     # 进入脚本文件夹
vim xsync  # 创建脚本
```

```sh
#!/bin/bash
#1. 判断参数个数
if [ $# -lt 1 ]; then
  echo Not Enough Arguement!
  exit
fi
#2. 遍历集群所有机器
for host in centos102 centos103 centos104; do
  echo ==================== $host ====================
  #3. 遍历所有目录，挨个发送
  for file in $@; do
    #4. 判断文件是否存在
    if [ -e $file ]; then
      #5. 获取父目录
      pdir=$(
        cd -P $(dirname $file)
        pwd
      )
      #6. 获取当前文件的名称
      fname=$(basename $file)
      ssh $host "mkdir -p $pdir"
      rsync -av $pdir/$fname $host:$pdir
    else
      echo $file does not exists!
    fi
  done
done
```

![image-20230906171905140](./assets/image-20230906171905140.png)

#### 给脚本添加执行权限

```sh
chown +x xsync
ll
```

#### 将脚本复制到 `/bin/` 下

这里需要使用 `root` 权限

```
cp /home/test/bin/xsync /bin/
```

![image-20230906203846324](./assets/image-20230906203846324.png)

### 制作三台虚拟机的免密登录

因为只有三台虚拟机 每台都有各自的功能

没有多余的负载子节点 **所以需要将三台虚拟机都做成互相免密登录**

事实上 子节点本应是不需要做对主节点的免密登录的

这里只是因为作者电脑无法同时启动过多虚拟机

#### 使用 `test` 用户生成密钥

这一步三台虚拟机保持同步 都需要执行 (这里虚拟机可能会询问三个问题, 我们只需要保持默认即可, **直接回车**)

```sh
ssh-keygen -t rsa
```

![image-20230906204557019](./assets/image-20230906204557019.png)

这样将会在 `test` 用户的主目录下生成一个 `.ssh` 的文件夹储存密钥:

![image-20230906204614866](./assets/image-20230906204614866.png)

#### 分发公钥

注意这个的 `x` 和 `y` 在 `1` `2` `3` 中任意取

既有 `3 * 3 = 9` 种情况来分发密钥

在 `centos10x` 中输入:

```sh
ssh-copy-id centos10y
```

输入 `yes` 后在输入 `test@centos10y` 的用户密码

![image-20230906210548181](./assets/image-20230906210548181.png)

以下是 ` centos104` 的配置免密登录的过程:

![image-20230906210956610](./assets/image-20230906210956610.png)

### 集群

#### 集群部署规划

| 虚拟机 \ 分布式 | HDFS 分布式文件系统 | YARN 资源管理器 |
| ------------------- | -------------------- | --------------- |
| centos102           | NameNode + DataNode | NodeManager     |
| centos103           | DataNode             | NodeManager + ResourceManager |
| centos104           | SecondaryNameNode + DataNode | NodeManager |

#### 集群默认配置文件

集群的默认配置文件及其所在位置 (**无需更改**):

- `core-default.xml`:  hadoop-common-3.1.3.jar/ core-default.xml 
- `hdfs-default.xml`:  hadoop-hdfs-3.1.3.jar/ hdfs-default.xml
- `yarn-default.xml`:  hadoop-yarn-common-3.1.3.jar/ yarn-default.xml 
- `mapred-default.xml`:  hadoop-mapreduce-client-core-3.1.3.jar/ mapred-default.xml

#### 集群自定义配置文件

需要更改的自定义配置文件如下:

- core-site.xml
- hdfs-site.xml
- yarn-site.xml
- mapred.site.xml
- workers

这些配置文件都在目录 `/opt/module/hadoop-3.1.3/etc/hadoop` 下

可以使用以下命令进入

```sh
cd /opt/module/hadoop-3.1.3/etc/hadoop
```

请将上述的五个配置文件分别改成如下内容:

##### core-site.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<!--
  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License. See accompanying LICENSE file.
-->

<!-- Put site-specific property overrides in this file. -->

<configuration>
  <!-- 指定 NaneNode 地址 -->
  <property>
    <name>fs.defaultFS</name>
    <value>hdfs://hadoop-ywn102:9820</value>
  </property>
  <!-- 指定 Hadoop 数据的存储目录 -->
  <property>
    <name>hadoop.tmp.dir</name>
    <value>/opt/module/hadoop-3.1.3/data</value>
  </property>
  <!-- 配置 HDFS 网页登录使用的静态用户为 hadoop -->
  <property>
    <name>hadoop.http.staticuser.user</name>
    <value>hadoop</value>
  </property>
  <!-- 配置该 Hadoop (superUser)允许通过代理访问的主机节点 -->
  <property>
    <name>hadoop.proxyuser.hadoop.hosts</name>
    <value>*</value>
  </property>
  <!-- 配置该 Hadoop (superUser)允许通过代理用户所属组 -->
  <property>
    <name>hadoop.proxyuser.hadoop.groups</name>
    <value>*</value>
  </property>
</configuration>
```

##### hdfs-site.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<!--
  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License. See accompanying LICENSE file.
-->

<!-- Put site-specific property overrides in this file. -->

<configuration>
  <!-- nn web端访问地址-->
  <property>
    <name>dfs.namenode.http-address</name>
    <value>hadoop-ywn102:9870</value>
  </property>
  <!-- 2nn web端访问地址-->
  <property>
    <name>dfs.namenode.secondary.http-address</name>
    <value>hadoop-ywn104:9868</value>
  </property>
</configuration>

```

##### yarn-site.xml

```xml
<?xml version="1.0"?>
<!--
  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License. See accompanying LICENSE file.
-->
<configuration>

<!-- Site specific YARN configuration properties -->

  <!-- 指定MR 用 shuffle -->
  <property>
    <name>yarn.nodemanager.aux-services</name>
    <value>mapreduce_shuffle</value>
  </property>

  <!-- 指定ResourceManager的地址-->
  <property>
    <name>yarn.resourcemanager.hostname</name>
    <value>hadoop-ywn103</value>
  </property>

  <!-- 环境变量的继承 -->
  <property>
    <name>yarn.nodemanager.env-whitelist</name>
    <value>JAVA_HOME,HADOOP_COMMON_HOME,HADOOP_HDFS_HOME,HADOOP_CONF_DIR,CLASSPATH_PREPEND_DISTCACHE,HADOOP_YARN_HOME,HADOOP_MAPRED_HOME</value>
  </property>

  <!-- yarn容器允许分配的最大最小内存 -->
  <property>
    <name>yarn.scheduler.minimum-allocation-mb</name>
    <value>512</value>
  </property>
  <property>
    <name>yarn.scheduler.maximum-allocation-mb</name>
    <value>4096</value>
  </property>

  <!-- yarn容器允许管理的物理内存大小 -->
  <property>
    <name>yarn.nodemanager.resource.memory-mb</name>
    <value>4096</value>
  </property>

  <!-- 关闭yarn对物理内存和虚拟内存的限制检查 -->
  <property>
    <name>yarn.nodemanager.pmem-check-enabled</name>
    <value>false</value>
  </property>

  <property>
    <name>yarn.nodemanager.vmem-check-enabled</name>
    <value>false</value>
  </property>
    
</configuration>
```

##### yarn-site.xml

```xml
<?xml version="1.0"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<!--
  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License. See accompanying LICENSE file.
-->

<!-- Put site-specific property overrides in this file. -->

<configuration>
  <!-- 指定MapReduce程序运行在Yarn上 -->
  <property>
    <name>mapreduce.framework.name</name>
    <value>yarn</value>
  </property>
</configuration>
```

##### workers

```
centos102
centos103
centos104
```

![image-20230906213740170](./assets/image-20230906213740170.png)

##### 向其他节点同步配置文件

```sh
xsync /opt/module/hadoop-3.1.3/etc/hadoop/
```

#### 集群常用端口

| Daemon            | App                        | Hadoop2     | Hadoop3 |
| ----------------- | -------------------------- | ----------- | ------- |
| NameNode Port     | Hadoop HDFS NameNode       | 8020 / 9000 | 9820    |
|                   | Hadoop HDFS NN HTTP UI     | 50070       | 9870    |
| Secondary NN Port | Secondary NameNode         | 50091       | 9869    |
|                   | Secondary NameNode HTTP UI | 50090       | 9868    |
| DataNode Port     | Hadoop HDFS DataNode IPC   | 50020       | 9867    |
|                   | Hadoop HDFS DataNode       | 50010       | 9866    |
|                   | Hadoop HDFS DN HTTP UI     | 50075       | 9864    |

### 启动集群

前面准备了那么多 终于到了启动这一步, 如果担心出错可以将三台虚拟机关机后, 直接将虚拟机的文件夹备份即可, 抑或可以使用VMware自带的快照功能

#### 格式化

启动之前应先格式化节点 (三台虚拟机都需要格式化)

```sh
hdfs namenode -format
```

出现以下结果即为格式化成功

![image-20230906214751761](./assets/image-20230906214751761.png)

#### 启动

在 `centos102` 的 `$HADOOP_HOME` 下输入:

```sh
sbin/start-dfs.sh
```

(`$HADOOP_HOME` 也即 `/opt/module/hadoop-3.1.3`)

然后在 `centos103` 的 `$HADOOP_HOME` 下输入:
```sh
sbin/start-yarn.sh
```

![image-20230906215902256](./assets/image-20230906215902256.png)

![image-20230906215909857](./assets/image-20230906215909857.png)

使用 `jps` 命令查看启动情况:

![image-20230906224006392](./assets/image-20230906224006392.png)

![image-20230906224014362](./assets/image-20230906224014362.png)

![image-20230906224022383](./assets/image-20230906224022383.png)

然后在**物理机的**浏览器查看启动情况

- http://centos102:9870
- http://centos103:8088

显示情况分别如下:

![image-20230906224119232](./assets/image-20230906224119232.png)

![image-20230906224125289](./assets/image-20230906224125289.png)



























