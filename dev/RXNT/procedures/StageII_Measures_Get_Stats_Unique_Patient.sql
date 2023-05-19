SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
    
    
    
-- =============================================    
-- Author:  Sandeep Kesarkar    
-- Create date: 01/07/2014    
-- Description: Procedure to get the measures data based on @MeasureCode passed    
-- =============================================    
CREATE PROCEDURE [dbo].[StageII_Measures_Get_Stats_Unique_Patient]    
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
   with MeasureStat_Numerator as    
   (    
    SELECT  @dr_id As dr_id, @MeasureCode as MeasureCode, COUNT(distinct MUC.pa_id) as Numerator    
    from  dbo.MUMeasureCounts   MUC  with(nolock)    
    where  1=1    
    and   MUC.dr_id     =  @dr_id    
    and   MUC.MeasureCode    =  @MeasureCode    
    and   MUC.DateAdded between @reporting_start_date and @reporting_end_date    
    and   MUC.IsNumerator = 1    
    group by MUC.dr_id    
   ),    
   MeasureStat_Denominator as    
   (    
    SELECT  @dr_id As dr_id, @MeasureCode as MeasureCode,  COUNT(distinct MUC.pa_id) as Denominator    
    from  dbo.MUMeasureCounts   MUC  with(nolock)    
    where  1=1    
    and   MUC.dr_id     =  @dr_id    
    and   MUC.MeasureCode    =  @MeasureCode    
    and   MUC.DateAdded between @reporting_start_date and @reporting_end_date    
    and   MUC.IsDenominator = 1    
    group by MUC.dr_id    
   )    
   select  @dr_id as dr_id, @MeasureCode as MeasureCode, isnull(MSN.Numerator, 0) as Numerator, isnull(MSD.Denominator, 0) as Denominator,    
      MUM.MeasureName, MUM.DisplayOrder, MUM.MeasureDescription, MUM.PassingCriteria, MUm.MeasureGroup, MUM.MeasureStage, NULL as MeasureResult,MUM.MeasureGroupName,MUM.Id        
   from  dbo.MUMeasures    MUM  with(nolock)    
   left join MeasureStat_Numerator  MSN  with(nolock) on MUM.MeasureCode  = MSN.MeasureCode    
   left join MeasureStat_Denominator  MSD  with(nolock) on MUM.MeasureCode  = MSD.MeasureCode    
   where  1=1    
   and   MUM.MeasureCode  = @MeasureCode    
   and   MUM.IsActive  = 1    
   and   MUM.MeasureStage = @MeasureStage;    
  end    
END    
    
    
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
