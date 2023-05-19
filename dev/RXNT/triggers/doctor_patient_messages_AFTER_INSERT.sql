SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		<Jignesh Shah>
-- Create date: <01/30/2014>
-- Description:	<Trigger to capture Secure electronic messaging
-- =============================================
CREATE TRIGGER [dbo].[doctor_patient_messages_AFTER_INSERT]
   ON  [dbo].[doctor_patient_messages]
   AFTER INSERT
   NOT FOR REPLICATION
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    declare	@event_name as varchar(3), @MUMeasuresId as int, @MeasureCode as varchar(3);
    declare @IsNumerator bit, @IsDenominator bit, @RecordCreateUserId int, @RecordCreateDateTime datetime;
    declare @dc_id as int, @dg_id as int, @dr_id as int, @pa_id as int, @enc_id as int,
			@enc_date as datetime, @DateAdded as datetime;
	set @event_name = 'SEM'
	select		@dr_id = plo.to_id, @pa_id = plo.from_id, @enc_id = null, @enc_date = null, @DateAdded = GETDATE(),
				@IsNumerator = 1, @IsDenominator = 0, @RecordCreateUserId = plo.from_id, @RecordCreateDateTime = GETDATE()
	from		inserted					plo
	
	-- Check if we get a record in patients table based on plo.from_id => @pa_id
	
	if not exists
	(select pa_id from dbo.patients where pa_id = @pa_id
		and dg_id in 
		(
			select dg_id from doc_groups DG with(nolock) 
			inner join
			(	select dc_id from doctors DR with(nolock)
				inner join doc_groups DG with(nolock) on DR.dg_id = DG.dg_id
				where dr_id = @dr_id
			) DC1 on DG.dc_id = DC1.dc_id
		)
	)
	begin
		select		@dr_id = plo.from_id , @pa_id = plo.to_id, @enc_id = null, @enc_date = null, @DateAdded = GETDATE(),
				@IsNumerator = 1, @IsDenominator = 0, @RecordCreateUserId = plo.from_id, @RecordCreateDateTime = GETDATE()
		from		inserted					plo
	end
	if exists
	(select pa_id from dbo.patients where pa_id = @pa_id
		and dg_id in 
		(
			select dg_id from doc_groups DG with(nolock) 
			inner join
			(	select dc_id from doctors DR with(nolock)
				inner join doc_groups DG with(nolock) on DR.dg_id = DG.dg_id
				where dr_id = @dr_id
			) DC1 on DG.dc_id = DC1.dc_id
		)
	)
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

ENABLE TRIGGER [dbo].[doctor_patient_messages_AFTER_INSERT] ON [dbo].[doctor_patient_messages]
GO

GO
