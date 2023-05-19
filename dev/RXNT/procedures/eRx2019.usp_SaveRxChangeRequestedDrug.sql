SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE   PROCEDURE [eRx2019].[usp_SaveRxChangeRequestedDrug] 
@ChangeRequestId BIGINT,
@d_drug_name VARCHAR(125),
@d_drug_ndc VARCHAR(11),
@d_drug_level INT=NULL,
@d_drug_form_code VARCHAR(15),
@d_drug_form_source_code VARCHAR(3),
@d_drug_strength VARCHAR(70),
@d_drug_strength_code VARCHAR(15),
@d_drug_strength_source_code VARCHAR(3),
@d_qty1 VARCHAR(35),
@d_qty2 VARCHAR(35),
@d_qty1_unit_code VARCHAR(50),
@d_qty2_units VARCHAR(50),
@d_qty1_enum TINYINT,
@d_qty2_enum TINYINT,
@d_dosage1 VARCHAR(1000),
@d_days_supply INT,
@d_date1 SMALLDATETIME,
@d_date2 SMALLDATETIME,
@d_date3 SMALLDATETIME,
@d_date1_enum TINYINT,
@d_date2_enum TINYINT,
@d_date3_enum TINYINT,
@d_substitution_code TINYINT, 
@d_refills VARCHAR(35),
@d_refills_enum TINYINT,
@d_comments1 VARCHAR(210),
@d_doc_info_text VARCHAR(MAX),
@MedicationRequestedXML VARCHAR(MAX)=NULL
               
AS
BEGIN  
         DECLARE @d_qty1_units VARCHAR(50)=''
		 SELECT TOP 1 @d_qty1_units=ISNULL(du_text,'') FROM duration_units WITH(NOLOCK) WHERE potency_unit_code=@d_qty1_unit_code
		 INSERT INTO [erx].[RxChangeRequestsInfo] (ChgReqId, type,DrugName,DrugNDC,DrugFormCode,DrugFormSourceCode,DrugStrength,DrugStrengthCode,DrugStrengthSourceCode
		 ,qty1,qty2,Qty1Units,Qty2Units,Qty1Enum,Qty2Enum 
				   ,Dosage1,DaysSupply,date1,date2,date3,Date1Enum,Date2Enum,Date3Enum,SubstitutionCode, 
					Refills,RefillsType,comments1,DocInfoText,Qty1UnitsPotencyCode,RequestSeg) 
		VALUES (@ChangeRequestId,'D',@d_drug_name,@d_drug_ndc,@d_drug_form_code,@d_drug_form_source_code,@d_drug_strength,@d_drug_strength_code,
		@d_drug_strength_source_code,@d_qty1,@d_qty2,@d_qty1_units,@d_qty2_units,@d_qty1_enum,@d_qty2_enum,@d_dosage1,@d_days_supply,
		@d_date1,@d_date2,@d_date3,@d_date1_enum,@d_date2_enum,@d_date3_enum,@d_substitution_code, 
					@d_refills,@d_refills_enum,@d_comments1,@d_doc_info_text ,@d_qty1_unit_code,@MedicationRequestedXML
		)
		 
            
END


                           
                        
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
