create proc pro_deletestudent
@sno char(9)
as
begin
  delete
  from graduation
  where ѧ��=@sno
end

create trigger tr_checkfee on graduation
for delete
as
begin
  declare @sno char(9)
  select @sno=ѧ�� from deleted
  if exists(select * from fee where ѧ��=@sno and Ƿ��>0)
    begin
      raise('����Ƿ�ѣ��������ҵ��',16,10)
      rollback transaction
    end
end


create function funbook
@leibie char(20)
returns table
as
return 
   select ͼ��.*
   from ͼ��,ͼ�����
   where ͼ��.������=ͼ�����.������ 
   and ͼ�����.�����=@leibie
   
create trigger trinsupd on ͼ��
for insert,update
as
begin
  declare @leibie char(20)
  select @leibie=������ from inserted
  if not exists(select * from ͼ����� where ������=@leibie)
    begin
      raiserror('�����Ų���ȷ',16,10)
      rollback transaction
    end
end

create proc prcselect
@leibie char(20)
as
begin
   select ͼ��.*
   from ͼ��,ͼ�����
   where ͼ��.������=ͼ�����.������ 
   and ͼ�����.�����=@leibie
end


 create function funbooksale
 @bno char(10)
 returns int
 as
 begin
   declare @num int
   select @num=SUM(����)
   from ������ϸ
   where ���=@bno
   return @num
 end

create proc order_tot_amt
@o_id char(9),
@p_tot int output
as
begin
  select @p_tot=unitprice*quantity
  from orderdetails
  where orderid = @o_id
end

create function order_tot_amt
@o_id char(9)
returns int
as
begin
  declare @p_tot int
  select @p_tot=unitprice*quantity
  from orderdetails
  where orderid = @o_id
  return @p_tot
end
