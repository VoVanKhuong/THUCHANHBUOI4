CREATE TRIGGER tr_updateNhap
ON Nhap
AFTER UPDATE
AS
BEGIN
    -- Ki?m tra s? b?n ghi thay �?i
    IF (SELECT COUNT(*) FROM inserted) > 1
    BEGIN
        RAISERROR('Ch? ��?c ph�p c?p nh?t 1 b?n ghi t?i m?t th?i �i?m', 16, 1)
        ROLLBACK
    END
    
    -- Ki?m tra s? l�?ng nh?p
    DECLARE @masp INT
    DECLARE @soluongN INT
    DECLARE @soluong INT
    
    SELECT @masp = i.masp, @soluongN = i.soluongN, @soluong = s.soluong
    FROM inserted i
    INNER JOIN Sanpham s ON i.masp = s.masp
    
    IF (@soluongN > @soluong)
    BEGIN
        RAISERROR('S? l�?ng nh?p kh�ng ��?c v�?t qu� s? l�?ng hi?n c� trong kho', 16, 1)
        ROLLBACK
    END
    
    -- C?p nh?t s? l�?ng trong b?ng Sanpham
    UPDATE Sanpham
    SET soluong = soluong + (@soluongN - (SELECT soluongN FROM deleted WHERE masp = @masp))
    WHERE masp = @masp
END

go

go

SELECT * FROM Nhap
SELECT * FROM sanpham 