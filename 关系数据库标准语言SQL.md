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

1. **创建数据库：**

   代码：

   ~~~sql
   create database Student;        --创建数据库
   use Student;                    --使用数据库
   drop database Student;          --删除数据库
   ~~~

   **注：**

   1）两种注释方式：（1）两个减号--，注释单行 （2）/* */注释多行

   2）不能再当前数据库删除当前数据库

2. **数据类型：**

![201902279](./img/201902279.png)

### 3.3.2模式的创建与删除

1. **创建模式：**一个独立于数据库用户的**非重复命名空间**，在这个空间中可以**定义该模式包含的数据库对象**，例如基本表、视图、索引等。

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

1. **创建表（三张）**：（1）学生表（Student）（2）课程表（Course）（3）学生课程表（SC）

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

## 3.4 数据查询

## 3.5 数据更新

## 3.6空值的处理

## 3.7 视图