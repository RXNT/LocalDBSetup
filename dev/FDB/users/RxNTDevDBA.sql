IF SUSER_ID('RxNTDevDBA') IS NULL
				BEGIN CREATE LOGIN RxNTDevDBA WITH PASSWORD = 0x0200B4E613C737D49E55839B451250D70682A9B7D7D4DB2D7C20B4017DA27046D1304DCEF09380014901844F1D6FF6DC8AA55DB30E72B32503BFD0D889F54FB34D3DD91E4BF1 HASHED END
CREATE USER [RxNTDevDBA] FOR LOGIN [RxNTDevDBA] WITH DEFAULT_SCHEMA = [dbo]
/*ALTER ROLE db_owner ADD MEMBER RxNTDevDBA*/ exec sp_addrolemember 'db_owner', 'RxNTDevDBA'
GO