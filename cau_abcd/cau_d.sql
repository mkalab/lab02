-- ============================================================
-- BÀI THỰC HÀNH 2 - CÂU D: Tạo User và Phân quyền
-- CSDL: QLBongDa
-- ============================================================

-- ============================================================
-- 1. BDAdmin — Toàn quyền trên QLBongDa (db_owner)
-- ============================================================
USE master;
GO
CREATE LOGIN BDAdmin WITH PASSWORD = 'Admin@123456', CHECK_POLICY = OFF;
GO
USE QLBongDa;
GO
CREATE USER BDAdmin FOR LOGIN BDAdmin;
GO
ALTER ROLE db_owner ADD MEMBER BDAdmin;
GO

-- ============================================================
-- 2. BDBK — Được phép backup CSDL QLBongDa
-- ============================================================
USE master;
GO
CREATE LOGIN BDBK WITH PASSWORD = 'Backup@123456', CHECK_POLICY = OFF;
GO
USE QLBongDa;
GO
CREATE USER BDBK FOR LOGIN BDBK;
GO
ALTER ROLE db_backupoperator ADD MEMBER BDBK;
GO

-- ============================================================
-- 3. BDRead — Chỉ được phép xem dữ liệu (SELECT)
-- ============================================================
USE master;
GO
CREATE LOGIN BDRead WITH PASSWORD = 'Read@123456', CHECK_POLICY = OFF;
GO
USE QLBongDa;
GO
CREATE USER BDRead FOR LOGIN BDRead;
GO
ALTER ROLE db_datareader ADD MEMBER BDRead;
GO

-- ============================================================
-- 4. BDU01 — Được phép tạo table mới (CREATE TABLE)
-- Lưu ý: cần thêm ALTER ON SCHEMA::dbo để có thể tạo table trong schema mặc định
-- ============================================================
USE master;
GO
CREATE LOGIN BDU01 WITH PASSWORD = 'User01@123456', CHECK_POLICY = OFF;
GO
USE QLBongDa;
GO
CREATE USER BDU01 FOR LOGIN BDU01;
GO
GRANT CREATE TABLE TO BDU01;
GRANT ALTER ON SCHEMA::dbo TO BDU01;
GO

-- ============================================================
-- 5. BDU02 — Cập nhật dữ liệu các table,
--            KHÔNG được thêm mới hoặc xóa table (DDL)
-- Dùng db_datareader + db_datawriter = toàn quyền DML,
-- nhưng không grant bất kỳ DDL nào => mặc định không có quyền DDL
-- ============================================================
USE master;
GO
CREATE LOGIN BDU02 WITH PASSWORD = 'User02@123456', CHECK_POLICY = OFF;
GO
USE QLBongDa;
GO
CREATE USER BDU02 FOR LOGIN BDU02;
GO
ALTER ROLE db_datareader ADD MEMBER BDU02;   -- SELECT
ALTER ROLE db_datawriter ADD MEMBER BDU02;   -- INSERT, UPDATE, DELETE
-- Không grant CREATE TABLE / DROP TABLE => BDU02 sẽ không có DDL
GO

-- ============================================================
-- 6. BDU03 — Chỉ thao tác table CAULACBO
--            (SELECT, INSERT, UPDATE, DELETE)
--            Không được thao tác các table khác
-- ============================================================
USE master;
GO
CREATE LOGIN BDU03 WITH PASSWORD = 'User03@123456', CHECK_POLICY = OFF;
GO
USE QLBongDa;
GO
CREATE USER BDU03 FOR LOGIN BDU03;
GO
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.CAULACBO TO BDU03;
GO

-- ============================================================
-- 7. BDU04 — Chỉ thao tác table CAUTHU, với giới hạn cột:
--            - Không xem được cột NGAYSINH
--            - Không sửa được cột VITRI
--            - Không thao tác table khác
-- Kỹ thuật: DENY cấp cột (column-level), DENY luôn thắng GRANT
-- ============================================================
USE master;
GO
CREATE LOGIN BDU04 WITH PASSWORD = 'User04@123456', CHECK_POLICY = OFF;
GO
USE QLBongDa;
GO
CREATE USER BDU04 FOR LOGIN BDU04;
GO
-- Cấp toàn quyền DML trên CAUTHU trước
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.CAUTHU TO BDU04;
-- Sau đó DENY riêng từng cột bị hạn chế
DENY SELECT ON dbo.CAUTHU(NGAYSINH) TO BDU04;   -- không xem được NGAYSINH
DENY UPDATE ON dbo.CAUTHU(VITRI)    TO BDU04;   -- không sửa được VITRI
GO

-- ============================================================
-- 8. BDProfile — Thao tác SQL Server Profiler
-- ALTER TRACE là server-level permission, phải cấp tại master
-- (File SQL gốc đã có lệnh GRANT nhưng thiếu CREATE LOGIN)
-- ============================================================
USE master;
GO
CREATE LOGIN BDProfile WITH PASSWORD = 'Profile@123456', CHECK_POLICY = OFF;
GO
CREATE USER BDProfile FOR LOGIN BDProfile;
GO
GRANT ALTER TRACE TO BDProfile;
GO