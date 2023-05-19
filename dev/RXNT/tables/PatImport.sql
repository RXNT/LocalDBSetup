CREATE TABLE [dbo].[PatImport] (
   [ID] [int] NOT NULL
      IDENTITY (1,1),
   [AcctID] [nvarchar](255) NULL,
   [FullName] [nvarchar](255) NULL,
   [Phone] [nvarchar](255) NULL,
   [DOB] [smalldatetime] NULL,
   [Sex] [nvarchar](255) NULL,
   [M] [nvarchar](255) NULL,
   [Prov] [nvarchar](255) NULL,
   [CoPay] [nvarchar](255) NULL,
   [XRay] [nvarchar](255) NULL,
   [Ref] [nvarchar](255) NULL,
   [DOS] [smalldatetime] NULL,
   [InsHolder] [nvarchar](255) NULL,
   [RelateCode] [nvarchar](255) NULL,
   [Address] [nvarchar](255) NULL,
   [pa_first] [varchar](50) NULL,
   [pa_middle] [varchar](50) NULL,
   [pa_last] [varchar](50) NULL,
   [pa_dob] [smalldatetime] NULL,
   [pa_address1] [varchar](100) NULL,
   [pa_address2] [varchar](100) NULL,
   [pa_city] [varchar](50) NULL,
   [pa_state] [varchar](2) NULL,
   [pa_zip] [varchar](20) NULL,
   [pa_phone] [varchar](20) NULL,
   [pa_sex] [varchar](1) NULL,
   [ic_id] [int] NULL,
   [card_holder_first] [varchar](50) NULL,
   [card_holder_mi] [varchar](1) NULL,
   [card_holder_last] [varchar](50) NULL,
   [ins_relate_code] [varchar](4) NULL

   ,CONSTRAINT [aaaaaOut_PK] PRIMARY KEY NONCLUSTERED ([ID])
)


GO
