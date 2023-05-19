SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		 JahabarYusuff M
-- Create date:  10-APRIL-2020
-- Description:	 To change the status of GCN   to non preferred 
-- =============================================
CREATE PROCEDURE [support].[ChangeGCNStatusToNonPreferred]  --'98948,14773,01072,17730,'
(
	@gcnlist varchar(8000), --listing GCN comma seprated without space end with comma,
	@form_status INT = 1 -- Default as non-prefered
)
AS
BEGIN
	
DECLARE @pos INT
DECLARE @len INT
DECLARE @GCN varchar(8000)


set @pos = 0
set @len = 0

	WHILE CHARINDEX(',', @gcnlist, @pos+1)>0
	BEGIN
		set @len = CHARINDEX(',', @gcnlist, @pos+1) - @pos
		set @GCN = SUBSTRING(@gcnlist, @pos, @len)
            
		IF NOT EXISTS (SELECT * FROM Formularies..[RxHub_VITAS_FORM_VXFORM] where GCN = @GCN)
		BEGIN
	
		  INSERT INTO Formularies..[RxHub_VITAS_FORM_VXFORM] (source_ndc,form_status,rel_value,Text,GCN)	 VALUES('-1',@form_status,-1,NULL,@GCN)
		  	 PRINT 'GCN '+ @GCN +' is inserted into the system'
	 
		END
		ELSE
		BEGIN
		 
	    Update Formularies..[RxHub_VITAS_FORM_VXFORM] set form_status=@form_status WHERE	 GCN = @GCN 
		PRINT 'GCN '+ @GCN +' is updated in the system'
	  
		END

		set @pos = CHARINDEX(',', @gcnlist, @pos+@len) +1
	END


END

RETURN 0
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
