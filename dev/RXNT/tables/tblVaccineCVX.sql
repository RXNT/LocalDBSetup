CREATE TABLE [dbo].[tblVaccineCVX] (
   [cvx_id] [int] NOT NULL
      IDENTITY (1,1),
   [cvx_name_short] [varchar](500) NOT NULL,
   [cvx_name_full] [varchar](500) NOT NULL,
   [cvx_code] [varchar](10) NOT NULL,
   [cvx_status] [varchar](20) NOT NULL,
   [last_updated_date] [datetime] NOT NULL,
   [notes] [varchar](max) NULL,
   [is_nonvaccine] [bit] NOT NULL,
   [created_by] [int] NULL,
   [created_date] [datetime] NULL,
   [updated_by] [int] NULL,
   [updated_date] [datetime] NULL

   ,CONSTRAINT [PK_tblVaccineCVX] PRIMARY KEY CLUSTERED ([cvx_id])
)


GO
