CREATE TRIGGER tr_updateNhap
ON Nhap
AFTER UPDATE
AS
BEGIN
    -- Ki?m tra s? b?n ghi thay ð?i
    IF (SELECT COUNT(*) FROM inserted) > 1
    BEGIN
        RAISERROR('Ch? ðý?c phép c?p nh?t 1 b?n ghi t?i m?t th?i ði?m', 16, 1)
        ROLLBACK
    END
    
    -- Ki?m tra s? lý?ng nh?p
    DECLARE @masp INT
    DECLARE @soluongN INT
    DECLARE @soluong INT
    
    SELECT @masp = i.masp, @soluongN = i.soluongN, @soluong = s.soluong
    FROM inserted i
    INNER JOIN Sanpham s ON i.masp = s.masp
    
    IF (@soluongN > @soluong)
    BEGIN
        RAISERROR('S? lý?ng nh?p không ðý?c vý?t quá s? lý?ng hi?n có trong kho', 16, 1)
        ROLLBACK
    END
    
    -- C?p nh?t s? lý?ng trong b?ng Sanpham
    UPDATE Sanpham
    SET soluong = soluong + (@soluongN - (SELECT soluongN FROM deleted WHERE masp = @masp))
    WHERE masp = @masp
END

go

go

SELECT * FROM Nhap
SELECT * FROM sanpham 