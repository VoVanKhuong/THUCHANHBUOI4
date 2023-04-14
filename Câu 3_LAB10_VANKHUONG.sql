CREATE TRIGGER updateSoluongXoaPhieuXuat
ON Xuat
AFTER DELETE
AS
BEGIN
    -- C?p nh?t s? lý?ng hàng trong b?ng Sanpham týõng ?ng v?i s?n ph?m ð? xu?t
    UPDATE Sanpham
    SET Soluong = Sanpham.Soluong + deleted.soluongX
    FROM Sanpham
    JOIN deleted ON Sanpham.Masp = deleted.Masp
END
go

go

SELECT * FROM sanpham