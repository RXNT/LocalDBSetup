SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================      
-- Author:  Sandeep Kesarkar      
-- Create date: 01/07/2014      
-- Description: Procedure to get the measures data based on @MeasureCode passed      
-- =============================================      
CREATE PROCEDURE dbo.StageII_Measures_Get_Stats      
 @dr_id int, @reporting_start_date date, @reporting_end_date date, @MeasureCode Varchar(3)      
AS      
BEGIN      
 -- SET NOCOUNT ON added to prevent extra result sets from      
 -- interfering with SELECT statements.      
 SET NOCOUNT ON;      
 declare @MeasureStage as varchar(10);      
 set @MeasureStage = 'MU2014';      
      
 if exists(select top 1 id from dbo.[MUMeasures] where PassingCriteria = 'Yes/No' and MeasureCode = @MeasureCode)      
  begin      
   select @dr_id As dr_id,@MeasureCode as MeasureCode,0 as Numerator, 0 as Denominator,MUM.MeasureName, MUM.DisplayOrder, MUM.MeasureDescription, MUM.PassingCriteria, MUm.MeasureGroup, MUM.MeasureStage, 'Yes' as MeasureResult,MUM.MeasureGroupName,MUM.Id  
    
   from dbo.MUMeasures    MUM  with(nolock)      
   where MUM.MeasureCode  = @MeasureCode      
  end      
 else      
  begin       
   with MeasureStat as      
   (      
    SELECT  @dr_id As dr_id, @MeasureCode as MeasureCode, SUM(case when MUC.IsNumerator = 1 then 1 else 0 end) as Numerator, SUM(case when MUC.IsDenominator = 1 then 1 else 0 end) as Denominator      
    from  dbo.MUMeasureCounts   MUC  with(nolock)      
    where  1=1      
    and   MUC.dr_id     =  @dr_id      
    and   MUC.MeasureCode    =  @MeasureCode      
    and   MUC.RecordCreateDateTime between @reporting_start_date and @reporting_end_date      
   )      
   select  MST.dr_id, MST.MeasureCode, MST.Numerator, MST.Denominator,      
      MUM.MeasureName, MUM.DisplayOrder, MUM.MeasureDescription, MUM.PassingCriteria, MUm.MeasureGroup, MUM.MeasureStage, NULL as MeasureResult,MUM.MeasureGroupName,MUM.Id      
   from  MeasureStat     MST      
   inner join dbo.MUMeasures    MUM  with(nolock) on MUM.MeasureCode  = MST.MeasureCode      
                   and MUM.MeasureCode  = @MeasureCode      
                   and MUM.IsActive  = 1      
                   and MUM.MeasureStage = @MeasureStage;      
  end      
END 
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
