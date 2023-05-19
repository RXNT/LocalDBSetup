CREATE TABLE [dbo].[patient_hx] (
   [pat_hx_id] [int] NOT NULL
      IDENTITY (1,1),
   [pat_id] [int] NOT NULL,
   [has_nofhx] [bit] NULL,
   [has_nomedx] [bit] NULL,
   [has_nosurghx] [bit] NULL,
   [fhx_dr_id] [int] NULL,
   [fhx_last_updated_on] [datetime] NULL,
   [fhx_last_updated_by] [int] NULL,
   [medhx_dr_id] [int] NULL,
   [medhx_last_updated_on] [datetime] NULL,
   [medhx_last_updated_by] [int] NULL,
   [surghx_dr_id] [int] NULL,
   [surghx_last_updated_on] [datetime] NULL,
   [surghx_last_updated_by] [int] NULL,
   [has_nohosphx] [bit] NULL,
   [hosphx_dr_id] [int] NULL,
   [hosphx_last_updated_on] [datetime] NULL,
   [hosphx_last_updated_by] [int] NULL
)


GO
