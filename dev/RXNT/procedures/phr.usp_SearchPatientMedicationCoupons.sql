SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [phr].[usp_SearchPatientMedicationCoupons] @PatientId BIGINT = 270724528
AS
BEGIN
    DECLARE @date DATETIME = GETDATE();

    SELECT DrugId,
           DrugName
    FROM
    (
        SELECT DISTINCT
               med_id AS DrugId,
               med_name AS DrugName
        FROM [dbo].[rxnt_coupons] WITH (NOLOCK)
        WHERE @date
        BETWEEN start_date AND end_date
        UNION
        SELECT DISTINCT
               rpc.med_id DrugId,
               rpc.med_name DrugName
        FROM [dbo].[rxnt_patient_coupons] rpc WITH (NOLOCK)
            INNER JOIN dbo.rxnt_patient_coupon_batches rpcb WITH (NOLOCK)
                ON rpcb.patient_coupon_id = rpc.patient_coupon_id
            INNER JOIN dbo.rxnt_patient_coupon_identifiers rpci WITH (NOLOCK)
                ON rpci.pa_coupon_batch_id = rpcb.pa_coupon_batch_id
        WHERE rpci.[expiry_date] > @date
              AND rpci.is_used <> 1
              AND DATEADD(HH, 12, ISNULL(rpci.taken_date, @date)) <= @date
    ) A
    GROUP BY DrugId,
             DrugName
    ORDER BY DrugName;


    SELECT coupon_id AS CouponId,
           med_id AS DrugId,
           'PharmacyCoupon' AS CouponType,
           title,
           med_name AS DrugName
    FROM [dbo].[rxnt_coupons] WITH (NOLOCK)
    WHERE @date
    BETWEEN start_date AND end_date
    UNION ALL
    SELECT DISTINCT
           rpc.patient_coupon_id AS CouponId,
           rpc.med_id AS DrugId,
           'PatientCoupon' AS CouponType,
           rpc.title,
           rpc.med_name AS DrugName
    FROM [dbo].[rxnt_patient_coupons] rpc WITH (NOLOCK)
        INNER JOIN rxnt_patient_coupon_batches rpcb WITH (NOLOCK)
            ON rpcb.patient_coupon_id = rpc.patient_coupon_id
        INNER JOIN rxnt_patient_coupon_identifiers rpci WITH (NOLOCK)
            ON rpci.pa_coupon_batch_id = rpcb.pa_coupon_batch_id
    WHERE rpci.[expiry_date] > @date
          AND rpci.is_used <> 1
          AND DATEADD(HH, 12, ISNULL(rpci.taken_date, @date)) <= @date
    ORDER BY DrugId;

END;
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
