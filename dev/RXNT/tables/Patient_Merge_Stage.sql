CREATE TABLE [dbo].[Patient_Merge_Stage] (
   [Primary_PatientId] [varchar](50) NULL,
   [Primary_Patient_Chart] [varchar](50) NULL,
   [Primary_Patient_FirstName] [varchar](50) NULL,
   [Primary_Patient_LastName] [varchar](50) NULL,
   [Primary_Patient_Dob] [varchar](50) NULL,
   [Primary_Patient_Gender] [varchar](50) NULL,
   [Primary_Patient_Address] [varchar](100) NULL,
   [Primary_Patient_City] [varchar](50) NULL,
   [Primary_Patient_State] [varchar](50) NULL,
   [Primary_Patient_Zip] [varchar](20) NULL,
   [Primary_Patient_Active] [int] NULL,
   [Secondary_PatientId] [varchar](50) NULL,
   [Secondary_Patient_Chart] [varchar](50) NULL,
   [Secondary_Patient_FirstName] [varchar](50) NULL,
   [Secondary_Patient_LastName] [varchar](50) NULL,
   [Secondary_Patient_Dob] [varchar](50) NULL,
   [Secondary_Patient_Gender] [varchar](50) NULL,
   [Secondary_Patient_Address] [varchar](100) NULL,
   [Secondary_Patient_City] [varchar](50) NULL,
   [Secondary_Patient_State] [varchar](50) NULL,
   [Secondary_Patient_Zip] [varchar](20) NULL,
   [Secondary_Patient_Active] [int] NULL
)


GO
