SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		<Jignesh Shah>
-- Create date: <02/26/2014>
-- Description:	<When lab order is being deleted we need to remove denominator>
-- =============================================
CREATE TRIGGER [dbo].[patient_lab_orders_AFTER_UPDATE]
   ON  [dbo].[patient_lab_orders]
   AFTER UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	declare @countInserted int, @isActive as bit, @paId int, @paLabId INT, @addedDate datetime, @drId int

	
	select	@countInserted	=	count(*)
	from	inserted
	
	
	select		@isActive = record.isActive, @paLabId = record.pa_lab_id, @paId=record.pa_id,@drId = dr_id
	from		inserted					record
	
	
	
	if(@isActive = 0)
	begin
		delete top (@countInserted) from [dbo].[MUMeasureCounts] 
		where pa_id = @paId and dr_id = @drId and measurecode='CLR' and IsDenominator = 1;
	end
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

ENABLE TRIGGER [dbo].[patient_lab_orders_AFTER_UPDATE] ON [dbo].[patient_lab_orders]
GO

GO
