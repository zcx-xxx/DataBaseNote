--�������ݿ�
--create database wuye;
--ʹ��wuye���ݿ�
--use wuye;
--������˾��
--create table cp
--(
--cpname char(20) primary key
--);
--����С����
--create table xq
--(
--xqno char(10) primary key,  --С�����
--xqname char(20) not NULL,   --С������
--xqjianzhuno varchar(20),    --С��������
--);
--������Ԫ¥��
--create table dyl
--(
--xqno char(10),  --С�����
--dylno char(10), --��Ԫ¥���
--dyfno int, --��Ԫ����
--dylg int,  --��Ԫ¥�Ĳ���
-- primary key(xqno,dylno),
--foreign key (xqno) references xq(xqno)   --����С�����xqno
--);
--������Ԫ����
--create table dyf
--(
--xqno char(10),  --С�����
--dylno char(10),       --��Ԫ¥���
--dyfnono char(20),     --��Ԫ�����
--chanquan varchar(20), --��Ȩ
--mianji varchar(20),   --���
--internet char(10),    --�Ƿ�����Internet
--shuidian varchar(20), --ˮ��
--primary key(xqno,dylno,dyfnono),
--foreign key (dylno,xqno) references dyl(xqno,dylno)--���յ�Ԫ¥��dylno
--);
----����������
--create table hz
--(
--hzname char(10),      --����������
--dyfnono char(20),     --��Ԫ�����
--xqno char(10),  --С�����
--dylno char(10),       --��Ԫ¥���
--workplace varchar(20),--������λ
--phoneno char(20),     --��ϵ�绰
--hzno int,        --�����˿�
--primary key(hzname,xqno,dylno,dyfnono),
--foreign key (xqno,dylno,dyfnono) references dyf(xqno,dylno,dyfnono)--���յ�Ԫ¥��dyfnono
--);



--insert into cp values ('��ҵ��˾')

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


--insert into dyf values ('1','1','1','����','200','��','��')
--insert into dyf values ('1','1','2','����','300','��','��')
--insert into dyf values ('1','1','3','��ҵ��˾','200','��','��')
--insert into dyf values ('1','1','4','����','200','��','��')
--insert into dyf values ('1','1','5','����','200','��','��')
--insert into dyf values ('1','2','1','��ҵ��˾','200','��','��')
--insert into dyf values ('1','2','2','����','200','��','��')
--insert into dyf values ('1','2','3','����','200','��','��')
--insert into dyf values ('2','1','1','����','200','��','��')
--insert into dyf values ('2','1','1','����','200','��','��')
--insert into dyf values ('2','1','1','����','200','��','��')
--insert into dyf values ('2','2','2','����','200','��','��')





--insert into hz values ('����','1','1','1','�ӱ�ʦ����ѧ','18098763452',5)
--insert into hz values ('����ΰ','2','1','1','�ӱ�ʦ����ѧ','13798763452',5)
--insert into hz values ('������','3','1','1','�ӱ�ʦ����ѧ','18012343452',5)
--insert into hz values ('����','4','1','1','�ӱ�ʦ����ѧ','13498763452',5)
--insert into hz values ('������','5','1','1','�ӱ�ʦ����ѧ','18032762013',5)

