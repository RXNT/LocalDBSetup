CREATE TABLE [dbo].[patient_care_providers] (
   [id] [int] NOT NULL
      IDENTITY (1,1),
   [pa_id] [int] NOT NULL,
   [prv_fav_id] [int] NOT NULL,
   [enable] [bit] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL

   ,CONSTRAINT [PK_patient_care_providers] PRIMARY KEY CLUSTERED ([id])
)


GO
