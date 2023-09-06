# Hadoop 真分布式安装笔记

## 所需软件及安装包


- `VMware`:  [VMware® Workstation 17 Pro](https://www.vmware.com/go/getworkstation-win)

- `Linux`: [centos-7-5-1804](https://www.centos.org/download/)

- `Hadoop`: [hadoop-3.3.5.tar.gz](https://archive.apache.org/dist/hadoop/common/hadoop-3.1.3/hadoop-3.1.3.tar.gz)

- `jdk1.8`:  [jdk-8u212-linux-x64.tar.gz](https://www.oracle.com/rs/java/technologies/javase/javase8u211-later-archive-downloads.html)

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

改成如下:

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

### 安装jdk

#### 在物理机尝试连接(ping)虚拟机

```sh
ping centos100
```

![image-20230905161315821](./assets/image-20230905161315821.png)

可以连接说明上一步配置成功

#### 传输jdk和hadoop

在虚拟机中建立`/opt/software/`目录

进入物理机存放jdk和hadoop的位置

![image-20230905161634829](./assets/image-20230905161634829.png)

```sh
scp 
```

