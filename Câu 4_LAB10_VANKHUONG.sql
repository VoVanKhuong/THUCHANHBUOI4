
CREATE TRIGGER update_xuat_soluong_trigger
ON xuat
AFTER UPDATE
AS
BEGIN
    -- Ki?m tra xem có ít nh?t 2 b?n ghi b? update hay không
    IF (SELECT COUNT(*) FROM inserted) < 2
    BEGIN
DECLARE @old_soluong INT, @new_soluong INT, @masp NVARCHAR(10)

        SELECT @masp = i.masp, @old_soluong = d.soluongX, @new_soluong = i.soluongX
        FROM deleted d INNER JOIN inserted i ON d.sohdx = i.sohdx AND d.masp = i.masp

        -- Ki?m tra s? lý?ng xu?t m?i có nh? hõn s? lý?ng t?n kho hay không
        IF (@new_soluong <= (SELECT soluong FROM sanpham WHERE masp = @masp))
        BEGIN
            UPDATE xuat SET soluongX = @new_soluong WHERE sohdx IN (SELECT sohdx FROM inserted)
            UPDATE sanpham SET soluong = soluong + @old_soluong - @new_soluong WHERE masp = @masp
        END
    END
END

go

go

SELECT * FROM xuat
SELECT * FROM sanpham 