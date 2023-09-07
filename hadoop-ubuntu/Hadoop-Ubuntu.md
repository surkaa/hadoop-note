# Hadoop 真分布式安装笔记





## 所需软件及安装包

- `VMware`:  [VMware® Workstation 17 Pro](https://www.vmware.com/go/getworkstation-win)

- `Linux`: [ubuntu-22.04.2-live-server-amd64.iso](https://mirrors.aliyun.com/ubuntu-releases/jammy/ubuntu-22.04.2-live-server-amd64.iso) ( desktop也可以考虑, 不过比较吃电脑 )

- `Hadoop`: [hadoop-3.3.5.tar.gz](https://mirrors.aliyun.com/apache/hadoop/common/hadoop-3.3.5/hadoop-3.3.5.tar.gz)

- 存储虚拟机的空间留够`30G` (仅安装)

## 基础知识:

- 掌握 `vim` 编辑器 : [b站教程](https://www.bilibili.com/video/BV13t4y1t7Wg/)
- Linux 的基本命令操作 以及 Linux 如何添加环境变量

- 以下内容的用户名皆使用hadoop用户



## 第一步创建`Datanode`节点的虚拟机

### 打开VMware

![image-20230530142921049](./assets/image-20230530142921049.png)

### 单击创建新的虚拟机

![image-20230530143514334](./assets/image-20230530143514334.png)

<img src="./assets/image-20230530143548020.png" alt="image-20230530143548020" style="zoom:67%;" />

<img src="./assets/image-20230530143643272.png" alt="image-20230530143643272" style="zoom:67%;" />

### 虚拟机配置

<img src="./assets/image-20230530143709535.png" alt="image-20230530143709535" style="zoom:67%;" />

<img src="./assets/image-20230530143815190.png" alt="image-20230530143815190" style="zoom: 80%;" />

<img src="./assets/image-20230530143919460.png" alt="image-20230530143919460" style="zoom:80%;" />

<img src="./assets/image-20230530143957656.png" alt="image-20230530143957656" style="zoom:80%;" />

<img src="./assets/image-20230530144010336.png" alt="image-20230530144010336" style="zoom: 67%;" />

<img src="./assets/image-20230530144025147.png" alt="image-20230530144025147" style="zoom:67%;" />

<img src="./assets/image-20230530144042721.png" alt="image-20230530144042721" style="zoom:67%;" />

<img src="./assets/image-20230530144101293.png" alt="image-20230530144101293" style="zoom:67%;" />

<img src="./assets/image-20230530144232611.png" alt="image-20230530144232611" style="zoom:80%;" />

<img src="./assets/image-20230530144245033.png" alt="image-20230530144245033" style="zoom:67%;" />

<img src="./assets/image-20230530144314558.png" alt="image-20230530144314558" style="zoom:80%;" />

<img src="./assets/image-20230530144621079.png" alt="image-20230530144621079" style="zoom: 67%;" />

<img src="./assets/image-20230530144536440.png" alt="image-20230530144536440" style="zoom:67%;" />



### 打开虚拟机

<img src="./assets/image-20230530144722728.png" alt="image-20230530144722728" style="zoom:67%;" />

### 选择安装ubuntu

<img src="./assets/image-20230530144850050.png" alt="image-20230530144850050" style="zoom:67%;" />

<img src="./assets/image-20230530144939122.png" alt="image-20230530144939122" style="zoom:50%;" />

### 配置Ubuntu

选择需要鼠标进入虚拟机界面并单击 (获取聚焦) 并使用**确认键** (Enter)   

退出可使用`Ctrl` + `Alt`按键

![image-20230530145052195](./assets/image-20230530145052195.png)

![image-20230530145109980](./assets/image-20230530145109980.png)

![image-20230530145351803](./assets/image-20230530145351803.png)

#### 配置静态IP

静态IP是为了让每次进入虚拟机时虚拟机的IP都保持不变, 否则每次重启都将重新设置某些关于IP的配置

使用上下键可以选择

![image-20230530145435264](./assets/image-20230530145435264.png)

![image-20230530145602186](./assets/image-20230530145602186.png)

这里的配置: 

- `Subnet` : 子网 **需要跟虚拟机的虚拟网卡子网一致**

- `Address` : 静态的IP **处于子网之内**

- `Gateway` : 网关 **需要跟虚拟机的虚拟网卡网关一致**

  不理解可以看 **[VMware的三种虚拟网卡](https://blog.csdn.net/lyf_ldh/article/details/78695357)**

![image-20230601101404854](./assets/image-20230601101404854.png)

![image-20230601101730588](./assets/image-20230601101730588.png)

![image-20230530150008067](./assets/image-20230530150008067.png)

### 设置apt镜像网站

**网址:** 

> http://mirrors.aliyun.com/ubuntu

填入后进行下一步

![image-20230601101821022](./assets/image-20230601101821022.png)

![image-20230530150604707](./assets/image-20230530150604707.png)

![image-20230530150625247](./assets/image-20230530150625247.png)

![image-20230530150812305](./assets/image-20230530150812305.png)

![image-20230530150824837](./assets/image-20230530150824837.png)

![image-20230530150853899](./assets/image-20230530150853899.png)

### 安装完成并重启

![image-20230601102210191](./assets/image-20230601102210191.png)

![image-20230530151005510](./assets/image-20230530151005510.png)





## 第二步登录Ubuntu并安装Java环境



### 登录Ubuntu

输入刚刚的用户名并输入密码 (**密码不会在屏幕上显示 输入完回车即可**)

![image-20230530151320346](./assets/image-20230530151320346.png)

### 更新apt软件

```shell
sudo apt update
```



输入用户密码以获取权限

![image-20230530151434191](./assets/image-20230530151434191.png)

...

#### 如果出现DNS错误时 [参见此文章](https://blog.csdn.net/yulei_qq/article/details/104261296)

### 让vim显示行号

编辑 `/etc/vim/vimrc ` 让vim编辑器显示行号

```shell
sudo vi /etc/vim/vimrc
```

![image-20230530152318617](./assets/image-20230530152318617.png)

按`i`并在末行添加 `set number`

![image-20230530152406759](./assets/image-20230530152406759.png)

然后`esc` `:wq`保存退出



### 安装java环境

```shell
sudo apt -y install openjdk-8-jdk
```

![image-20230601103811766](./assets/image-20230601103811766.png)

如果出现一下页面直接回车即可

![image-20230601104906913](./assets/image-20230601104906913.png)

然后记住 `/usr/lib/jvm/java-8-openjdk-amd64` (可能会略有差异, 可以前往/usr/lib/jvm下自行查看) 这个路径

#### 将Java路径添加到用户变量

```shell
sudo vi ~/.bashrc
```

在文末添加三行`export`

![image-20230601104547650](./assets/image-20230601104547650.png)

然后使用

```shell
source ~/.bashrc
```

更新文件

## 第三步安装SSH配置免密登录

#### 安装 `ssh` 和 `pdsh`

```shell
sudo apt-get -y install ssh
```



```shell
sudo apt-get -y install pdsh
```

然后在`~/.bashrc`文件添加 (方法同上添加Java环境)

```shell
export PDSH_RCMD_TYPE=ssh 
```

![image-20230601105303428](./assets/image-20230601105303428.png)

然后

```shell
sudo echo ssh >> /etc/pdsh/rcmd_default
```

紧接着使用

```shell
pdsh -q -w localhost
```

校验: 如果 `Rcmd type` 为 `ssh` 即为成功

![image-20230601105432794](./assets/image-20230601105432794.png)

#### 生成密钥

```shell
ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
```

单机测试免密登录(本机连接本机)

```shell
ssh localhost
```

弹出提示时 输入`yes`

![image-20230601105801017](./assets/image-20230601105801017.png)

成功: 

![image-20230601105845550](./assets/image-20230601105845550.png)

退出使用`exit`

如果提示`port 22 connection refused`

请先安装`openssh-server`

```shell
sudo apt-get install openssh-server
```

然后重新测试

## 第四步克隆虚拟机



输入 `poweroff` 关闭此虚拟机 若权限不够可在前面加上`sudo `

![image-20230601110132691](./assets/image-20230601110132691.png)

![image-20230601110254008](./assets/image-20230601110254008.png)

![image-20230601110319045](./assets/image-20230601110319045.png)

![image-20230601110330926](./assets/image-20230601110330926.png)

![image-20230601110405300](./assets/image-20230601110405300.png)

![image-20230601110447814](./assets/image-20230601110447814.png)

![image-20230601110505093](./assets/image-20230601110505093.png)

**同理再添加一个`Namenode2`**

现有三台虚拟机: 

![image-20230601110623833](./assets/image-20230601110623833.png)

### 然后更改 克隆出来的两台虚拟机的静态IP地址

打开`Namenode1` (另外两个不建议打开)

然后修改静态IP配置 

不同设备的`yaml`文件名可能不一样, 一般都只有一个, 那就是它了

输入到`sudo vi /etc/netplan/`时按`tab`键可自动补全这个唯一的文件: 

```shell
sudo vi /etc/netplan/***.yaml
```

然后将`address`下的`192.168.200/24`改为`192.168.201/24` ( 更改200成201即可 )

![image-20230601112107966](./assets/image-20230601112107966.png)

然后保存退出 使用

```shell
sudo netplan apply
```

更新配置

然后使用 `ip addr` 查看ip

![image-20230601112317286](./assets/image-20230601112317286.png)

已经更改成`192.168.201`

同理打开`Namenode2`更改其IP为202

### 更改hostname

然后使用`vim`编辑 `/etc/hostname`下的唯一一行名字成每个虚拟机对应的名字(小写即可)

如`Datanode`下:

 ```shell
 sudo vi /etc/hostname
 ```

![image-20230601111145728](./assets/image-20230601111145728.png)

然后保存退出 再重启: `reboot`

再次登录: 

![image-20230601111317771](./assets/image-20230601111317771.png)

可以看到系统的名字已经更换

然后另外两个分别命名为 `namenode1` 和 `namenode2` 操作同上

### 更改`hosts`

现在三台虚拟机对应的IP如下: 

![image-20230601113220281](./assets/image-20230601113220281.png)

![image-20230601113136175](./assets/image-20230601113136175.png)

![image-20230601113152639](./assets/image-20230601113152639.png)

整理一下: 

|  系统名   |     IP地址      |
| :-------: | :-------------: |
| Datanode  | 192.168.188.200 |
| Namenode1 | 192.168.188.201 |
| Namenode2 | 192.168.188.202 |

我们需要使用

```shell
sudo vi /etc/hosts
```

将以下内容添加到 `hosts`文件

```
192.168.188.200 datanode
192.168.188.201 namenode1
192.168.188.202 namenode2
```

同时呢将 `127.0.1.1 ubuntu` 这行注释掉 ( 在前面加上`#`即可) 

![image-20230601113918365](./assets/image-20230601113918365.png)

### 测试免密登录

在两台虚拟机内执行以下两个命令(主目录下)

```shell
scp hadoop@datanode:~/.ssh/id_rsa.pub  /home/hadoop/.ssh/datanode_rsa.pub
cat ~/.ssh/datanode_rsa.pub  >>  ~/.ssh/authorized_keys
```

![image-20230601114743269](./assets/image-20230601114743269.png)

然后在`Datanode`中测试:

```shell
ssh namenode1
ssh namenode2
```

![image-20230601115030273](./assets/image-20230601115030273.png)

连接成功

退出使用`exit`

## 第五步安装Hadoop

**如未提及以下操作均在 `Datanode`虚拟机 中执行

### 下载Hadoop

```shell
curl https://mirrors.aliyun.com/apache/hadoop/common/hadoop-3.3.5/hadoop-3.3.5.tar.gz --output hadoop.tar.gz
```

### 解压Hadoop

```shell
tar -zxvf hadoop.tar.gz # 解压到当前目录(主目录)
```

### 进入Hadoop安装目录

```shell
cd hadoop-3.3.5.tar.gz
```

![image-20230603222933124](./assets/image-20230603222933124.png)

### 添加Hadoop安装目录到用户环境变量

```shell
sudo vi ~/.bashrc
```

![image-20230603223220416](./assets/image-20230603223220416.png)

#### 更新环境变量并测试

```shell
source ~/.bashrc
hadoop # 输出hadoop的相关信息即可证明环境变量设置成功
```

![image-20230603223506540](./assets/image-20230603223506540.png)

### 修改配置文件

接下来需要修改的配置文件如下(都位于`/home/hadoop/hadoop-3.3.5/etc/hadoop`下): 

#### **hadoop-env.sh**

添加Java的环境变量 这个java变量同前面添加的一样

![image-20230603224245261](./assets/image-20230603224245261.png)

#### **core-site.xml**

添加如下配置

```
<configuration>
	<property>
		<name>fs.defaultFS</name>
		<value>hdfs://datanode:9000</value>
		<description>hdfs namenode port</description>
	</property>
	<property>
		<name>hadoop.tmp.dir</name>
		<value>/home/hadoop/hadoop-3.3.5/tmp</value>
		<description>A base for other temporary directories</description>
	</property>
</configuration>
```

![image-20230603231553118](./assets/image-20230603231553118.png)

#### **hdfs-site.xml**

```
<configuration>
	<property>
		<name>dfs.namenode.name.dir</name>
		<value>/home/hadoop/hadoop-3.3.5/dfs/name</value>
		<final>true</final>
	</property>
	<property>
		<name>dfs.datanode.data.dir</name>
		<value>/home/hadoop/hadoop-3.3.5/dfs/data</value>
		<final>true</final>
	</property>
	<property>
		<name>dfs.replication</name>
		<value>2</value>
		<final>true</final>
	</property>
	<property>
		<name>dfs.webhdfs.enable</name>
		<value>true</value>
	</property>
	<property>
		<name>dfs.secondary.http.address</name>
		<value>datanode:50090</value>
	</property>
</configuration>
```

![image-20230603231610258](./assets/image-20230603231610258.png)

#### **mapred-site.xml**

```
<configuration>
	<property>
		<name>mapreduce.framework.name</name>
		<value>yarn</value>
	</property>
</configuration>
```

![image-20230603225354306](./assets/image-20230603225354306.png)

#### **yarn-site.xml**

```
<configuration>
	<property>
		<name>yarn.resourcemanager.hostname</name>
		<value>datanode</value>
	</property>
	<property>
		<name>yarn.nodmanager.aux-services</name>
		<value>mapreduce_shuffle</value>
	</property>
</configuration>
```

![image-20230603231626148](./assets/image-20230603231626148.png)

#### **workers**

![image-20230603224644820](./assets/image-20230603224644820.png)

### 向其他虚拟机传输Hadoop文件

```shell
scp -r /home/hadoop/hadoop-3.3.5 hadoop@namenode1:~/
scp -r /home/hadoop/hadoop-3.3.5 hadoop@namenode2:~/
```

![image-20230603225839707](./assets/image-20230603225839707.png)

### 初始化`namenode`

(在Datanode的hadoop-3.3.5目录下)

```shell
bin/hdfs namenode -format # 在hadoop-3.3.5文件之下
```

![image-20230603230534919](./assets/image-20230603230534919.png)

### 启动Hadoop

(在Datanode的hadoop-3.3.5目录下)

```shell
sbin/start-dfs.sh
```

如若前面执行过启动Hadoop的命令需要先停止它

使用

```shell
sbin/stop-all.sh # 停止Hadoop命令 (需要等待十秒确认)
```

![image-20230603232159859](./assets/image-20230603232159859.png)

### 测试

![image-20230603232231300](./assets/image-20230603232231300.png)

![image-20230603232116254](./assets/image-20230603232116254.png)

![image-20230603232136015](./assets/image-20230603232136015.png)