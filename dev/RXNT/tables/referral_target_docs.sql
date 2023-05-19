CREATE TABLE [dbo].[referral_target_docs] (
   [target_dr_id] [int] NOT NULL
      IDENTITY (1,1),
   [first_name] [varchar](50) NOT NULL,
   [last_name] [varchar](50) NOT NULL,
   [middle_initial] [varchar](5) NOT NULL,
   [GroupName] [varchar](50) NULL,
   [speciality] [varchar](50) NULL,
   [address1] [varchar](50) NULL,
   [city] [varchar](50) NULL,
   [state] [varchar](10) NULL,
   [zip] [varchar](50) NULL,
   [phone] [varchar](50) NULL,
   [fax] [varchar](50) NOT NULL,
   [IsLocal] [bit] NOT NULL,
   [ext_doc_id] [int] NOT NULL,
   [dc_id] [bigint] NULL,
   [from_target_dr_id] [bigint] NULL,
   [direct_email] [varchar](50) NULL,
   [ModifiedDate] [datetime] NULL,
   [MasterContactId] [bigint] NULL,
   [address2] [varchar](50) NULL

   ,CONSTRAINT [PK_referral_target_docs] PRIMARY KEY CLUSTERED ([target_dr_id])
)


GO
