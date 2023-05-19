SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Jignesh Shah
-- Create date: 01/31/2014
-- Description:	Create numertor count when the record is updated
-- =============================================
CREATE TRIGGER [dbo].[trigger_lab_result_details_after_update] 
   ON  [dbo].[lab_result_details] 
   AFTER UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    declare	@event_name as varchar(3), @MUMeasuresId as int, @MeasureCode as varchar(3);
    declare @IsNumerator bit, @IsDenominator bit, @RecordCreateUserId int, @RecordCreateDateTime datetime;
    declare @dc_id as int, @dg_id as int, @dr_id as int, @pa_id as int, @enc_id as int, 
			@enc_date as datetime, @DateAdded as datetime, @file_name VARCHAR(500);

	set @event_name	=	'IMG';
	
	select		@dr_id = main.dr_id, @pa_id = main.pat_id, @enc_id = null, @enc_date = null, @DateAdded = lbOrder.order_date,
				@IsNumerator = 1, @IsDenominator = 0, @RecordCreateUserId = main.dr_id, @RecordCreateDateTime = GETDATE(),
				@file_name = plo.[file_name]
	from		inserted					plo
	inner	join	dbo.lab_result_info			info	on	info.lab_result_info_id	=	plo.lab_result_info_id
	inner	join	dbo.lab_main				main	on	main.lab_id				=	info.lab_id
	inner	join	dbo.lab_order_info			lbOrder	on	(lbOrder.lab_report_id	=	info.lab_order_id	and lbOrder.lab_id	=	info.lab_id)
	-- Get event related information
	select		@MUMeasuresId = MUM.Id, @MeasureCode = MUM.MeasureCode
	from		dbo.MUMeasures			MUM		with(nolock)
	where		1=1
	and			MUM.MeasureCode			=		@event_name
	and			MUM.IsActive			=		1
	
	-- Get doctor related information
	select		@dc_id = doc.dc_id, @dg_id = dgp.dg_id --, dct.dr_id
	from		dbo.doc_companies		doc		with(nolock)
	inner join	dbo.doc_groups			dgp		with(nolock)		on	dgp.dc_id	=	doc.dc_id
																	--and	dgp.dg_id	=	@dg_id
	inner join	dbo.doctors				dct		with(nolock)		on	dct.dg_id	=	dgp.dg_id
																	and	dct.dr_id	=	@dr_id
	
	if(@file_name != null OR @file_name != '')--assuming radiology type sholud have file associated with it
	begin
		--Insert record in the MUMeasureCounts table
		exec dbo.StageII_Save_MUMeasureCounts	@MUMeasuresId, @MeasureCode, @dc_id, @dg_id, @dr_id,
												@pa_id, @enc_id, @enc_date, @DateAdded,
												@IsNumerator, @IsDenominator, @RecordCreateUserId, @RecordCreateDateTime;												
		
	end
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

ENABLE TRIGGER [dbo].[trigger_lab_result_details_after_update] ON [dbo].[lab_result_details]
GO

GO
