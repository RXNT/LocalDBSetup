SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE Function [dbo].[RemoveNonIntegers] (@ConvertedInteger VarChar(1000))
Returns VarChar(1000)
AS
Begin

    Declare @KeepValues as varchar(50)
    Set @KeepValues = '%[^0-9]%'
    While PatIndex(@KeepValues, @ConvertedInteger) > 0
        Set @ConvertedInteger = Stuff(@ConvertedInteger, PatIndex(@KeepValues, @ConvertedInteger), 1, '')

    Return @ConvertedInteger
End
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
