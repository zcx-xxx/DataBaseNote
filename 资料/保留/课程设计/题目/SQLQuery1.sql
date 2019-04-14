--创建数据库
--create database wuye;
--使用wuye数据库
--use wuye;
--创建公司表
--create table cp
--(
--cpname char(20) primary key
--);
--创建小区表
--create table xq
--(
--xqno char(10) primary key,  --小区编号
--xqname char(20) not NULL,   --小区名字
--xqjianzhuno varchar(20),    --小区建筑数
--);
--创建单元楼表
--create table dyl
--(
--xqno char(10),  --小区编号
--dylno char(10), --单元楼编号
--dyfno int, --单元房数
--dylg int,  --单元楼的层数
-- primary key(xqno,dylno),
--foreign key (xqno) references xq(xqno)   --参照小区表的xqno
--);
--创建单元房表
--create table dyf
--(
--xqno char(10),  --小区编号
--dylno char(10),       --单元楼编号
--dyfnono char(20),     --单元房编号
--chanquan varchar(20), --产权
--mianji varchar(20),   --面积
--internet char(10),    --是否连上Internet
--shuidian varchar(20), --水电
--primary key(xqno,dylno,dyfnono),
--foreign key (dylno,xqno) references dyl(xqno,dylno)--参照单元楼的dylno
--);
----创建户主表
--create table hz
--(
--hzname char(10),      --户主的姓名
--dyfnono char(20),     --单元房编号
--xqno char(10),  --小区编号
--dylno char(10),       --单元楼编号
--workplace varchar(20),--工作单位
--phoneno char(20),     --联系电话
--hzno int,        --户主人口
--primary key(hzname,xqno,dylno,dyfnono),
--foreign key (xqno,dylno,dyfnono) references dyf(xqno,dylno,dyfnono)--参照单元楼的dyfnono
--);



--insert into cp values ('物业公司')

--insert into xq  values('1','one',100)
--insert into xq values('2','two',100)
--insert into xq values('3','three',100)
--insert into xq values('4','four',100)
--insert into xq values('5','five',100)


--insert into dyl values ('1','1',90,9)
--insert into dyl values ('1','2',90,9)
--insert into dyl values ('1','3',100,6)
--insert into dyl values ('1','4',90,25)
--insert into dyl values ('1','5',90,9)
--insert into dyl values ('2','1',60,19)
--insert into dyl values ('2','2',90,8)
--insert into dyl values ('2','3',90,9)
--insert into dyl values ('3','4',90,9)


--insert into dyf values ('1','1','1','户主','200','是','有')
--insert into dyf values ('1','1','2','户主','300','是','有')
--insert into dyf values ('1','1','3','物业公司','200','是','有')
--insert into dyf values ('1','1','4','户主','200','是','有')
--insert into dyf values ('1','1','5','户主','200','否','有')
--insert into dyf values ('1','2','1','物业公司','200','是','有')
--insert into dyf values ('1','2','2','户主','200','是','有')
--insert into dyf values ('1','2','3','户主','200','是','有')
--insert into dyf values ('2','1','1','户主','200','否','有')
--insert into dyf values ('2','1','1','他人','200','是','有')
--insert into dyf values ('2','1','1','户主','200','是','有')
--insert into dyf values ('2','2','2','户主','200','是','有')





--insert into hz values ('赵旭','1','1','1','河北师范大学','18098763452',5)
--insert into hz values ('闫正伟','2','1','1','河北师范大学','13798763452',5)
--insert into hz values ('李美情','3','1','1','河北师范大学','18012343452',5)
--insert into hz values ('刘曼','4','1','1','河北师范大学','13498763452',5)
--insert into hz values ('程文秀','5','1','1','河北师范大学','18032762013',5)

