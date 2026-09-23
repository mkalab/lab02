-- ============================================================
-- BÀI THỰC HÀNH 2 - CÂU D: Kiểm tra User & Phân quyền
-- CSDL: QLBongDa
-- ============================================================

USE QLBongDa;
GO

-- ============================================================
-- 1. DANH SÁCH USER TRONG QLBongDa
-- ============================================================
PRINT '=== 1. DANH SÁCH USER TRONG QLBongDa ===';
SELECT 
    name AS [Database_User],
    type_desc AS [User_Type],
    create_date AS [Create_Date],
    authentication_type_desc AS [Authentication_Type]
FROM sys.database_principals
WHERE type IN ('S', 'U', 'G') -- S: SQL User, U: Windows User, G: Windows Group
ORDER BY name;

-- ============================================================
-- 2. ROLE MEMBERSHIP: BDAdmin/BDBK/BDRead/BDU02 gán qua role
-- ============================================================
PRINT '=== 2. ROLE MEMBERSHIP (db_owner, db_datareader,...) ===';
SELECT 
    m.name  AS [User],
    r.name  AS [Role_Name]
FROM sys.database_role_members rm
JOIN sys.database_principals m ON rm.member_principal_id = m.principal_id
JOIN sys.database_principals r ON rm.role_principal_id   = r.principal_id
WHERE m.type IN ('S', 'U', 'G')
ORDER BY m.name, r.name;

-- ============================================================
-- 3. OBJECT & COLUMN PERMISSIONS: BDU03 (CAULACBO), BDU04 (CAUTHU + DENY cột)
-- minor_id = 0 => quyền cả bảng | minor_id > 0 => quyền cấp cột
-- ============================================================
PRINT '=== 3. OBJECT / COLUMN PERMISSIONS (GRANT / DENY) ===';
SELECT 
    pr.name                                                           AS [User],
    pe.state_desc                                                     AS [State],
    pe.permission_name                                                AS [Permission],
    OBJECT_NAME(pe.major_id)                                          AS [Table_Name],
    ISNULL(COL_NAME(pe.major_id, pe.minor_id), '-- (table level) --') AS [Column_Name]
FROM sys.database_permissions pe
JOIN sys.database_principals  pr ON pe.grantee_principal_id = pr.principal_id
WHERE pr.type IN ('S', 'U', 'G')
  AND pe.class = 1   -- OBJECT_OR_COLUMN
ORDER BY pr.name, OBJECT_NAME(pe.major_id), pe.state_desc, pe.permission_name;

-- ============================================================
-- 4. DATABASE-LEVEL PERMISSIONS: GRANT CREATE TABLE (BDU01)
-- ============================================================
PRINT '=== 4. DATABASE-LEVEL PERMISSIONS (CREATE TABLE,...) ===';
SELECT 
    pr.name            AS [User],
    pe.state_desc      AS [State],
    pe.permission_name AS [Permission]
FROM sys.database_permissions pe
JOIN sys.database_principals  pr ON pe.grantee_principal_id = pr.principal_id
WHERE pr.type IN ('S', 'U', 'G')
  AND pe.class = 0   -- DATABASE
ORDER BY pr.name;

-- ============================================================
-- 5. SCHEMA PERMISSIONS: GRANT ALTER ON SCHEMA::dbo (BDU01)
-- ============================================================
PRINT '=== 5. SCHEMA PERMISSIONS (ALTER ON SCHEMA::dbo) ===';
SELECT 
    pr.name            AS [User],
    pe.state_desc      AS [State],
    pe.permission_name AS [Permission],
    s.name             AS [Schema_Name]
FROM sys.database_permissions pe
JOIN sys.database_principals  pr ON pe.grantee_principal_id = pr.principal_id
JOIN sys.schemas               s  ON pe.major_id             = s.schema_id
WHERE pr.type IN ('S', 'U', 'G')
  AND pe.class = 3   -- SCHEMA
ORDER BY pr.name;

-- ============================================================
-- 6. SERVER-LEVEL PERMISSIONS: ALTER TRACE (BDProfile)
-- Phải dùng master vì ALTER TRACE là server-level, không thuộc QLBongDa
-- ============================================================
PRINT '=== 6. SERVER-LEVEL PERMISSIONS (BDProfile - ALTER TRACE) ===';
USE master;
GO
SELECT 
    pr.name            AS [Login],
    pe.state_desc      AS [State],
    pe.permission_name AS [Permission]
FROM sys.server_permissions pe
JOIN sys.server_principals   pr ON pe.grantee_principal_id = pr.principal_id
WHERE pr.name = 'BDProfile';
