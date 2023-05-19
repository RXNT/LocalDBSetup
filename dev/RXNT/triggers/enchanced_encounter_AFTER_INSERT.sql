SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		<Sandeep Kesarkar>
-- Create date: <01/22/2014>
-- Description:	<Trigger to capture Clinical summary
-- =============================================
CREATE TRIGGER [dbo].[enchanced_encounter_AFTER_INSERT]
   ON  [dbo].[enchanced_encounter]
   AFTER INSERT, UPDATE
   NOT FOR REPLICATION
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    declare	@event_name as varchar(3), @MUMeasuresId as int, @MeasureCode as varchar(3);
    declare @IsNumerator bit, @IsDenominator bit, @RecordCreateUserId int, @RecordCreateDateTime datetime;
    declare @dc_id as int, @dg_id as int, @dr_id as int, @pa_id as int, @enc_id as int, @type_of_visit char(5),@IsSigned bit,
			@enc_date as datetime, @DateAdded as datetime;
	
	set @event_name = 'CLS'

	select		@dr_id = plo.dr_id, @pa_id = plo.patient_id, @enc_id = plo.enc_id, @enc_date = plo.enc_date, @DateAdded = plo.enc_date,
				@IsNumerator = 0, @IsDenominator = 1, @RecordCreateUserId = plo.added_by_dr_id, @RecordCreateDateTime = GETDATE(), @type_of_visit = plo.[type_of_visit], @IsSigned = plo.issigned
	from		inserted					plo
	
	if @type_of_visit = 'OFICE' and @IsSigned = 1
	begin
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

ENABLE TRIGGER [dbo].[enchanced_encounter_AFTER_INSERT] ON [dbo].[enchanced_encounter]
GO

GO
