--1)查询全体学生的学号、姓名、籍贯
select sno, sname, nativee
from student;

--2)查询所有课程的名称及学分
select cname, credit
from course;

--3)查询教师的姓名、性别、联系电话
select tname, sex, tel
from teacher;

--4)查询每门课程的课程编号、课程名称及理论学时
select cno, cname, lecture
from course;

--5)查询全体学生的姓名、联系电话，并在前面加上字符串‘联系方式’
select sname, '联系方式'+tel
from student;

--6)查询全体教师的人数
select COUNT(tno) num
from teacher;

--7)查询全体教师的姓名、家庭住址、邮政编码（使用列别名）
select tname '姓名', home '家庭住址', zipcode '邮政编码'
from teacher;

--8)查询全体学生的姓名
select sname
from student;

--9)查询本学期有课的教师编号
select distinct tno
from teacher_course;

--10)查询所有选课的学生学号
select distinct sno
from student_course;

--11)查询籍贯为河北保定的学生的学号和姓名
select sno, sname
from student
where home = '河北省保定市';

--12)查询课程学分小于 3 分的课程名称
select cname
from course
where credit < 3;

--13)查询在 c201 教室上课的教师编号
select distinct tno
from teacher_course
where classroom = 'c201';

--14)查询软件学院的办公电话
select dtel
from department
where dname = '软件学院';

--15)查询学生成绩在 60-90 分的学生的学号和课程号
select sno, cno
from student_course
where score >= 60 and score <= 90;

--16)查询学分为 3 分的课程信息
select *
from course
where credit = 3;

--17)查询在教学楼 C 座上课的教师的编号
select distinct tno
from teacher_course
where classroom like 'c%';

--18)查询有先行课的课程编号及课程名
select cno, cname
from course
where cpno is not null;

--19)查询籍贯为山东省的学生基本信息
select *
from student
where home like '山东省%';

--20)查询姓名为 3 个字，前两个字为‘上官’的学生学号和姓名
select sno, sname
from student
where sname like '上官_';

--21)查询专业号为 3 的女学生的姓名、生日和家庭住址
select sname, birthday, home
from student
where pno = 3 and sex = '女';

--22)查询学号为‘20101001’的学生选修的课程号及成绩，结果按成绩升序排列
select cno, score
from student_course
where sno = '20101001'
order by score asc;

--23)查询所有课程的基本信息，结果按授课学时降序排列，学时相同按学分升序排列
select *
from course
order by lecture desc, credit;

--24)查询所有男教师的姓名和出生日期，结果年龄从小到大排序
select tname, birthday
from teacher
where sex = '男'
order by birthday desc;

--25)查询选修 2 号课程学生成绩的最大值和最小值
select MAX(score) '最大值', MIN(score) '最小值'
from student_course
where cno = 2;

--26)查询所有教师的人数
select COUNT(tno) num
from teacher;

--27)查询所有专业号为 1 的学生人数
select COUNT(sno)
from student
where pno = 1;

--28)查询选课人数超过 5 人的课程编号
select cno
from student_course
group by cno
having COUNT(sno) > 5;

--29)查询所有学生的基本信息以及所在学院的名称和学院联系电话
select student.*, dname, dtel
from student, department
where student.dno = department.dno;

--30)查询教师李亮的上课时间、上课地点和每周学时数
select classtime, classroom, weektime
from teacher, teacher_course
where teacher.tname = '李亮' and teacher.tno = teacher_course.tno;

--31)查询选修了数据库系统概论或数据结构的学生的学号和姓名
select distinct student.sno, sname
from student, student_course
where student.sno = student_course.sno and student_course.cno in (
	select cno
	from course
	where cname = '数据库系统概论' or cname = '数据结构'
)

--32-67 要求至少使用两种方式查询（对复杂查询，可以建立视图）
--32)查询至多有两名男生的班级
select distinct classno
from student s1
where 2 >= (
	select COUNT(sno)
	from student s2
	where sex = '男' and s1.classno = s2.classno
);

select distinct classno
from student
group by classno, sex
having COUNT(sno) <= 2 and sex = '男';

--33）查询至少有一名教授的学院的信息
select *
from department
where 1 <= (
	select COUNT(tno)
	from teacher
	where department.dno = teacher.dno and teacher.pno = '教授'
);

select *
from department
where exists(
	select *
	from teacher
	where department.dno = teacher.dno and teacher.pno = '教授'
);

--34).查询出每个老师及其教课情况？？？？？？？？？
select distinct teacher.tname, teacher_course.*
from teacher, teacher_course
where teacher.tno = teacher_course.tno;

--35).查询每门课程及其被选修的人数
select cno, COUNT(sno) cnt
from student_course
group by cno;

--36).查询籍贯是河北省的教师所教的课程信息
select distinct course.*
from teacher, teacher_course, course
where teacher.home like '河北省%' and teacher.tno = teacher_course.tno and teacher_course.cno = course.cno;

select *
from course
where exists (
	select *
	from teacher_course
	where course.cno = teacher_course.cno and exists (
		select *
		from teacher
		where teacher_course.tno = teacher.tno and teacher.home like '河北省%'
	)
);

--37).查询软件学院学生情况
select student.*
from student, department
where student.dno = department.dno and department.dname = '软件学院';

select *
from student
where exists (
	select *
	from department
	where student.dno = department.dno and department.dname = '软件学院'
);
--38).查询班级人数最多的班的学生情况
select *
from student
where classno in (
	select classno
	from student
	group by classno
	having COUNT(sno) >= all(
		select COUNT(sno)
		from student
		group by classno
	)
)

select *
from student
where classno in (
	select classno
	from student
	group by classno
	having COUNT(*) >= all(
		select COUNT(*)
		from student
		group by classno
	)
)
--39).查询张姓学生选修的课程号、课程名
select distinct course.cname, course.cno
from course, student, student_course
where student.sname like '张%' and student.sno = student_course.sno and student_course.cno = course.cno;

select cno, cname
from course
where exists (
	select *
	from student_course
	where student_course.cno = course.cno and exists (
		select *
		from student
		where student_course.sno = student.sno and student.sname like '张%'
	)
);
--40).查询男学生选修课程的平均分
select AVG(student_course.score)
from student, student_course
where student.sno = student_course.sno and sex = '男';

select AVG(score)
from student_course
where sno in (
	select sno
	from student
	where student.sno = student_course.sno and sex = '男'
);
--41).查询哪些学生选修了授课学时为 54 的课程
select distinct sno, sname
from student
where exists (
	select *
	from student_course
	where student.sno = student_course.sno and exists (
		select *
		from course
		where student_course.cno = course.cno and course.lecture = 54
	)
);

select distinct student.sno, sname
from student, student_course, course
where student.sno = student_course.sno and student_course.cno = course.cno and course.lecture = 54;

--42).查询比软件学院学生年龄都小的其他系学生的信息。
select s1.*
from student s1, department d1
where d1.dname = '软件学院' and d1.dno != s1.dno and s1.birthday >= all(
	select birthday
	from department d2, student s2
	where d2.dname = '软件学院' and s2.dno = d2.dno
);

select s1.*
from student s1
where exists (
	select *
	from department d1
	where d1.dname = '软件学院' and d1.dno = s1.dno and s1.birthday >= all(
		select birthday
		from department d2, student s2
		where d2.dname = '软件学院' and s2.dno = d2.dno		
	)
);
--43).查询比数信学院学院学生年龄大的教育学院学生信息。
select s1.*
from student s1,department d1
where d1.dname = '教育学院' and s1.dno = d1.dno and year(s1.birthday) <= all(
	select year(birthday)
	from student s2, department d2
	where d2.dname = '数信学院' and s2.dno = d2.dno
);

select *
from student
where YEAR(birthday) <= all (
	select YEAR(birthday)
	from student
	where dno = (
		select dno
		from department
		where dname = '数信学院'
	)) and dno = (
		select dno
		from department
		where dname = '教育学院'
	);


select s1.*
from student s1,department d1
where d1.dname = '教育学院' and s1.dno = d1.dno and year(s1.birthday) <= (
	select min(year(birthday))
	from student s2, department d2
	where d2.dname = '数信学院' and s2.dno = d2.dno
);

--44).查询班级号为 1 的班的学生 c 语言程序设计成绩的平均成绩
select AVG(score)
from student, student_course, course
where student.sno = student_course.sno and student.classno = '1' and student_course.cno = course.cno and course.cname = 'c 语言程序设计';

--45).查询计算机导论平均成绩最高的班级。
select classno, AVG(score)
from student, student_course, course
where student.sno = student_course.sno and
	student_course.cno = course.cno and
	course.cname = '计算机导论'
group by classno
having AVG(score) >= all(
	select AVG(score)
	from student, student_course, course
	where student.sno = student_course.sno and
		student_course.cno = course.cno and
		course.cname = '计算机导论'
	group by classno
	having AVG(score) is not null
);
--46).查询选修人数最多的课程是哪个老师教的，显示教师号，教师姓名
select teacher.tno, tname
from teacher, teacher_course
where teacher.tno = teacher_course.tno and
	cno in (
		select cno
		from student_course
		group by cno
		having COUNT(sno) >= all(
			select COUNT(sno)
			from student_course
			group by cno
		)
	);
--47).查询余孝天老师所教各门课程的平均成绩
select cno, AVG(score)
from student_course
where sno in (
	select sno
	from student, teacher_course, teacher
	where student.classno = teacher_course.classno and teacher.tno = teacher_course.tno and
	teacher.tname = '余孝天'
) and cno in (
	select cno
	from teacher, teacher_course
	where teacher.tno = teacher_course.tno and teacher.tname = '余孝天'
)
group by cno;

--48).查询鲁婵娟老师所教课程的各个班级平均成绩
select classno, AVG(score)
from student, student_course
where student.sno = student_course.sno and cno in (
	select cno
	from teacher, teacher_course
	where teacher.tname = '鲁婵娟' and teacher.tno = teacher_course.tno
) and classno in (
	select classno
	from teacher_course, teacher
	where teacher.tname = '鲁婵娟' and teacher.tno = teacher_course.tno
)
group by classno;


--49).查询鲁婵娟老师所教课程的学生的成绩
select sname, score
from student, student_course
where student.sno = student_course.sno and student.classno in (
	select classno
	from teacher, teacher_course
	where teacher.tno = teacher_course.tno and teacher.tname = '鲁婵娟'
) and student_course.cno in (
	select cno
	from teacher, teacher_course
	where teacher.tname = '鲁婵娟' and teacher.tno = teacher_course.tno
)

--50).查询有多少人选修了《数据结构》课程的先修课。
select COUNT(distinct sno)
from student_course
where cno in (
	select cpno
	from course
	where cname = '数据结构'
);
--51).查询软件学院教师所教课程信息
select *
from course
where cno in (
	select cno
	from teacher, teacher_course, department
	where teacher.tno = teacher_course.tno and teacher.dno = department.dno and dname = '软件学院'
);

--52).查询软件学院教师所教课程的成绩，将结果按课程号降序排列。
select distinct student_course.cno, score
from course, student_course
where course.cno = student_course.cno and course.cno in (
	select cno
	from teacher, teacher_course, department
	where teacher.tno = teacher_course.tno and teacher.dno = department.dno and dname = '软件学院'
) and sno in (
	select sno
	from student
	where classno in (
		select classno
		from teacher_course, department, teacher
		where teacher.dno = department.dno and dname = '软件学院' and teacher.tno = teacher_course.tno
	)
)
order by student_course.cno desc;


--53).查询未授课教师的姓名和系
select tname, dno
from teacher
where not exists (
	select *
	from teacher_course
	where teacher.tno = teacher_course.tno
)

select tname,dname
from teacher A,department B where A.dno = B.dno and
tno not in (
select distinct tno from teacher_course)


--54).按职称显示软件学院的教师人数。
select pno, COUNT(tno)
from teacher, department
where teacher.dno = department.dno and dname = '软件学院'
group by pno;

select pno,count(tno)
from teacher A,department B where A.dno = B.dno and
dname = '软件学院' group by pno

--55).查询成绩高于《数据结构》平均成绩的学生信息。
select student.*
from student, student_course s1, course c1
where student.sno = s1.sno and s1.cno = c1.cno and c1.cname = '数据结构'
	and s1.score > (
		select AVG(score)
		from student_course s2, course c2
		where s2.cno = c2.cno and c2.cname = '数据结构'
		group by c2.cno
	)
	

--56).查询学生选修课程的情况，显示学号、姓名、教师姓名、课程名称、成绩。
select s1.sno, sname, tname, cname, score
from student s1, student_course sc1, course c1, teacher t1
where s1.sno = sc1.sno and sc1.cno = c1.cno and t1.tno in (
	select tno
	from teacher_course t2
	where s1.classno = t2.classno and c1.cno = t2.cno
);

select student.sno, sname, tname, cname, score
from student, student_course, teacher, teacher_course, course
where student.sno = student_course.sno and student_course.cno = teacher_course.cno
and teacher.tno = teacher_course.tno and course.cno = teacher_course.cno;

--不懂
select s.sno,sname,s.cno,cname,score,c.tname
from (	select A.sno,A.classno,sname,cname,score,B.cno from student A,student_course B,course C
where A.sno = B.sno and
B.cno = C.cno )s left outer join ( select D.tno,tname,E.cno,classno
from teacher D,teacher_course E where D.tno = E.tno	) c
on s.cno = c.cno and s.classno = C.classno

select student.sno, sname, course.cno, cname
from student, student_course, course
where student.sno = student_course.sno and student_course.cno = course.cno;


--57).查询法政学院教师第一学期所带班级
select distinct classno
from teacher, department, teacher_course
where teacher.dno = department.dno and dname = '法政学院' and teacher.tno = teacher_course.tno and teacher_course.semester = 1;


--58).查询第 2 学期哪些教师在公教楼上课。
select distinct tname
from teacher, teacher_course
where teacher.tno = teacher_course.tno and teacher_course.semester = 2 and teacher_course.classroom like '公教楼%';

select tname
from teacher A,teacher_course B where A.tno = B.tno and
semester = '2' and classroom like '公教楼%'

--59).查询数信学院的学生各科平均成绩，显示课程名、平均成绩。
select cname, AVG(score)
from student_course,course
where student_course.cno = course.cno and sno in (
	select sno
	from student, department
	where student.dno = department.dno and dname = '数信学院'
)
group by student_course.cno;

select cname, AVG(score)
from student_course,course
where student_course.cno = course.cno and sno in (
	select sno
	from student, department
	where student.dno = department.dno and dname = '数信学院'
)
group by cname;

select cname,avg(score)
from student A,student_course B,course C ,department D where A.sno = B.sno and
B.cno =C.cno and A.dno = D.dno and dname = '数信学院'
group by B.cno,cname

--60).查询选修了全部课程的学生的信息。
select *
from student
where not exists(
	select *
	from course
	where not exists (
		select *
		from student_course
		where student_course.cno = course.cno and student.sno = student_course.sno
	)
)

--61).查询至少选修了鲁婵娟所教的课程的学生信息
--翻译：对于某一个学生，没有哪一门鲁婵娟所教的课程我没有选
select *
from student
where not exists(
	select *
	from student_course sc1, teacher_course tc1, teacher t
	where sc1.cno = tc1.cno and tc1.tno = t.tno and tname = '鲁婵娟' and not exists(
		select *
		from student_course sc2
		where student.sno = sc2.sno and sc2.cno = sc1.cno
	)
)

--62).查询和张小兵同一个班级的其他学生的信息
select *
from student s1
where s1.classno in (
	select classno
	from student s2
	where s2.sname = '张小兵'
) and s1.sno not in (
	select sno
	from student s3
	where s3.sname = '张小兵'
)

--63).查询和刘英伟同年出生的学生信息（参考 sql 日期操作函数）
select *
from student s1
where YEAR(s1.birthday) = (
	select YEAR(s2.birthday)
	from student s2
	where s2.sname = '刘英伟'
) and s1.sname <> '刘英伟';

--64).查询选修了 3 门以上课程学生信息
select s1.*
from student s1
where s1.sno in (
	select s2.sno
	from student s2, student_course sc1
	where s2.sno = sc1.sno
	group by s2.sno
	having COUNT(*) >= 3
)

select * from student
where sno in (
select sno
from student_course group by sno
having count(cno)>=3
)

select s1.*
from student s1,(
		select sno
		from student_course
		group by sno
		having COUNT(cno) >= 3) t2
where s1.sno = t2.sno;

--在使用group by的时候，select 后只能写group by子句中的属性列，
--如果该属性列不在group by子句中，则必须将其包含在聚集函数之中
--某一次查询的结果使用括号括起来，起个别名便是一个新的表


--65).查询至少有 2 名女生的班级的学生信息
select *
from student s1
where s1.classno in (
	select classno
	from student s2
	group by s2.classno, s2.sex
	having COUNT(sno) >= 2 and s2.sex = '女'
) 


--66).查询软件学院年龄小于 25 岁的老师的信息
select teacher.*
from teacher, department
where teacher.dno = department.dno and dname = '软件学院' and YEAR(GETDATE() - year(teacher.birthday)) < 25;


--67).查询低于该门课程平均分的学生的成绩信息。
select *
from student_course sc1, (
	select distinct cno,AVG(score) pscore
	from student_course 
	group by cno 
) avgScore
where sc1.cno = avgScore.cno and sc1.score < avgScore.pscore;

select *
from student_course sc1
where exists (
	select *
	from student_course sc2
	group by sc2.cno
	having sc1.score < AVG(sc2.score) and sc1.cno = sc2.cno
)
--集合查询
--68).年龄小于 23 岁的女老师和女学生的信息
select *
from student
where YEAR(birthday) < 23 and sex = '女'
union
select *
from teacher
where YEAR(birthday) < 23 and sex = '女'
--69).查询不教课的老师信息。
--70).查询班级号为 3,且性别为女的学生的信息


--test
select student.*, student_course.*
from student left outer join student_course
on student.sno = student_course.sno;
