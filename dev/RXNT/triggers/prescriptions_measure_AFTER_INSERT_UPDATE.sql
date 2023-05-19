SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		<Sandeep Kesarkar>
-- Create date: <12/20/2013>
-- Description:	<Trigger to capture CPOE - Medication - Event Name: CPM>
-- =============================================
CREATE TRIGGER [dbo].[prescriptions_measure_AFTER_INSERT_UPDATE]
   ON  [dbo].[prescriptions]
   AFTER INSERT, UPDATE
   NOT FOR REPLICATION
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	declare	@event_name as varchar(3), @MUMeasuresId as int, @MeasureCode as varchar(3)
	
	declare @dc_id as int, @dg_id as int, @dr_id as int, @pa_id as int, @enc_id as int, 
			@enc_date as datetime, @DateAdded as datetime	
	
	declare @IsNumerator bit, @IsDenominator bit, @RecordCreateUserId int, @RecordCreateDateTime datetime
	
	declare @pres_approved_date as datetime, @pres_void as bit, @pres_delivery_method int

	declare @pres_approved_date_del as datetime, @pres_void_del as bit, @pres_delivery_method_del int
	
	select	@dr_id = dr_id, @dg_id = dg_id, @pa_id = pa_id, @enc_id = null, @enc_date = null, @DateAdded = pres_entry_date, 
			@IsNumerator = 1, @IsDenominator = 1, @RecordCreateUserId = writing_dr_id, @RecordCreateDateTime = GETDATE(),
			@pres_approved_date = pres_approved_date, @pres_void = pres_void, @pres_delivery_method = pres_delivery_method
	from	inserted;

	select	@pres_approved_date_del = pres_approved_date, @pres_void_del = pres_void, @pres_delivery_method_del = pres_delivery_method
	from	deleted;

	
	if @pres_approved_date_del is null AND @pres_approved_date is not null and @pres_void = 0
	begin
		-- Get event related information
		
		-- Get doctor related information
		select		@dc_id = doc.dc_id --, dgp.dg_id, dct.dr_id
		from		dbo.doc_companies		doc		with(nolock)
		inner join	dbo.doc_groups			dgp		with(nolock)		on	dgp.dc_id	=	doc.dc_id
																		and	dgp.dg_id	=	@dg_id
		inner join	dbo.doctors				dct		with(nolock)		on	dct.dg_id	=	dgp.dg_id
																		and	dct.dr_id	=	@dr_id;
		set @event_name = 'CPM';
		select		@MUMeasuresId = MUM.Id, @MeasureCode = MUM.MeasureCode
		from		dbo.MUMeasures			MUM		with(nolock)
		where		1=1
		and			MUM.MeasureCode			=		@event_name
		and			MUM.IsActive			=		1;
		
		--Insert CPOE Medication record in the MUMeasureCounts table
		exec dbo.StageII_Save_MUMeasureCounts	@MUMeasuresId, @MeasureCode, @dc_id, @dg_id, @dr_id,
												@pa_id, @enc_id, @enc_date, @DateAdded,
												@IsNumerator, @IsDenominator, @RecordCreateUserId, @RecordCreateDateTime;
		
		set @event_name = 'DFQ';
		select		@MUMeasuresId = MUM.Id, @MeasureCode = MUM.MeasureCode
		from		dbo.MUMeasures			MUM		with(nolock)
		where		1=1
		and			MUM.MeasureCode			=		@event_name
		and			MUM.IsActive			=		1;
		
		--Insert eRX - Drug formulary query record in the MUMeasureCounts table
		exec dbo.StageII_Save_MUMeasureCounts	@MUMeasuresId, @MeasureCode, @dc_id, @dg_id, @dr_id,
												@pa_id, @enc_id, @enc_date, @DateAdded,
												@IsNumerator, @IsDenominator, @RecordCreateUserId, @RecordCreateDateTime;
		
		--eRX - Electronic Transmission
		set @event_name = 'PTE';
		select		@MUMeasuresId = MUM.Id, @MeasureCode = MUM.MeasureCode
		from		dbo.MUMeasures			MUM		with(nolock)
		where		1=1
		and			MUM.MeasureCode			=		@event_name
		and			MUM.IsActive			=		1;
		
		--Insert denominator data
		set @IsNumerator = 0;
		set @IsDenominator = 1;
		exec dbo.StageII_Save_MUMeasureCounts	@MUMeasuresId, @MeasureCode, @dc_id, @dg_id, @dr_id,
												@pa_id, @enc_id, @enc_date, @DateAdded,
												@IsNumerator, @IsDenominator, @RecordCreateUserId, @RecordCreateDateTime;
		--Insert numerator data
		if @pres_delivery_method > 2
		begin
			set @IsNumerator = 1;
			set @IsDenominator = 0;
			exec dbo.StageII_Save_MUMeasureCounts	@MUMeasuresId, @MeasureCode, @dc_id, @dg_id, @dr_id,
													@pa_id, @enc_id, @enc_date, @DateAdded,
													@IsNumerator, @IsDenominator, @RecordCreateUserId, @RecordCreateDateTime;
		end
	end
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

ENABLE TRIGGER [dbo].[prescriptions_measure_AFTER_INSERT_UPDATE] ON [dbo].[prescriptions]
GO

GO
