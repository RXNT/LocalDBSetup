CREATE TABLE [dbo].[tblVaccineCVXToVISMappings] (
   [map_id] [int] NOT NULL
      IDENTITY (1,1),
   [cvx_id] [int] NOT NULL,
   [vis_concept_id] [int] NOT NULL,
   [created_by] [int] NULL,
   [created_date] [datetime] NULL,
   [updated_by] [int] NULL,
   [updated_date] [datetime] NULL,
   [is_active] [bit] NULL

   ,CONSTRAINT [PK_tblVaccineCVXToVISMappings] PRIMARY KEY CLUSTERED ([map_id])
)


GO
