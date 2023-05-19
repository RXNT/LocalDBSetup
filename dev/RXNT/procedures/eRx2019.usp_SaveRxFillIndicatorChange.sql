SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
      

CREATE PROCEDURE [eRx2019].[usp_SaveRxFillIndicatorChange]
@RxId BIGINT,
@PatientId BIGINT,
@DoctorId BIGINT=NULL,
@LoggedInUserId BIGINT=NULL,
@DoctorCompanyId BIGINT,
@FillStatusFilter INT=NULL
AS
BEGIN
	UPDATE pd SET rxfillstatus_filter_settings=@FillStatusFilter 
	FROM prescription_details pd WITH(NOLOCK)
	INNER JOIN prescriptions pres WITH(NOLOCK) ON pd.pres_id=pres.pres_id
	WHERE pres.PRES_ID =  @RxId AND pres.pa_id=@PatientId;
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
