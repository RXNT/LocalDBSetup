CREATE TABLE [dbo].[referral_institutions] (
   [inst_id] [int] NOT NULL
      IDENTITY (1,1),
   [inst_name] [varchar](50) NOT NULL,
   [inst_address1] [varchar](50) NOT NULL,
   [inst_address2] [varchar](50) NOT NULL,
   [inst_city] [varchar](50) NOT NULL,
   [inst_state] [varchar](5) NOT NULL,
   [inst_zip] [varchar](10) NOT NULL,
   [inst_phone] [varchar](15) NOT NULL,
   [inst_fax] [varchar](15) NOT NULL,
   [added_by_dr_id] [int] NOT NULL,
   [enabled] [bit] NOT NULL

   ,CONSTRAINT [PK_referral_institutions] PRIMARY KEY CLUSTERED ([inst_id])
)

CREATE NONCLUSTERED INDEX [IX_MAIN] ON [dbo].[referral_institutions] ([inst_id], [inst_name], [added_by_dr_id])

GO
