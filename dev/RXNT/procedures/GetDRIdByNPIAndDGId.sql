SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================  
-- Author:  <Kanniyappan>  
-- Create date: <04-25-2016>  
-- Description: <Get the dr_id BY dg_id and NPI>  
-- =============================================  
CREATE PROCEDURE [dbo].[GetDRIdByNPIAndDGId]  
 -- Add the parameters for the stored procedure here  
 @NPI varchar(30),  
 @DGId bigint,
 @DRId BIGINT OUTPUT
AS  
BEGIN  
 -- SET NOCOUNT ON added to prevent extra result sets from  
 -- interfering with SELECT statements.  
 SET NOCOUNT ON;  
 DECLARE @DCID AS integer
 begin try

   set @DRId = 0;
   SET @DCID = 0
   select @DCID=dc_id from doc_groups with(nolock) where dg_id=@DGId
   if(@DCID > 0)
   BEGIN
select TOP 1 @DRId=dr_id from doctors WITH(NOLOCK) where npi = @NPI  and dg_id in (select dg_id from doc_groups with(nolock) where dc_id=@DCID)
  If @DRId = 0
  Begin
select top 1 @DRId=dr_id from doctors WITH(NOLOCK) where prescribing_authority > 2 and dr_enabled=1
and dg_id in (select dg_id from doc_groups with(nolock) where dc_id=@DCID)
  End
   END
   ELSE
   BEGIN
  select @DRId=dr_id from doctors WITH(NOLOCK) where npi = @NPI  and dg_id = @DGId
  If @DRId = 0
  Begin
select top 1 @DRId=dr_id from doctors WITH(NOLOCK) where prescribing_authority > 2 and dg_id = @DGId and dr_enabled=1
  End
END
 end try
 begin catch
 
 end catch
   
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
