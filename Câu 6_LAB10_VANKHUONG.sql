
CREATE TRIGGER update_soluong_sp 
ON Nhap
AFTER DELETE
AS

BEGIN
    
    UPDATE Sanpham
    SET Soluong = Sanpham.Soluong - deleted.soluongN
    FROM Sanpham
    JOIN deleted ON Sanpham.Masp = deleted.Masp
END
go

SELECT * FROM Nhap
SELECT * FROM sanpham 