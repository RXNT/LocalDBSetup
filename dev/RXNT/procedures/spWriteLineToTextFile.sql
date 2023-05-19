SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[spWriteLineToTextFile] (@String VARCHAR(max), @FilePath VARCHAR(1000), @Mode INT) AS 

DECLARE @objFileSystem INT
DECLARE @objTextStream INT
DECLARE @hr INT

SET NOCOUNT ON

EXECUTE @hr = sp_OACreate 'Scripting.FileSystemObject', @objFileSystem OUT
EXECUTE @hr = sp_OAMethod  @objFileSystem, 'OpenTextFile', @objTextStream OUT, @FilePath, @Mode, TRUE 
EXECUTE @hr = sp_OAMethod  @objTextStream, 'WriteLine', NULL, @String
EXECUTE @hr = sp_OAMethod  @objTextStream, 'Close'
EXECUTE sp_OADestroy @objTextStream
EXECUTE sp_OADestroy @objFileSystem
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
