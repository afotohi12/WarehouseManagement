
/*VERSION:1*/

------------------------------------------------------------
-- DatabaseVersion
------------------------------------------------------------

IF OBJECT_ID('DatabaseVersion','U') IS NULL
BEGIN

    CREATE TABLE DatabaseVersion
    (
        ID INT IDENTITY(1,1)
            CONSTRAINT PK_DatabaseVersion PRIMARY KEY,

        VersionNo INT NOT NULL,

        Checksum VARCHAR(64) NOT NULL,

        ExecuteDate DATETIME NOT NULL
            CONSTRAINT DF_DatabaseVersion_ExecuteDate
            DEFAULT(GETDATE())
    );

END
GO

------------------------------------------------------------
-- DatabaseMigrationLog
------------------------------------------------------------

IF OBJECT_ID('DatabaseMigrationLog','U') IS NULL
BEGIN

    CREATE TABLE DatabaseMigrationLog
    (
        ID INT IDENTITY(1,1)
            CONSTRAINT PK_DatabaseMigrationLog PRIMARY KEY,

        VersionNo INT NOT NULL,

        Checksum VARCHAR(64) NOT NULL,

        StartDate DATETIME NOT NULL,

        EndDate DATETIME NULL,

        Success BIT NOT NULL,

        ErrorMessage NVARCHAR(MAX) NULL
    );

END
GO

/*VERSION:2*/

------------------------------------------------------------
-- Users
------------------------------------------------------------

IF OBJECT_ID('Users','U') IS NULL
BEGIN

    CREATE TABLE Users
    (
        ID INT IDENTITY(1,1)
            CONSTRAINT PK_Users PRIMARY KEY,

        UserName NVARCHAR(100) NOT NULL,

        PasswordHash NVARCHAR(256) NOT NULL,

        FullName NVARCHAR(200) NULL,

        FirstName NVARCHAR(100) NULL,

        LastName NVARCHAR(100) NULL,

        Email NVARCHAR(200) NULL,

        Mobile NVARCHAR(20) NULL,

        IsActive BIT NOT NULL
            CONSTRAINT DF_Users_IsActive DEFAULT(1),

        IsLocked BIT NOT NULL
            CONSTRAINT DF_Users_IsLocked DEFAULT(0),

        FailedLoginCount INT NOT NULL
            CONSTRAINT DF_Users_FailedLoginCount DEFAULT(0),

        LastLoginDate DATETIME NULL,

        LastFailedLoginDate DATETIME NULL,

        LockDate DATETIME NULL,

        MustChangePassword BIT NOT NULL
            CONSTRAINT DF_Users_MustChangePassword DEFAULT(0),

        PasswordNeverExpires BIT NOT NULL
            CONSTRAINT DF_Users_PasswordNeverExpires DEFAULT(0),

        PasswordChangedDate DATETIME NULL,

        CreateDate DATETIME NOT NULL
            CONSTRAINT DF_Users_CreateDate DEFAULT(GETDATE()),

        ModifiedDate DATETIME NULL,

        CreatedBy INT NULL,

        ModifiedBy INT NULL
    );

END
GO

------------------------------------------------------------
-- Foreign Keys
------------------------------------------------------------

IF NOT EXISTS
(
    SELECT *
    FROM sys.foreign_keys
    WHERE name='FK_Users_CreatedBy'
)
BEGIN

    ALTER TABLE Users
    ADD CONSTRAINT FK_Users_CreatedBy
        FOREIGN KEY (CreatedBy)
        REFERENCES Users(ID);

END
GO

IF NOT EXISTS
(
    SELECT *
    FROM sys.foreign_keys
    WHERE name='FK_Users_ModifiedBy'
)
BEGIN

    ALTER TABLE Users
    ADD CONSTRAINT FK_Users_ModifiedBy
        FOREIGN KEY (ModifiedBy)
        REFERENCES Users(ID);

END
GO

------------------------------------------------------------
-- Unique Indexes
------------------------------------------------------------

IF NOT EXISTS
(
    SELECT *
    FROM sys.indexes
    WHERE name='UX_Users_UserName'
)
BEGIN

    CREATE UNIQUE INDEX UX_Users_UserName
        ON Users(UserName);

END
GO

IF NOT EXISTS
(
    SELECT *
    FROM sys.indexes
    WHERE name='UX_Users_Email'
)
BEGIN

    CREATE UNIQUE INDEX UX_Users_Email
        ON Users(Email)
        WHERE Email IS NOT NULL;

END
GO

------------------------------------------------------------
-- Indexes
------------------------------------------------------------

IF NOT EXISTS
(
    SELECT *
    FROM sys.indexes
    WHERE name='IX_Users_IsActive'
)
BEGIN

    CREATE INDEX IX_Users_IsActive
        ON Users(IsActive);

END
GO

IF NOT EXISTS
(
    SELECT *
    FROM sys.indexes
    WHERE name='IX_Users_IsLocked'
)
BEGIN

    CREATE INDEX IX_Users_IsLocked
        ON Users(IsLocked);

END
GO

IF NOT EXISTS
(
    SELECT *
    FROM sys.indexes
    WHERE name='IX_Users_LastLoginDate'
)
BEGIN

    CREATE INDEX IX_Users_LastLoginDate
        ON Users(LastLoginDate);

END
GO

------------------------------------------------------------
-- Administrator
------------------------------------------------------------

IF NOT EXISTS
(
    SELECT *
    FROM Users
    WHERE UserName='admin'
)
BEGIN

    INSERT INTO Users
    (
        UserName,
        PasswordHash,
        FirstName,
        LastName,
        IsActive
    )
    VALUES
    (
        'admin',
        '',
        'System',
        'Administrator',
        1
    );

END
GO

/*VERSION:3*/

------------------------------------------------------------
-- Roles
------------------------------------------------------------

IF OBJECT_ID('Roles','U') IS NULL
BEGIN

    CREATE TABLE Roles
    (
        ID INT IDENTITY(1,1)
            CONSTRAINT PK_Roles PRIMARY KEY,

        Code NVARCHAR(50) NOT NULL,

        Name NVARCHAR(100) NOT NULL,

        Description NVARCHAR(500) NULL,

        IsSystem BIT NOT NULL
            CONSTRAINT DF_Roles_IsSystem DEFAULT(0),

        IsActive BIT NOT NULL
            CONSTRAINT DF_Roles_IsActive DEFAULT(1),

        CreateDate DATETIME NOT NULL
            CONSTRAINT DF_Roles_CreateDate DEFAULT(GETDATE())
    );

END
GO

IF NOT EXISTS
(
    SELECT *
    FROM sys.indexes
    WHERE name='UX_Roles_Code'
)
BEGIN

    CREATE UNIQUE INDEX UX_Roles_Code
        ON Roles(Code);

END
GO

------------------------------------------------------------
-- Seed Roles
------------------------------------------------------------

IF NOT EXISTS(SELECT * FROM Roles WHERE Code='ADMIN')
BEGIN
INSERT INTO Roles(Code,Name,Description,IsSystem)
VALUES
(
'ADMIN',
'Administrator',
'System Administrator',
1
);
END
GO

IF NOT EXISTS(SELECT * FROM Roles WHERE Code='MANAGER')
BEGIN
INSERT INTO Roles(Code,Name,Description,IsSystem)
VALUES
(
'MANAGER',
'Manager',
'Warehouse Manager',
1
);
END
GO

IF NOT EXISTS(SELECT * FROM Roles WHERE Code='USER')
BEGIN
INSERT INTO Roles(Code,Name,Description,IsSystem)
VALUES
(
'USER',
'User',
'Standard User',
1
);
END
GO

/*VERSION:4*/

------------------------------------------------------------
-- Permissions
------------------------------------------------------------

IF OBJECT_ID('Permissions','U') IS NULL
BEGIN

    CREATE TABLE Permissions
    (
        ID INT IDENTITY(1,1)
            CONSTRAINT PK_Permissions PRIMARY KEY,

        Code NVARCHAR(100) NOT NULL,

        Name NVARCHAR(200) NOT NULL,

        Description NVARCHAR(500) NULL,

        ModuleName NVARCHAR(100) NULL,

        IsSystem BIT NOT NULL
            CONSTRAINT DF_Permissions_IsSystem DEFAULT(1),

        CreateDate DATETIME NOT NULL
            CONSTRAINT DF_Permissions_CreateDate DEFAULT(GETDATE())
    );

END
GO

IF NOT EXISTS
(
SELECT *
FROM sys.indexes
WHERE name='UX_Permissions_Code'
)
BEGIN

CREATE UNIQUE INDEX UX_Permissions_Code
ON Permissions(Code);

END
GO

------------------------------------------------------------
-- Seed Permissions
------------------------------------------------------------

INSERT INTO Permissions(Code,Name,ModuleName)
SELECT 'USER_VIEW','View Users','Security'
WHERE NOT EXISTS
(
SELECT *
FROM Permissions
WHERE Code='USER_VIEW'
);
GO

INSERT INTO Permissions(Code,Name,ModuleName)
SELECT 'USER_CREATE','Create User','Security'
WHERE NOT EXISTS
(
SELECT *
FROM Permissions
WHERE Code='USER_CREATE'
);
GO

INSERT INTO Permissions(Code,Name,ModuleName)
SELECT 'USER_EDIT','Edit User','Security'
WHERE NOT EXISTS
(
SELECT *
FROM Permissions
WHERE Code='USER_EDIT'
);
GO

INSERT INTO Permissions(Code,Name,ModuleName)
SELECT 'USER_DELETE','Delete User','Security'
WHERE NOT EXISTS
(
SELECT *
FROM Permissions
WHERE Code='USER_DELETE'
);
GO

INSERT INTO Permissions(Code,Name,ModuleName)
SELECT 'ROLE_MANAGE','Manage Roles','Security'
WHERE NOT EXISTS
(
SELECT *
FROM Permissions
WHERE Code='ROLE_MANAGE'
);
GO

INSERT INTO Permissions(Code,Name,ModuleName)
SELECT 'PERMISSION_MANAGE','Manage Permissions','Security'
WHERE NOT EXISTS
(
SELECT *
FROM Permissions
WHERE Code='PERMISSION_MANAGE'
);
GO

INSERT INTO Permissions(Code,Name,ModuleName)
SELECT 'PRODUCT_VIEW','View Products','Products'
WHERE NOT EXISTS
(
SELECT *
FROM Permissions
WHERE Code='PRODUCT_VIEW'
);
GO

INSERT INTO Permissions(Code,Name,ModuleName)
SELECT 'PRODUCT_CREATE','Create Product','Products'
WHERE NOT EXISTS
(
SELECT *
FROM Permissions
WHERE Code='PRODUCT_CREATE'
);
GO

INSERT INTO Permissions(Code,Name,ModuleName)
SELECT 'PRODUCT_EDIT','Edit Product','Products'
WHERE NOT EXISTS
(
SELECT *
FROM Permissions
WHERE Code='PRODUCT_EDIT'
);
GO

INSERT INTO Permissions(Code,Name,ModuleName)
SELECT 'PRODUCT_DELETE','Delete Product','Products'
WHERE NOT EXISTS
(
SELECT *
FROM Permissions
WHERE Code='PRODUCT_DELETE'
);
GO

/*VERSION:5*/

------------------------------------------------------------
-- UserRoles
------------------------------------------------------------

IF OBJECT_ID('UserRoles','U') IS NULL
BEGIN

    CREATE TABLE UserRoles
    (
        ID INT IDENTITY(1,1)
            CONSTRAINT PK_UserRoles PRIMARY KEY,

        UserID INT NOT NULL,

        RoleID INT NOT NULL,

        CreateDate DATETIME NOT NULL
            CONSTRAINT DF_UserRoles_CreateDate DEFAULT(GETDATE())
    );

END
GO

------------------------------------------------------------
-- Foreign Keys
------------------------------------------------------------

IF NOT EXISTS
(
SELECT *
FROM sys.foreign_keys
WHERE name='FK_UserRoles_Users'
)
BEGIN

ALTER TABLE UserRoles
ADD CONSTRAINT FK_UserRoles_Users
FOREIGN KEY(UserID)
REFERENCES Users(ID);

END
GO

IF NOT EXISTS
(
SELECT *
FROM sys.foreign_keys
WHERE name='FK_UserRoles_Roles'
)
BEGIN

ALTER TABLE UserRoles
ADD CONSTRAINT FK_UserRoles_Roles
FOREIGN KEY(RoleID)
REFERENCES Roles(ID);

END
GO

------------------------------------------------------------
-- Unique User Role
------------------------------------------------------------

IF NOT EXISTS
(
SELECT *
FROM sys.indexes
WHERE name='UX_UserRoles_User_Role'
)
BEGIN

CREATE UNIQUE INDEX UX_UserRoles_User_Role
ON UserRoles(UserID,RoleID);

END
GO

------------------------------------------------------------
-- Administrator Role
------------------------------------------------------------

IF NOT EXISTS
(
SELECT *
FROM UserRoles
WHERE UserID=1
AND RoleID=1
)
BEGIN

INSERT INTO UserRoles
(
UserID,
RoleID
)
VALUES
(
1,
1
);

END
GO

/*VERSION:6*/

------------------------------------------------------------
-- RolePermissions
------------------------------------------------------------

IF OBJECT_ID('RolePermissions','U') IS NULL
BEGIN

    CREATE TABLE RolePermissions
    (
        ID INT IDENTITY(1,1)
            CONSTRAINT PK_RolePermissions PRIMARY KEY,

        RoleID INT NOT NULL,

        PermissionID INT NOT NULL,

        CreateDate DATETIME NOT NULL
            CONSTRAINT DF_RolePermissions_CreateDate DEFAULT(GETDATE())
    );

END
GO

------------------------------------------------------------
-- Foreign Keys
------------------------------------------------------------

IF NOT EXISTS
(
SELECT *
FROM sys.foreign_keys
WHERE name='FK_RolePermissions_Roles'
)
BEGIN

ALTER TABLE RolePermissions
ADD CONSTRAINT FK_RolePermissions_Roles
FOREIGN KEY(RoleID)
REFERENCES Roles(ID);

END
GO

IF NOT EXISTS
(
SELECT *
FROM sys.foreign_keys
WHERE name='FK_RolePermissions_Permissions'
)
BEGIN

ALTER TABLE RolePermissions
ADD CONSTRAINT FK_RolePermissions_Permissions
FOREIGN KEY(PermissionID)
REFERENCES Permissions(ID);

END
GO

------------------------------------------------------------
-- Unique Role Permission
------------------------------------------------------------

IF NOT EXISTS
(
SELECT *
FROM sys.indexes
WHERE name='UX_RolePermissions_Role_Permission'
)
BEGIN

CREATE UNIQUE INDEX UX_RolePermissions_Role_Permission
ON RolePermissions(RoleID,PermissionID);

END
GO

------------------------------------------------------------
-- Give ADMIN all permissions
------------------------------------------------------------

INSERT INTO RolePermissions
(
RoleID,
PermissionID
)
SELECT
1,
P.ID
FROM Permissions P
WHERE NOT EXISTS
(
SELECT 1
FROM RolePermissions RP
WHERE RP.RoleID=1
AND RP.PermissionID=P.ID
);
GO

/*VERSION:7*/

------------------------------------------------------------
-- ApplicationSettings
------------------------------------------------------------

IF OBJECT_ID('ApplicationSettings','U') IS NULL
BEGIN

    CREATE TABLE ApplicationSettings
    (
        ID INT IDENTITY(1,1)
            CONSTRAINT PK_ApplicationSettings PRIMARY KEY,

        SettingKey NVARCHAR(100) NOT NULL,

        SettingValue NVARCHAR(MAX) NULL,

        Description NVARCHAR(500) NULL,

        IsSystem BIT NOT NULL
            CONSTRAINT DF_ApplicationSettings_IsSystem DEFAULT(1),

        CreateDate DATETIME NOT NULL
            CONSTRAINT DF_ApplicationSettings_CreateDate DEFAULT(GETDATE()),

        ModifiedDate DATETIME NULL
    );

END
GO

------------------------------------------------------------
-- Unique Key
------------------------------------------------------------

IF NOT EXISTS
(
SELECT *
FROM sys.indexes
WHERE name='UX_ApplicationSettings_SettingKey'
)
BEGIN

CREATE UNIQUE INDEX UX_ApplicationSettings_SettingKey
ON ApplicationSettings(SettingKey);

END
GO

------------------------------------------------------------
-- Seed Settings
------------------------------------------------------------

INSERT INTO ApplicationSettings
(
SettingKey,
SettingValue,
Description
)
SELECT
'MAX_LOGIN_ATTEMPTS',
'5',
'Maximum failed login attempts'
WHERE NOT EXISTS
(
SELECT *
FROM ApplicationSettings
WHERE SettingKey='MAX_LOGIN_ATTEMPTS'
);
GO

INSERT INTO ApplicationSettings
(
SettingKey,
SettingValue,
Description
)
SELECT
'ACCOUNT_LOCK_MINUTES',
'30',
'Account lock duration'
WHERE NOT EXISTS
(
SELECT *
FROM ApplicationSettings
WHERE SettingKey='ACCOUNT_LOCK_MINUTES'
);
GO

INSERT INTO ApplicationSettings
(
SettingKey,
SettingValue,
Description
)
SELECT
'PASSWORD_MIN_LENGTH',
'8',
'Minimum password length'
WHERE NOT EXISTS
(
SELECT *
FROM ApplicationSettings
WHERE SettingKey='PASSWORD_MIN_LENGTH'
);
GO

INSERT INTO ApplicationSettings
(
SettingKey,
SettingValue,
Description
)
SELECT
'PASSWORD_EXPIRE_DAYS',
'90',
'Password expiration days'
WHERE NOT EXISTS
(
SELECT *
FROM ApplicationSettings
WHERE SettingKey='PASSWORD_EXPIRE_DAYS'
);
GO

INSERT INTO ApplicationSettings
(
SettingKey,
SettingValue,
Description
)
SELECT
'ALLOW_MULTIPLE_LOGIN',
'0',
'Allow multiple concurrent logins'
WHERE NOT EXISTS
(
SELECT *
FROM ApplicationSettings
WHERE SettingKey='ALLOW_MULTIPLE_LOGIN'
);
GO

/*VERSION:8*/

------------------------------------------------------------
-- AuditLog
------------------------------------------------------------

IF OBJECT_ID('AuditLog','U') IS NULL
BEGIN

    CREATE TABLE AuditLog
    (
        ID BIGINT IDENTITY(1,1)
            CONSTRAINT PK_AuditLog PRIMARY KEY,

        UserID INT NULL,

        ActionCode NVARCHAR(100) NOT NULL,

        TableName NVARCHAR(100) NULL,

        RecordID NVARCHAR(100) NULL,

        OldValue NVARCHAR(MAX) NULL,

        NewValue NVARCHAR(MAX) NULL,

        IPAddress NVARCHAR(50) NULL,

        ComputerName NVARCHAR(100) NULL,

        Description NVARCHAR(1000) NULL,

        CreateDate DATETIME NOT NULL
            CONSTRAINT DF_AuditLog_CreateDate DEFAULT(GETDATE())
    );

END
GO

------------------------------------------------------------
-- Foreign Key
------------------------------------------------------------

IF NOT EXISTS
(
SELECT *
FROM sys.foreign_keys
WHERE name='FK_AuditLog_Users'
)
BEGIN

ALTER TABLE AuditLog
ADD CONSTRAINT FK_AuditLog_Users
FOREIGN KEY(UserID)
REFERENCES Users(ID);

END
GO

------------------------------------------------------------
-- Indexes
------------------------------------------------------------

IF NOT EXISTS
(
SELECT *
FROM sys.indexes
WHERE name='IX_AuditLog_UserID'
)
BEGIN

CREATE INDEX IX_AuditLog_UserID
ON AuditLog(UserID);

END
GO

IF NOT EXISTS
(
SELECT *
FROM sys.indexes
WHERE name='IX_AuditLog_ActionCode'
)
BEGIN

CREATE INDEX IX_AuditLog_ActionCode
ON AuditLog(ActionCode);

END
GO

IF NOT EXISTS
(
SELECT *
FROM sys.indexes
WHERE name='IX_AuditLog_CreateDate'
)
BEGIN

CREATE INDEX IX_AuditLog_CreateDate
ON AuditLog(CreateDate);

END
GO