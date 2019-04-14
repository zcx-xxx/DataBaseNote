--1)��ѯȫ��ѧ����ѧ�š�����������
select sno, sname, nativee
from student;

--2)��ѯ���пγ̵����Ƽ�ѧ��
select cname, credit
from course;

--3)��ѯ��ʦ���������Ա���ϵ�绰
select tname, sex, tel
from teacher;

--4)��ѯÿ�ſγ̵Ŀγ̱�š��γ����Ƽ�����ѧʱ
select cno, cname, lecture
from course;

--5)��ѯȫ��ѧ������������ϵ�绰������ǰ������ַ�������ϵ��ʽ��
select sname, '��ϵ��ʽ'+tel
from student;

--6)��ѯȫ���ʦ������
select COUNT(tno) num
from teacher;

--7)��ѯȫ���ʦ����������ͥסַ���������루ʹ���б�����
select tname '����', home '��ͥסַ', zipcode '��������'
from teacher;

--8)��ѯȫ��ѧ��������
select sname
from student;

--9)��ѯ��ѧ���пεĽ�ʦ���
select distinct tno
from teacher_course;

--10)��ѯ����ѡ�ε�ѧ��ѧ��
select distinct sno
from student_course;

--11)��ѯ����Ϊ�ӱ�������ѧ����ѧ�ź�����
select sno, sname
from student
where home = '�ӱ�ʡ������';

--12)��ѯ�γ�ѧ��С�� 3 �ֵĿγ�����
select cname
from course
where credit < 3;

--13)��ѯ�� c201 �����ϿεĽ�ʦ���
select distinct tno
from teacher_course
where classroom = 'c201';

--14)��ѯ���ѧԺ�İ칫�绰
select dtel
from department
where dname = '���ѧԺ';

--15)��ѯѧ���ɼ��� 60-90 �ֵ�ѧ����ѧ�źͿγ̺�
select sno, cno
from student_course
where score >= 60 and score <= 90;

--16)��ѯѧ��Ϊ 3 �ֵĿγ���Ϣ
select *
from course
where credit = 3;

--17)��ѯ�ڽ�ѧ¥ C ���ϿεĽ�ʦ�ı��
select distinct tno
from teacher_course
where classroom like 'c%';

--18)��ѯ�����пεĿγ̱�ż��γ���
select cno, cname
from course
where cpno is not null;

--19)��ѯ����Ϊɽ��ʡ��ѧ��������Ϣ
select *
from student
where home like 'ɽ��ʡ%';

--20)��ѯ����Ϊ 3 ���֣�ǰ������Ϊ���Ϲ١���ѧ��ѧ�ź�����
select sno, sname
from student
where sname like '�Ϲ�_';

--21)��ѯרҵ��Ϊ 3 ��Ůѧ�������������պͼ�ͥסַ
select sname, birthday, home
from student
where pno = 3 and sex = 'Ů';

--22)��ѯѧ��Ϊ��20101001����ѧ��ѡ�޵Ŀγ̺ż��ɼ���������ɼ���������
select cno, score
from student_course
where sno = '20101001'
order by score asc;

--23)��ѯ���пγ̵Ļ�����Ϣ��������ڿ�ѧʱ�������У�ѧʱ��ͬ��ѧ����������
select *
from course
order by lecture desc, credit;

--24)��ѯ�����н�ʦ�������ͳ������ڣ���������С��������
select tname, birthday
from teacher
where sex = '��'
order by birthday desc;

--25)��ѯѡ�� 2 �ſγ�ѧ���ɼ������ֵ����Сֵ
select MAX(score) '���ֵ', MIN(score) '��Сֵ'
from student_course
where cno = 2;

--26)��ѯ���н�ʦ������
select COUNT(tno) num
from teacher;

--27)��ѯ����רҵ��Ϊ 1 ��ѧ������
select COUNT(sno)
from student
where pno = 1;

--28)��ѯѡ���������� 5 �˵Ŀγ̱��
select cno
from student_course
group by cno
having COUNT(sno) > 5;

--29)��ѯ����ѧ���Ļ�����Ϣ�Լ�����ѧԺ�����ƺ�ѧԺ��ϵ�绰
select student.*, dname, dtel
from student, department
where student.dno = department.dno;

--30)��ѯ��ʦ�������Ͽ�ʱ�䡢�Ͽεص��ÿ��ѧʱ��
select classtime, classroom, weektime
from teacher, teacher_course
where teacher.tname = '����' and teacher.tno = teacher_course.tno;

--31)��ѯѡ�������ݿ�ϵͳ���ۻ����ݽṹ��ѧ����ѧ�ź�����
select distinct student.sno, sname
from student, student_course
where student.sno = student_course.sno and student_course.cno in (
	select cno
	from course
	where cname = '���ݿ�ϵͳ����' or cname = '���ݽṹ'
)

--32-67 Ҫ������ʹ�����ַ�ʽ��ѯ���Ը��Ӳ�ѯ�����Խ�����ͼ��
--32)��ѯ���������������İ༶
select distinct classno
from student s1
where 2 >= (
	select COUNT(sno)
	from student s2
	where sex = '��' and s1.classno = s2.classno
);

select distinct classno
from student
group by classno, sex
having COUNT(sno) <= 2 and sex = '��';

--33����ѯ������һ�����ڵ�ѧԺ����Ϣ
select *
from department
where 1 <= (
	select COUNT(tno)
	from teacher
	where department.dno = teacher.dno and teacher.pno = '����'
);

select *
from department
where exists(
	select *
	from teacher
	where department.dno = teacher.dno and teacher.pno = '����'
);

--34).��ѯ��ÿ����ʦ����̿����������������������
select distinct teacher.tname, teacher_course.*
from teacher, teacher_course
where teacher.tno = teacher_course.tno;

--35).��ѯÿ�ſγ̼��䱻ѡ�޵�����
select cno, COUNT(sno) cnt
from student_course
group by cno;

--36).��ѯ�����Ǻӱ�ʡ�Ľ�ʦ���̵Ŀγ���Ϣ
select distinct course.*
from teacher, teacher_course, course
where teacher.home like '�ӱ�ʡ%' and teacher.tno = teacher_course.tno and teacher_course.cno = course.cno;

select *
from course
where exists (
	select *
	from teacher_course
	where course.cno = teacher_course.cno and exists (
		select *
		from teacher
		where teacher_course.tno = teacher.tno and teacher.home like '�ӱ�ʡ%'
	)
);

--37).��ѯ���ѧԺѧ�����
select student.*
from student, department
where student.dno = department.dno and department.dname = '���ѧԺ';

select *
from student
where exists (
	select *
	from department
	where student.dno = department.dno and department.dname = '���ѧԺ'
);
--38).��ѯ�༶�������İ��ѧ�����
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
--39).��ѯ����ѧ��ѡ�޵Ŀγ̺š��γ���
select distinct course.cname, course.cno
from course, student, student_course
where student.sname like '��%' and student.sno = student_course.sno and student_course.cno = course.cno;

select cno, cname
from course
where exists (
	select *
	from student_course
	where student_course.cno = course.cno and exists (
		select *
		from student
		where student_course.sno = student.sno and student.sname like '��%'
	)
);
--40).��ѯ��ѧ��ѡ�޿γ̵�ƽ����
select AVG(student_course.score)
from student, student_course
where student.sno = student_course.sno and sex = '��';

select AVG(score)
from student_course
where sno in (
	select sno
	from student
	where student.sno = student_course.sno and sex = '��'
);
--41).��ѯ��Щѧ��ѡ�����ڿ�ѧʱΪ 54 �Ŀγ�
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

--42).��ѯ�����ѧԺѧ�����䶼С������ϵѧ������Ϣ��
select s1.*
from student s1, department d1
where d1.dname = '���ѧԺ' and d1.dno != s1.dno and s1.birthday >= all(
	select birthday
	from department d2, student s2
	where d2.dname = '���ѧԺ' and s2.dno = d2.dno
);

select s1.*
from student s1
where exists (
	select *
	from department d1
	where d1.dname = '���ѧԺ' and d1.dno = s1.dno and s1.birthday >= all(
		select birthday
		from department d2, student s2
		where d2.dname = '���ѧԺ' and s2.dno = d2.dno		
	)
);
--43).��ѯ������ѧԺѧԺѧ�������Ľ���ѧԺѧ����Ϣ��
select s1.*
from student s1,department d1
where d1.dname = '����ѧԺ' and s1.dno = d1.dno and year(s1.birthday) <= all(
	select year(birthday)
	from student s2, department d2
	where d2.dname = '����ѧԺ' and s2.dno = d2.dno
);

select *
from student
where YEAR(birthday) <= all (
	select YEAR(birthday)
	from student
	where dno = (
		select dno
		from department
		where dname = '����ѧԺ'
	)) and dno = (
		select dno
		from department
		where dname = '����ѧԺ'
	);


select s1.*
from student s1,department d1
where d1.dname = '����ѧԺ' and s1.dno = d1.dno and year(s1.birthday) <= (
	select min(year(birthday))
	from student s2, department d2
	where d2.dname = '����ѧԺ' and s2.dno = d2.dno
);

--44).��ѯ�༶��Ϊ 1 �İ��ѧ�� c ���Գ�����Ƴɼ���ƽ���ɼ�
select AVG(score)
from student, student_course, course
where student.sno = student_course.sno and student.classno = '1' and student_course.cno = course.cno and course.cname = 'c ���Գ������';

--45).��ѯ���������ƽ���ɼ���ߵİ༶��
select classno, AVG(score)
from student, student_course, course
where student.sno = student_course.sno and
	student_course.cno = course.cno and
	course.cname = '���������'
group by classno
having AVG(score) >= all(
	select AVG(score)
	from student, student_course, course
	where student.sno = student_course.sno and
		student_course.cno = course.cno and
		course.cname = '���������'
	group by classno
	having AVG(score) is not null
);
--46).��ѯѡ���������Ŀγ����ĸ���ʦ�̵ģ���ʾ��ʦ�ţ���ʦ����
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
--47).��ѯ��Т����ʦ���̸��ſγ̵�ƽ���ɼ�
select cno, AVG(score)
from student_course
where sno in (
	select sno
	from student, teacher_course, teacher
	where student.classno = teacher_course.classno and teacher.tno = teacher_course.tno and
	teacher.tname = '��Т��'
) and cno in (
	select cno
	from teacher, teacher_course
	where teacher.tno = teacher_course.tno and teacher.tname = '��Т��'
)
group by cno;

--48).��ѯ³濾���ʦ���̿γ̵ĸ����༶ƽ���ɼ�
select classno, AVG(score)
from student, student_course
where student.sno = student_course.sno and cno in (
	select cno
	from teacher, teacher_course
	where teacher.tname = '³濾�' and teacher.tno = teacher_course.tno
) and classno in (
	select classno
	from teacher_course, teacher
	where teacher.tname = '³濾�' and teacher.tno = teacher_course.tno
)
group by classno;


--49).��ѯ³濾���ʦ���̿γ̵�ѧ���ĳɼ�
select sname, score
from student, student_course
where student.sno = student_course.sno and student.classno in (
	select classno
	from teacher, teacher_course
	where teacher.tno = teacher_course.tno and teacher.tname = '³濾�'
) and student_course.cno in (
	select cno
	from teacher, teacher_course
	where teacher.tname = '³濾�' and teacher.tno = teacher_course.tno
)

--50).��ѯ�ж�����ѡ���ˡ����ݽṹ���γ̵����޿Ρ�
select COUNT(distinct sno)
from student_course
where cno in (
	select cpno
	from course
	where cname = '���ݽṹ'
);
--51).��ѯ���ѧԺ��ʦ���̿γ���Ϣ
select *
from course
where cno in (
	select cno
	from teacher, teacher_course, department
	where teacher.tno = teacher_course.tno and teacher.dno = department.dno and dname = '���ѧԺ'
);

--52).��ѯ���ѧԺ��ʦ���̿γ̵ĳɼ�����������γ̺Ž������С�
select distinct student_course.cno, score
from course, student_course
where course.cno = student_course.cno and course.cno in (
	select cno
	from teacher, teacher_course, department
	where teacher.tno = teacher_course.tno and teacher.dno = department.dno and dname = '���ѧԺ'
) and sno in (
	select sno
	from student
	where classno in (
		select classno
		from teacher_course, department, teacher
		where teacher.dno = department.dno and dname = '���ѧԺ' and teacher.tno = teacher_course.tno
	)
)
order by student_course.cno desc;


--53).��ѯδ�ڿν�ʦ��������ϵ
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


--54).��ְ����ʾ���ѧԺ�Ľ�ʦ������
select pno, COUNT(tno)
from teacher, department
where teacher.dno = department.dno and dname = '���ѧԺ'
group by pno;

select pno,count(tno)
from teacher A,department B where A.dno = B.dno and
dname = '���ѧԺ' group by pno

--55).��ѯ�ɼ����ڡ����ݽṹ��ƽ���ɼ���ѧ����Ϣ��
select student.*
from student, student_course s1, course c1
where student.sno = s1.sno and s1.cno = c1.cno and c1.cname = '���ݽṹ'
	and s1.score > (
		select AVG(score)
		from student_course s2, course c2
		where s2.cno = c2.cno and c2.cname = '���ݽṹ'
		group by c2.cno
	)
	

--56).��ѯѧ��ѡ�޿γ̵��������ʾѧ�š���������ʦ�������γ����ơ��ɼ���
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

--����
select s.sno,sname,s.cno,cname,score,c.tname
from (	select A.sno,A.classno,sname,cname,score,B.cno from student A,student_course B,course C
where A.sno = B.sno and
B.cno = C.cno )s left outer join ( select D.tno,tname,E.cno,classno
from teacher D,teacher_course E where D.tno = E.tno	) c
on s.cno = c.cno and s.classno = C.classno

select student.sno, sname, course.cno, cname
from student, student_course, course
where student.sno = student_course.sno and student_course.cno = course.cno;


--57).��ѯ����ѧԺ��ʦ��һѧ�������༶
select distinct classno
from teacher, department, teacher_course
where teacher.dno = department.dno and dname = '����ѧԺ' and teacher.tno = teacher_course.tno and teacher_course.semester = 1;


--58).��ѯ�� 2 ѧ����Щ��ʦ�ڹ���¥�ϿΡ�
select distinct tname
from teacher, teacher_course
where teacher.tno = teacher_course.tno and teacher_course.semester = 2 and teacher_course.classroom like '����¥%';

select tname
from teacher A,teacher_course B where A.tno = B.tno and
semester = '2' and classroom like '����¥%'

--59).��ѯ����ѧԺ��ѧ������ƽ���ɼ�����ʾ�γ�����ƽ���ɼ���
select cname, AVG(score)
from student_course,course
where student_course.cno = course.cno and sno in (
	select sno
	from student, department
	where student.dno = department.dno and dname = '����ѧԺ'
)
group by student_course.cno;

select cname, AVG(score)
from student_course,course
where student_course.cno = course.cno and sno in (
	select sno
	from student, department
	where student.dno = department.dno and dname = '����ѧԺ'
)
group by cname;

select cname,avg(score)
from student A,student_course B,course C ,department D where A.sno = B.sno and
B.cno =C.cno and A.dno = D.dno and dname = '����ѧԺ'
group by B.cno,cname

--60).��ѯѡ����ȫ���γ̵�ѧ������Ϣ��
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

--61).��ѯ����ѡ����³濾����̵Ŀγ̵�ѧ����Ϣ
--���룺����ĳһ��ѧ����û����һ��³濾����̵Ŀγ���û��ѡ
select *
from student
where not exists(
	select *
	from student_course sc1, teacher_course tc1, teacher t
	where sc1.cno = tc1.cno and tc1.tno = t.tno and tname = '³濾�' and not exists(
		select *
		from student_course sc2
		where student.sno = sc2.sno and sc2.cno = sc1.cno
	)
)

--62).��ѯ����С��ͬһ���༶������ѧ������Ϣ
select *
from student s1
where s1.classno in (
	select classno
	from student s2
	where s2.sname = '��С��'
) and s1.sno not in (
	select sno
	from student s3
	where s3.sname = '��С��'
)

--63).��ѯ����Ӣΰͬ�������ѧ����Ϣ���ο� sql ���ڲ���������
select *
from student s1
where YEAR(s1.birthday) = (
	select YEAR(s2.birthday)
	from student s2
	where s2.sname = '��Ӣΰ'
) and s1.sname <> '��Ӣΰ';

--64).��ѯѡ���� 3 �����Ͽγ�ѧ����Ϣ
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

--��ʹ��group by��ʱ��select ��ֻ��дgroup by�Ӿ��е������У�
--����������в���group by�Ӿ��У�����뽫������ھۼ�����֮��
--ĳһ�β�ѯ�Ľ��ʹ�������������������������һ���µı�


--65).��ѯ������ 2 ��Ů���İ༶��ѧ����Ϣ
select *
from student s1
where s1.classno in (
	select classno
	from student s2
	group by s2.classno, s2.sex
	having COUNT(sno) >= 2 and s2.sex = 'Ů'
) 


--66).��ѯ���ѧԺ����С�� 25 �����ʦ����Ϣ
select teacher.*
from teacher, department
where teacher.dno = department.dno and dname = '���ѧԺ' and YEAR(GETDATE() - year(teacher.birthday)) < 25;


--67).��ѯ���ڸ��ſγ�ƽ���ֵ�ѧ���ĳɼ���Ϣ��
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
--���ϲ�ѯ
--68).����С�� 23 ���Ů��ʦ��Ůѧ������Ϣ
select *
from student
where YEAR(birthday) < 23 and sex = 'Ů'
union
select *
from teacher
where YEAR(birthday) < 23 and sex = 'Ů'
--69).��ѯ���̿ε���ʦ��Ϣ��
--70).��ѯ�༶��Ϊ 3,���Ա�ΪŮ��ѧ������Ϣ


--test
select student.*, student_course.*
from student left outer join student_course
on student.sno = student_course.sno;
