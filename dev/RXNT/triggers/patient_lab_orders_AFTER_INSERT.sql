SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		<Sandeep Kesarkar>
-- Create date: <01/09/2014>
-- Description:	<Trigger to capture CPOE - Lab order-Radiology and Lab order-Normal Labs, Event Name: CPR, CPL>
-- =============================================
CREATE TRIGGER [dbo].[patient_lab_orders_AFTER_INSERT]
   ON  [dbo].[patient_lab_orders]
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
			@enc_date as datetime, @DateAdded as datetime, @sendElectronically bit;

	declare	@test_type smallint 
	select		@dr_id = plo.dr_id, @pa_id = plo.pa_id, @enc_id = null, @enc_date = null, @DateAdded = plo.order_date,
				@IsNumerator = 1, @IsDenominator = 1, @RecordCreateUserId = added_by, @RecordCreateDateTime = plo.order_date,
				@test_type = ISNULL(ltl.test_type,0), @sendElectronically = sendElectronically
	from		inserted					plo
	LEFT join	dbo.lab_test_lists			ltl		with(nolock)		on	ltl.lab_test_id		=	plo.lab_test_id
																		and	ltl.active			=	1

	--if @sendElectronically = 1 
	--begin
		--Decide which event to post in event log table based on @test_type
		if @test_type = 1
			begin
				--CPOE - Radiology
				set @event_name = 'CPR'
			end
		else
			begin
				--CPOE - Labs
				set @event_name = 'CPL'
			end
		
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
		
		set @event_name = 'CLR'

		select		@dr_id = plo.dr_id, @pa_id = plo.pa_id, @enc_id = null, @enc_date = null, @DateAdded = GETDATE(),
					@IsNumerator = 0, @IsDenominator = 1, @RecordCreateUserId = plo.dr_id, @RecordCreateDateTime = GETDATE()
		from		inserted					plo
		
		-- Get event related information
		select		@MUMeasuresId = MUM.Id, @MeasureCode = MUM.MeasureCode
		from		dbo.MUMeasures			MUM		with(nolock)
		where		1=1
		and			MUM.MeasureCode			=		@event_name
		and			MUM.IsActive			=		1
		
		--Insert record in the MUMeasureCounts table
		exec dbo.StageII_Save_MUMeasureCounts	@MUMeasuresId, @MeasureCode, @dc_id, @dg_id, @dr_id,
												@pa_id, @enc_id, @enc_date, @DateAdded,
												@IsNumerator, @IsDenominator, @RecordCreateUserId, @RecordCreateDateTime;
	--end
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

ENABLE TRIGGER [dbo].[patient_lab_orders_AFTER_INSERT] ON [dbo].[patient_lab_orders]
GO

GO
