CREATE TABLE [dbo].[encounter_types] (
   [enc_lst_id] [int] NOT NULL,
   [enc_name] [varchar](125) NOT NULL,
   [enc_type] [varchar](125) NOT NULL,
   [speciality] [varchar](125) NOT NULL,
   [encounter_version] [varchar](10) NULL,
   [active] [bit] NULL

   ,CONSTRAINT [PK_encounter_types] PRIMARY KEY CLUSTERED ([enc_lst_id])
)


GO
