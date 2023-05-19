SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Nambi
Create date			:	30-MAY-2017
Description			:	This procedure is used to get unreleased Patient encounters count
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/


CREATE PROCEDURE [prv].[usp_GetUnreleasedEncountersCount]
	@DoctorId BIGINT,
    @DoctorGroupId BIGINT,
    @StartDate DATETIME = NULL,
    @EndDate DATETIME = NULL
AS
BEGIN

    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

    DECLARE @PreferredPrescriberId BIGINT = 0;
    DECLARE @DcId BIGINT = 0;
    SELECT @DcId = dg.dc_id
    FROM dbo.doctors dr WITH (NOLOCK)
        INNER JOIN doc_groups dg WITH (NOLOCK)
            ON dr.dg_id = dg.dg_id
    WHERE dr.dr_id = @DoctorId;


    IF NOT EXISTS
    (
        SELECT *
        FROM RsynMasterCompanyExternalAppMaps CMA WITH (NOLOCK)
            INNER JOIN RsynMasterCompanyModuleAccess CMC WITH (NOLOCK)
                ON CMA.CompanyId = cast(CMC.CompanyId As Varchar(100))
        WHERE CMA.ExternalCompanyId = cast( @DcId As varchar(100))
              AND CMA.ExternalAppId IN ( 1, 13 )
              AND CMC.ApplicationId = 3
              AND CMC.active = 1
    )
    BEGIN
        SELECT 0;
        RETURN;
    END;

    SELECT @PreferredPrescriberId = di.staff_preferred_prescriber
    FROM dbo.doctor_info di WITH (NOLOCK)
    WHERE di.dr_id = @DoctorId;

    IF (@PreferredPrescriberId > 0)
    BEGIN
        SET @DoctorId = @PreferredPrescriberId;
    END;
    DECLARE @Count AS INT;

    IF @StartDate IS NULL
    BEGIN
        SET @StartDate = DATEADD(MONTH, -1, GETDATE());
    END;
    SET @EndDate = ISNULL(@EndDate, GETDATE());
    SET @EndDate = DATEADD(DAY, +1, @EndDate);

	DECLARE @tEnc TABLE (
		ExternalEncounterId varchar(100),
		ExternalPatientId VARCHAR(100)
	)

	INSERT INTO @tEnc
	(
	    ExternalEncounterId,
	    ExternalPatientId
	)
    SELECT PMV2.ExternalEncounterId,
           MPEM.ExternalPatientId
    FROM [dbo].[RsynPMV2Encounters] PMV2 WITH (NOLOCK)
        INNER JOIN dbo.RsynMasterPatientExternalAppMaps MPEM WITH (NOLOCK)
            ON	CAST(PMV2.PatientId AS VARCHAR(100)) = MPEM.PatientId
            AND CAST(PMV2.DoctorCompanyId AS VARCHAR(100)) = MPEM.CompanyId
    WHERE MPEM.ExternalDoctorCompanyId = CAST(@DcId As varchar(100))
          AND MPEM.ExternalAppId = 1
          AND PMV2.CreatedDate >= @StartDate
          AND PMV2.ExternalAppId = 1;

    SELECT COUNT(enc_id)
    FROM enchanced_encounter A WITH (NOLOCK)
    INNER JOIN doctors B WITH (NOLOCK)
        ON A.dr_id = B.dr_id
    INNER JOIN doctors C WITH (NOLOCK)
        ON A.added_by_dr_id = C.dr_id
    INNER JOIN patients PAT WITH (NOLOCK)
        ON A.patient_id = PAT.pa_id
    WHERE A.dr_id = @DoctorId
          AND B.dg_id = @DoctorGroupId
          AND ISNULL(A.is_released, 0) = 0
          AND
          (
              @StartDate IS NULL 
			  OR A.enc_date BETWEEN @StartDate AND @EndDate
          )
          AND NOT EXISTS
    (
        SELECT PMT.ExternalEncounterId
        FROM @tEnc PMT
        WHERE PMT.ExternalPatientId = CAST(A.patient_id AS VARCHAR(100))
              AND PMT.ExternalEncounterId = CAST(A.enc_id AS VARCHAR(100))
    );

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
