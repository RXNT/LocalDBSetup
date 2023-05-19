SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Vidya
-- Create date: 08/09/2016
-- Description:	This trigger is used to queue the patients changes in table
-- =============================================
CREATE TRIGGER [dbo].[tr_patients_CreatePatientQueue] 
   ON  [dbo].[patients]
   AFTER INSERT, UPDATE, DELETE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	Declare @action As VARCHAR(5)
	
	DECLARE @PatientTable TABLE
	(
		pa_id BIGINT,
		dg_id BIGINT,
		dc_id BIGINT,
		OwnerType VARCHAR(5),
		CreatedBy BIGINT
	) 
	
	if exists(SELECT * from inserted) and exists (SELECT * from deleted)
	begin
		SET @action = 'UPD'
		INSERT INTO @PatientTable		
		SELECT	pat.pa_id, pat.dg_id, dgp.dc_id, isnull(pat.OwnerType, ''), pat.add_by_user
		FROM	inserted pat WITH (NOLOCK)
				inner join	dbo.doc_groups dgp	with(nolock)	on	dgp.dg_id	=	pat.dg_id
	end
	
	If exists (Select * from inserted) and not exists(Select * from deleted)
	begin
		SET @action = 'INS';
		INSERT INTO @PatientTable
		SELECT	pat.pa_id,  pat.dg_id, dgp.dc_id,  isnull(pat.OwnerType, ''),  pat.add_by_user
		FROM	inserted pat WITH (NOLOCK)
				inner join	dbo.doc_groups dgp	with(nolock)	on	dgp.dg_id	=	pat.dg_id
	end

	If exists(select * from deleted) and not exists(Select * from inserted)
	begin 
		SET @action = 'DEL';
		INSERT INTO @PatientTable
		SELECT	 pat.pa_id, pat.dg_id, dgp.dc_id, isnull(pat.OwnerType, ''), pat.add_by_user
		FROM	deleted pat WITH (NOLOCK)
				inner join	dbo.doc_groups dgp	with(nolock)	on	dgp.dg_id	=	pat.dg_id
	end
	
	Insert Into que.PatientQueue
	(pa_id, dc_id, ActionType, OwnerType, QueueStatus, CreatedDate, CreatedBy)
	SELECT	pa_id, dc_id, @action, OwnerType, 'PENDG', GETDATE(), CreatedBy 
	FROM	@PatientTable
	WHERE	ISNULL(OwnerType , '') != 'V2'  
	AND ISNULL(OwnerType , '') != 'EHR'
	AND ISNULL(dg_id, 0) > 0
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

ENABLE TRIGGER [dbo].[tr_patients_CreatePatientQueue] ON [dbo].[patients]
GO

GO
