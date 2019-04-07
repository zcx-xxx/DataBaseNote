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
--44).查询班级号为 1 的班的学生 c 语言程序设计成绩的平均成绩
--45).查询计算机导论平均成绩最高的班级。
--46).查询选修人数最多的课程是哪个老师教的，显示教师号，教师姓名
--47).查询余孝天老师所教各门课程的平均成绩
--48).查询鲁婵娟老师所教课程的各个班级平均成绩
--49).查询鲁婵娟老师所教课程的学生的成绩
--50).查询有多少人选修了《数据结构》课程的先修课。
--51).查询软件学院教师所教课程信息
--52).查询软件学院教师所教课程的成绩，将结果按课程号降序排列。
--53).查询未授课教师的姓名和系
--54).按职称显示软件学院的教师人数。
--55).查询成绩高于《数据结构》平均成绩的学生信息。
--56).查询学生选修课程的情况，显示学号、姓名、教师姓名、课程名称、成绩。
--57).查询法政学院教师第一学期所带班级
--58).查询第 2 学期哪些教师在公教楼上课。
--59).查询数信学院的学生各科平均成绩，显示课程名、平均成绩。
--60).查询选修了全部课程的学生的信息。
--61).查询至少选修了鲁婵娟所教的课程的学生信息
--62).查询和张小兵同一个班级的其他学生的信息
--63).查询和刘英伟同年出生的学生信息（参考 sql 日期操作函数）
--64).查询选修了 3 门以上课程学生信息
--65).查询至少有 2 名女生的班级的学生信息
--66).查询软件学院年龄小于 25 岁的老师的信息
--67).查询低于该门课程平均分的学生的成绩信息。

--集合查询
--68).年龄小于 23 岁的女老师和女学生的信息
--69).查询不教课的老师信息。
--70).查询班级号为 3,且性别为女的学生的信息