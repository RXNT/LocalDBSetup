CREATE TABLE [dbo].[patient_flag_inactiveindicator] (
   [flag_id] [int] NOT NULL
      IDENTITY (1,1),
   [is_enabled] [bit] NOT NULL

   ,CONSTRAINT [PK_patient_flag_inactiveindicator] PRIMARY KEY CLUSTERED ([flag_id])
)


GO
