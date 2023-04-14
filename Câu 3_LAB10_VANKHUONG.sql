CREATE TRIGGER updateSoluongXoaPhieuXuat
ON Xuat
AFTER DELETE
AS
BEGIN
    -- C?p nh?t s? l�?ng h�ng trong b?ng Sanpham t��ng ?ng v?i s?n ph?m �? xu?t
    UPDATE Sanpham
    SET Soluong = Sanpham.Soluong + deleted.soluongX
    FROM Sanpham
    JOIN deleted ON Sanpham.Masp = deleted.Masp
END
go

go

SELECT * FROM sanpham