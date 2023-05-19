SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[Analys_base] as
BEGIN
 declare @dbname varchar(30)
 declare base_cursor CURSOR local static FOR
 select name from master..sysdatabases
 OPEN base_cursor
 FETCH NEXT FROM base_cursor INTO @dbname
 WHILE @@FETCH_STATUS = 0
  BEGIN
   insert into USED_DISK
   exec master..sp_spaceused2 @dbname
   FETCH NEXT FROM base_cursor INTO @dbname
  END
 CLOSE base_cursor
 DEALLOCATE base_cursor
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
