CREATE TABLE [dbo].[tblVaccineGroups] (
   [vac_group_id] [int] NOT NULL
      IDENTITY (1,1),
   [vac_group_name] [varchar](50) NOT NULL,
   [vac_group_cvx] [int] NOT NULL,
   [created_by] [int] NULL,
   [created_date] [datetime] NULL,
   [updated_by] [int] NULL,
   [updated_date] [datetime] NULL

   ,CONSTRAINT [PK_tblVaccineGroups] PRIMARY KEY CLUSTERED ([vac_group_id])
)


GO
