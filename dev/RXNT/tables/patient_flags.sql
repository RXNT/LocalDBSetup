CREATE TABLE [dbo].[patient_flags] (
   [flag_id] [int] NOT NULL
      IDENTITY (1,1),
   [flag_title] [varchar](50) NOT NULL,
   [is_enabled] [bit] NOT NULL,
   [dc_id] [int] NOT NULL,
   [hide_on_search] [bit] NULL,
   [parent_flag_id] [int] NULL

   ,CONSTRAINT [PK_patient_flags] PRIMARY KEY CLUSTERED ([flag_id])
)


GO
