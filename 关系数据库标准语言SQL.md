# 3.关系数据库标准语言SQL

## 3.1 SQL概述

### 3.1.1基本概念

1. SQL语言是一个功能极强的关系数据库语言。同时也是一种介于关系代数与关系演算之间的结构化查询语言（Structured Query Language），其功能包括**数据定义、数据查询、数据操纵和数据控制**。

2. SQL的特点：

   1）综合统一：集数据定义、数据查询、数据操纵和数据控制等多种功能于一体。

   2）高度非过程化 ：面对象的设计

   3）面向集合的操作方式 ：操作对象是集合，并且操作结果也是集合

   4）两种使用方式，统一的语法结构 ：既是一种独立的语言，又是一种嵌入式的语言，（嵌入式是指嵌入别的高级语言）。

   5）简洁易学

## 3.2 学生-课程数据库

## 3.3 数据定义

### 3.3.1 数据库的创建与基本概念

**一、创建数据库：**

---

代码：

~~~sql
create database Student;        --创建数据库
use Student;                    --使用数据库
drop database Student;          --删除数据库
~~~

注意：

1）两种注释方式：（1）两个减号--，注释单行 （2）/* */注释多行

2）不能再当前数据库删除当前数据库

**二、数据类型：**

![201902279](./img/201902279.png)

注意：

1）一个属性采用何种数据类型由两部分决定：（1）该属性的取值范围；（2）该属性做何种运算。

### 3.3.2模式的创建与删除

**一、创建模式：**

---

模式，一个独立于数据库用户的**非重复命名空间**，在这个空间中可以**定义该模式包含的数据库对象**，例如基本表、视图、索引等。

代码：

~~~sql
/** 创建模式zhang，下键表student*/
create schema zhang
	create table student
	(
		Sno char(9) primary key,
		Sname varchar(20) unique,
		Ssex char(4) not  null,
		Sage smallint,
		Sdept varchar(5)		
	);

/** 删除模式中的表*/
drop table zhang.student;

/** 删除模式*/
drop schema zhang;    --注意前提该模式下无对象
~~~

**注意：**

1）删除模式的时候首先应当将模式下的所有对象删除，才能删除该模式

2）在删除某个非dbo模式下的表时，需要加模式名

3）该模式不是三级模式两级映像中的模式，而是相当于一个**命名空间**（主要可以解决重名的问题）

4）CASCADE(级联)：删除模式的同时把该模式中所有的数据库对象全部删除（SQL Server不支持）

5）RESTRICT(限制)：只有当该模式中没有任何下属的对象时才能执行

### 3.3.3表的定义、删除与修改

**一、创建表（三张）**：（1）学生表（Student）（2）课程表（Course）（3）学生课程表（SC）

***

1）学生表（Student）

![201903131](./img/201903131.png)
代码：

~~~sql
/** 未添加数据*/
create table student
(
	Sno char(9) primary key,          --primary key   指示主码
	Sname varchar(20) unique,         --unique        指示值唯一，
	Ssex char(4) not  null,           --not null      该值非空
	Sage smallint,
	Sdept varchar(5)	
);
~~~

2）课程表（Course）

![201903132](/img/201903132.png)

代码：

~~~sql
/** 创建课程表*/
create table Course
(
	Cno char(2) primary key,
	Cname varchar(10) unique,
	Cpno char(2),                --Cpno是外码，参照的是自身的Cno
	Ccredit smallint,
	foreign key (Cpno) references Course(Cno)     --外码
);
~~~

3）学生-课程表

![201903133](/img/201903133.png)

代码：

~~~sql
/** 创建学生-课程表*/
create table SC
(
	Sno char(9),
	Cno char(2),
	Grade int,
	primary key(Sno, Cno),            --多个属性列构成主码，写在最后
	foreign key(Sno) references student(Sno),    --外码， 每个外码写一行
	foreign key(Cno) references Course(Cno)
);
~~~

**注意：**

1）创建表的时候需要考虑三个完整性约束条件：实体完整性，参照完整性，用户自定义完整性

2）两种完整性约束条件的定义方式：

* **列级完整性约束条件**：涉及相应属性列的完整性约束条件，在属性列的后边定义。

* **表级完整性约束条件**：涉及一个或多个属性列的完整性约束条件 ，在将属性列完之后定义。

3）外码要和所参照的主码类型相同。

**二、修改表**

***

**增加列**

~~~sql
alter table student add graduation date;
/*
1. 指定要修改的表
2. add关键字
3. 新增列的属性名
4. 新增列的数据类型
*/
~~~

**删除列**

~~~sql
alter table student drop column graduation;
~~~

**修改列的数据类型**

~~~sql
alter table student alter column graduation varchar(20); 
~~~

**增加约束**

~~~sql
/*这种增加约束的方法不容易从左边的框框（键）中看出来*/
alter table student add unique(graduation);

/*给增加的约束自定义了一个别名，容易区分*/
alter table student add constraint S_un unique(graduation);

/*注意*/
--1. 不可以使用增加not null约束，想要添加只可以在设计中将勾去掉
--虽然以下的方式看似添加了not null约束，但是不起任何作用
alter table student add constraint cc check(sname is not null);

--2. 给某一属性列添加主键，需要保证该属性列不允许为空，刚建的新表在未加约束的情况下，默认属性列允许为空值
alter  table  student  add primary key(sno,cno);

--3. 添加外键，需要保证外码和被参照表的主属性的数据类型保持一致
alter  table  student  add foreign key (sno) references student(sno);
~~~

**删除约束**

~~~sql
/*通过指定的约束名字删除指定的约束*/
alter table student drop constraint S_un;

/*在左边单机右键删除*/
~~~

**三、删除表**

---

~~~sql
/*删除表的时候必须先将参照表干掉，再删除被参照表*/
drop table student；
~~~

### 3.3.4索引的建立与删除

> 建立索引的目的是加快数据查询的速度。DBA或者表的属主可以根据需要建立表的索引；但是有些DBMS可以自动建立以下索引，1）PRIMARY  KEY索引（聚簇索引）2）UNIQUE索引（唯一性索引）

**一、创建索引**

~~~sql
/*创建唯一性索引*/
/*
 * stu为索引名字，创建索引必须要有一个索引名
 * 列名后面紧跟排序类型，ASC为升序，DESC为降序，默认为ASC，可以有多个列，用逗号隔开。
 * 对于已经包含重复值的属性列不可以增加唯一性索引
*/
create unique index S_nn on student(graduation asc);

/*创建聚簇索引（聚集）*/
Create  clustered index stu on student(sage desc);
/*
 * 聚簇索引的关键字为clustered,不是书上有误，而是sqlserver是这样
 * 同样，列名后面紧跟排序类型，可以有多个列，用逗号隔开。
 * 聚簇索引严格按照物理存储位置来排序。
 * 不可以在有主键的表中创建索引
 * 一个表只能创建一个聚簇索引
*/
~~~

**二、删除索引**

~~~sql
/*注意：删除索引必须为表名+索引名*/
drop  index  student.stu
~~~

## 3.4 数据查询

### 3.4.1单表查询

#### 简单的查询操作：

---

~~~sql
--投影，select后边指明所选的列，from指明所访问的表
select sno, sname, sdept
from student;

--选择指定的列，可以加算术表达式，并且为其添加新的属性名
select sno, 2019-sage as birthday
from student;

--投影后，修改属性名
select sno num, 2019-sage birthday
from student;

--*代表选中所有列
select *
from student;

--除了int，smallint，其余的数据类型需要单引号''
select sname,'2017' year
from student;

--select后加函数
--count函数空值不计，重复值重复计
--当count函数作用在全部列上时以元组计数
select COUNT(sno)
from student;

--COUNT的含义是计数，*表示所有列，COUNT（*）表示元组数，某个或部分属性列为空值不影响count统计结果
select COUNT(*)		
from student;

--去重，distinct作用域是整个元组，是所有指定列组成的元组的去重
select distinct sno, cno
from sc;

--查询性别为女的学生的学号，姓名
select sno, sname
from student
where ssex = '女';

--查询学分为4学分的课程的名字
select cname
from course
where ccredit = 4;

--查询成绩在85分以上的学生的学号（学号不重）
select distinct sno
from sc
where grade > 85;

--查询年龄在20~23岁（包括20岁和23岁）之间的学生的姓名、系别和年龄。
SELECT Sname,Sdept,Sage	
FROM Student
WHERE Sage BETWEEN 20 AND 23;

--不能写成sdept='CS','IS','MA'
select sname,ssex
from student
where sdept='CS' or sdept='IS' or sdept = 'MA';

--IS NULL， IS NOT NULL空值：只能用“is”，不能用“=”
--WHERE NOT Sage >= 20；not必须在 sage前边，而不是>=前边

select sname,ssex
from student
where sdept in ('CS','IS','MA');

--模糊查询
--%任意长度，_单个字符，__表示两个或两个以内
--转义字符\，需要加escape '\'标注
select *
from student
where sname like '刘__';

SELECT *	--如果字符中本身带有下划线，用任意字符当转义字符
FROM Course
WHERE Cname LIKE 'DB\_%i_ _' ESCAPE '\';
~~~

#### order by子句：

---

~~~sql
--order by子句
--选择sno列，从sc表中，cno为'3'，按成绩降序给出
--desc表示降序排列，asc表示升序排列，当缺省的时候表示asc
--在SqlServer中当排序的属性列中存在空值的时候，升序排列默认空值在元组最先显示，desc（降序）空值元组在最后显示
select sno
from sc
where cno = '3'
order by grade desc;

--多属性列排序，首先按ccredit进行升序排列，当ccredit相等的时候，按cpno进行降序排列
select *
from course
order by ccredit, cpno desc;
~~~

#### 聚集函数：

---

~~~sql
--count统计sc表中sno的数目，空值不计，重复值重复计
--distinct关键字，在计算式取消重复列中的重复值
select count (distinct sno)
from sc;

--统计元组的数目
select count(*)
from sc;

--求该列值的总和
select sum (grade)
from sc;

--求平均值，结果向下取整
select AVG (grade)
from sc;

--求最小
select min (grade)
from sc;

--求最大
select max (grade)
from sc;
~~~

**注意：**

1. 聚集函数全部都忽略空值
2. where子句中不能使用聚集函数作为条件表达式，聚集函数只能用在select子句或者group by中的having子句。

#### group by子句：

---

~~~sql
--GROUP BY
--在有GROUP BY的语句中，可以出现聚集函数和分组列名并存，其他列名不可以，
--平均值计算略过空值
--首先按cno进行分组，分别统计每组中sno的数量和每组中的平均值，最后给每一新列起别名
select cno, count(sno) cnt,AVG (grade) av
from sc
group by cno;

--可以使用HAVING短语筛选最终输出结果,作用于组，从中选择满足条件的组
--同上首先通过cno分组，在通过having语句选出满足指定条件的组
select cno, count(sno) cnt, AVG (grade) av
from sc
group by cno
having COUNT(sno)>=2;

--查询选修了3门以上课程的学生学号
--首先使用group by进行分组，然后使用having选择满足条件的组
select sno,COUNT(cno)
from sc
group by sno
having COUNT(cno)>=3
~~~

注意：

1. where子句作用于基表或视图，从中选择满足条件的元组。

2. having短语作用于组，从中选择满足条件的组

### 3.4.2连接查询

#### 基本概念

---

1. 连接谓词中的列名称为连接字段
2. 连接条件中的各连接字段类型必须是可比的，但不必是相同的
3. SQL没有自动去掉重复列的功能

#### 基本操作

---

~~~sql
--from除涉及两个表，不加连接条件，得到的是广义的笛卡尔积，select后跟的是最终显示的列
select student.*,sc.* 
from student,sc;

--加上连接条件，得到的是从广义笛卡尔积中选择满足指定条件的元组
--select后跟的是最终所显示的列，对于两个表公共的属性列需要使用表名进行区分，不属于公共列的不需要
--SqlServer没有自动去掉重复列的功能
select student.*,cno,grade  --去掉重复列
from student,sc
where student.sno=sc.sno;  --连接条件：不然是广义笛卡尔积

--或者--
select sc.sno,sname,sage,ssex,sdept,cno,grade   --去掉重复列
from student,sc
where student.sno=sc.sno;
~~~

> 一种可能的执行过程：
>
> 1）首先在表1中找到第一个元组，然后从头开始扫描表2，逐一查找满足连接条件的元组，找到后就将表1中的第一个元组与该元组拼接起来，形成结果表中一个元组 。
>
> 2）表2全部查找完后，再找表1中第二个元组，然后再从头开始扫描表2，逐一查找满足连接条件的元组，找到后就将表1中的第二个元组与该元组拼接起来，形成结果表中一个元组。
>
> 3）重复上述操作，直到表1中的全部元组都处理完毕。 

**自身连接**

---

~~~sql
select first.cno, second.cpno
from course first, course second
where first.cpno = second.cno;
~~~

**注意：**

1. 由于两张表的所有属性列的名字相同，所以需要起别名进行加以区分。
2. 上述代码表示将第一张自己表和第二张自己表做广义笛卡尔积，然后选择第一张自己表的cpno等于第二张自己的cno的元组对应的属性列。

**外连接**

---

~~~sql
--外连接
select sc.sno,sname,sage,ssex,sdept,cno,grade
from student full outer join sc
on student.sno = sc.sno;

--左外连接
select sc.sno,sname,sage,ssex,sdept,cno,grade
from student left outer join sc
on student.sno = sc.sno;

--右外连接
select sc.sno,sname,sage,ssex,sdept,cno,grade
from student right outer join sc
on student.sno = sc.sno;
~~~

注意：

1. 原先的条件where变为on

### 3.4.3嵌套查询

#### 基本概念

---

查询块：一个select-from-where语句

嵌套查询：将一个查询块嵌套在另一个查询块的where子句或having短语的条件中的查询

子查询不能使用order by子句，因为嵌套查询返回的是一个集合或者布尔值，排序没有任何意义，所以规定不能使用order by语句（自己编的）

一些嵌套查询可以使用连接查询代替，但是一些不可以。

不相关子查询：子查询的查询条件不依赖于父查询

相关子查询：子查询的查询条件依赖于父查询

不相关子查询的可能执行过程：由里向外逐层处理。即每个子查询在上一级查询处理之前求解，子查询的结果用于建立其父查询的查找条件。

相关子查询可能的执行过程：1）首先取外层查询中表的第一个元组，根据它与内层查询相关的属性值处理内层查询，若where子句返回值为真，则取此元组放入结果表；2）然后再取外层表的下一个元组；3）重复这一过程，直至外层表全部检查完为止。

#### 带有IN谓词的子查询

---

一个典型的例子：

![20190402](img/20190402.png)

该查询为不相关子查询，即查询过称为，1）在course表中查找出信息系统的课程号；2）根据查找出的课程号，在sc表中查询出该学生的学号；3）根据查询到的学号，在student表中查询出相应学生的姓名。

#### 带有比较运算符的子查询

---

适用条件：当能确切知道内层查询返回单值时，可用比较运算符（>，<，=，>=，<=，!=或< >）

例如：

找出每个学生超过他选修课程平均成绩的课程号。

~~~sql
    SELECT Sno,  Cno
    FROM  SC  x
    WHERE Grade >=
               (SELECT AVG(Grade) 
                FROM  SC y
                WHERE y.Sno = x.Sno);
~~~

查询过程：

![201904022](img/201904022.PNG)

![20190403](img/20190403.PNG)

该例为一个相关子查询。

#### 带有any或者all谓词的子查询

---

**声明：**

any：表示任意一个就行，> any表示大于任意一个就可以

all：表示所有，> all表示需要大于所有的值

**常见的谓词解释：**

![201904024](img/201904024.png)

![201904025](img/201904025.PNG)

#### 带有EXISTS谓词的子查询：

---

**介绍：**

---

存在量词

exists

1）不返回任何数据，只返回true或者false。当内层的查询非空时返回true，当内层的查询为空时返回false。

2）由EXISTS引出的子查询，其目标列表达式通常都用*，因为带EXISTS的子查询只返回真值或假值，给出列名无实际意义

not exists

1）若内层查询结果非空，则外层的WHERE子句返回假值

2）若内层查询结果为空，则外层的WHERE子句返回真值

**例子：**

---

exists的例子：

![201904026](img/201904026.PNG)

not exists的例子：

![201904027](img/201904027.PNG)

**<span style="color:blue">难点1：使用exists/not exists实现全称量词</span>**

---

1）查询选修了全部课程的学生姓名

~~~sql
select sname
from student
where not exists(
	select *
	from course
	where not exists(
    	select s*
    	from sc
    	where student.sno = sno and cno = course.cno));
~~~

**解释：**

（1）对于第一个not exists里边查询的是当前student是否有未选修的课程，如果当前学生有未选修的课程，经过not exists返回false，即该学生的信息不会被记录。

（2）对于第二个not exists里边查询的是当前学生对象，对于当前的课程，如果选了该门课程，not exists里边为真，经过not exists返回false，该门课程不会被记录，反之，如果该学生未选该门课程，该门课程将会被记录。

（3）有一点像双重for循环，依次遍历所有的student中的元组，在每一个student的情况下，在遍历course，最后在一个not exists中的where子句中进行判断。

**<span style="color:blue">难点2：使用exists/not exists实现逻辑蕴涵</span>**

---

2）查询至少选修了学生201215122选修的全部课程的学生号码。

~~~sql
SELECT  DISTINCT Sno
FROM  SC SCX
WHERE NOT EXISTS
	(SELECT *
	 FROM SC SCY
	 WHERE SCY.Sno = '201215122'  AND
	 NOT EXISTS
		(SELECT *
		 FROM SC SCZ
		 WHERE SCZ.Sno=SCX.Sno AND SCZ.Cno=SCY.Cno));
~~~

**解释：**

（1）基本同上

### 3.4.4集合查询

**并操作：**

---

查询计算机科学系的学生及年龄不大于19岁的学生。 

~~~sql
/*使用UNION取并集*/
SELECT *
FROM Student
WHERE Sdept= 'CS'
UNION
SELECT *
FROM Student
WHERE Sage<=19；
~~~

**交操作：**

---

查询计算机科学系的学生与年龄不大于19岁的学生的交集(INTERSECT)。

~~~sql
/*使用INTERSECT实现交操作*/
SELECT *
FROM Student
WHERE Sdept='CS' 
INTERSECT
SELECT *
FROM Student
WHERE Sage<=19；
~~~

**差操作：**

---

查询计算机科学系的学生与年龄不大于19岁的学生的差集。

~~~sql
/*使用EXCEPT实现差操作*/
SELECT *
FROM Student
WHERE Sdept='CS'
EXCEPT
SELECT  *
FROM Student
WHERE Sage <=19; 
~~~

## 3.5 数据更新

## 3.6空值的处理

## 3.7 视图 