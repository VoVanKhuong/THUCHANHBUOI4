CREATE TRIGGER checkXuat
ON Xuat
AFTER INSERT
AS
BEGIN
    -- Ki?m tra ràng bu?c toàn v?n
    IF NOT EXISTS (SELECT masp FROM Sanpham WHERE masp = (SELECT masp FROM inserted))
    BEGIN
        RAISERROR('M? s?n ph?m không t?n t?i trong b?ng Sanpham', 16, 1)
        ROLLBACK TRANSACTION
        RETURN
    END

    IF NOT EXISTS (SELECT manv FROM Nhanvien WHERE manv = (SELECT manv FROM inserted))
    BEGIN
        RAISERROR('M? nhân viên không t?n t?i trong b?ng Nhanvien', 16, 1)
        ROLLBACK TRANSACTION
        RETURN
    END
    
    -- Ki?m tra ràng bu?c d? li?u
    DECLARE @soluongX INT
    SELECT @soluongX = soluongX FROM inserted
    
    DECLARE @soluong INT
    SELECT @soluong = soluong FROM Sanpham WHERE masp = (SELECT masp FROM inserted)
    
    IF (@soluongX > @soluong)
    BEGIN
        RAISERROR('S? lý?ng xu?t vý?t quá s? lý?ng trong kho', 16, 1)
        ROLLBACK TRANSACTION
        RETURN
    END
    
    -- C?p nh?t s? lý?ng trong b?ng Sanpham
    UPDATE Sanpham
    SET soluong = soluong - @soluongX
    WHERE masp = (SELECT masp FROM inserted)
END
go

go

SELECT * FROM Nhanvien
SELECT * FROM sanpham
SELECT * FROM nhap 