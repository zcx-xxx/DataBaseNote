create proc pro_deletestudent
@sno char(9)
as
begin
  delete
  from graduation
  where 学号=@sno
end

create trigger tr_checkfee on graduation
for delete
as
begin
  declare @sno char(9)
  select @sno=学号 from deleted
  if exists(select * from fee where 学号=@sno and 欠费>0)
    begin
      raise('该生欠费，不允许毕业！',16,10)
      rollback transaction
    end
end


create function funbook
@leibie char(20)
returns table
as
return 
   select 图书.*
   from 图书,图书类别
   where 图书.类别代号=图书类别.类别代号 
   and 图书类别.类别名=@leibie
   
create trigger trinsupd on 图书
for insert,update
as
begin
  declare @leibie char(20)
  select @leibie=类别代号 from inserted
  if not exists(select * from 图书类别 where 类别代号=@leibie)
    begin
      raiserror('类别代号不正确',16,10)
      rollback transaction
    end
end

create proc prcselect
@leibie char(20)
as
begin
   select 图书.*
   from 图书,图书类别
   where 图书.类别代号=图书类别.类别代号 
   and 图书类别.类别名=@leibie
end


 create function funbooksale
 @bno char(10)
 returns int
 as
 begin
   declare @num int
   select @num=SUM(数量)
   from 订单明细
   where 书号=@bno
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
