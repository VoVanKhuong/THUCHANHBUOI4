create trigger trg_Nhap
on Nhap
for insert 
as
begin
declare @masp nvarchar(10), @manv nvarchar(10)
declare @sln int, @dgn float
select @masp=masp, @manv = manv, @sln=soluongN, @dgn = dongiaN
from inserted
if(not exists(select * from sanpham where masp = @masp))
   begin
         raiserror(N'Không t?n t?i s?n ph?m trong danh m?c s?n ph?m', 16, 1)
		 rollback transaction
	end
if(not exists(select * from nhanvien where manv= @manv))
   begin 
         raiserror(N'Không t?n t?i nhân viên có m? này', 16,1)
		 rollback transaction 
   end 
   if(@sln<=0 or @dgn<=0)
      begin
	       raiserror(N'Nh?p sai soluong hoac dongia', 16, 1)
		   rollback transaction
      end
	else
	--Bây gi? m?i ðý?c phép nh?p, khi này c?n thay ð?i soluong trong bang SanPham
	         update Sanpham set soluong = soluong + @sln
			 from sanpham where masp = @masp 
 end 

 SELECT * FROM sanpham 
 SELECT * FROM Nhanvien
 SELECT * FROM nhap