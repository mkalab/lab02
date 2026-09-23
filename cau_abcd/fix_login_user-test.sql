--taodb
USE master
GO
-- (Bỏ qua đoạn CREATE DATABASE nếu bạn đã tạo database QLBongDa rồi)

USE QLBongDa
GO

-- CHÈN THÊM ĐOẠN NÀY ĐỂ SỬA LỖI: Tạo tài khoản test tự động
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = 'test')
BEGIN
    CREATE LOGIN test WITH PASSWORD = 'test123'; 
END
GO

IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = 'test')
BEGIN
    CREATE USER test FOR LOGIN test;
END
GO
-- HẾT ĐOẠN CHÈN THÊM

-- Bây giờ lệnh này sẽ chạy mượt mà không còn lỗi nữa
GRANT CREATE TABLE TO test;
GO



