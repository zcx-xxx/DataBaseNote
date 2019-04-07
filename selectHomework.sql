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
--44).��ѯ�༶��Ϊ 1 �İ��ѧ�� c ���Գ�����Ƴɼ���ƽ���ɼ�
--45).��ѯ���������ƽ���ɼ���ߵİ༶��
--46).��ѯѡ���������Ŀγ����ĸ���ʦ�̵ģ���ʾ��ʦ�ţ���ʦ����
--47).��ѯ��Т����ʦ���̸��ſγ̵�ƽ���ɼ�
--48).��ѯ³濾���ʦ���̿γ̵ĸ����༶ƽ���ɼ�
--49).��ѯ³濾���ʦ���̿γ̵�ѧ���ĳɼ�
--50).��ѯ�ж�����ѡ���ˡ����ݽṹ���γ̵����޿Ρ�
--51).��ѯ���ѧԺ��ʦ���̿γ���Ϣ
--52).��ѯ���ѧԺ��ʦ���̿γ̵ĳɼ�����������γ̺Ž������С�
--53).��ѯδ�ڿν�ʦ��������ϵ
--54).��ְ����ʾ���ѧԺ�Ľ�ʦ������
--55).��ѯ�ɼ����ڡ����ݽṹ��ƽ���ɼ���ѧ����Ϣ��
--56).��ѯѧ��ѡ�޿γ̵��������ʾѧ�š���������ʦ�������γ����ơ��ɼ���
--57).��ѯ����ѧԺ��ʦ��һѧ�������༶
--58).��ѯ�� 2 ѧ����Щ��ʦ�ڹ���¥�ϿΡ�
--59).��ѯ����ѧԺ��ѧ������ƽ���ɼ�����ʾ�γ�����ƽ���ɼ���
--60).��ѯѡ����ȫ���γ̵�ѧ������Ϣ��
--61).��ѯ����ѡ����³濾����̵Ŀγ̵�ѧ����Ϣ
--62).��ѯ����С��ͬһ���༶������ѧ������Ϣ
--63).��ѯ����Ӣΰͬ�������ѧ����Ϣ���ο� sql ���ڲ���������
--64).��ѯѡ���� 3 �����Ͽγ�ѧ����Ϣ
--65).��ѯ������ 2 ��Ů���İ༶��ѧ����Ϣ
--66).��ѯ���ѧԺ����С�� 25 �����ʦ����Ϣ
--67).��ѯ���ڸ��ſγ�ƽ���ֵ�ѧ���ĳɼ���Ϣ��

--���ϲ�ѯ
--68).����С�� 23 ���Ů��ʦ��Ůѧ������Ϣ
--69).��ѯ���̿ε���ʦ��Ϣ��
--70).��ѯ�༶��Ϊ 3,���Ա�ΪŮ��ѧ������Ϣ