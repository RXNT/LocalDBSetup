SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [support].[InsertCptCode]
@code			nvarchar(20),
@description		nvarchar(255),
@long_description	varchar(8000)
As
BEGIN
	IF NOT EXISTS(select * from cpt_codes where code=@code)
	BEGIN
		Insert into cpt_codes(Code, Description, long_desc)
		values (@code, @description, @long_description)
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
