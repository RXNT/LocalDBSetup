CREATE TABLE [dbo].[manufacturedDrug] (
   [rxnt_mdid] [int] NOT NULL
      IDENTITY (1,1),
   [labelname] [varchar](35) NULL,
   [ndcs] [varchar](200) NULL,
   [labelerid] [varchar](6) NULL,
   [federallegendcode] [varchar](1) NULL,
   [genmfgcode] [varchar](1) NULL,
   [dispdrugid] [int] NULL,
   [dnid] [int] NULL,
   [rtid] [int] NULL,
   [dfid] [int] NULL,
   [strength] [varchar](15) NULL,
   [strengthunits] [varchar](15) NULL,
   [gpi] [varchar](14) NULL,
   [kdc] [varchar](10) NULL,
   [gcnseqno] [int] NULL,
   [rtgenid] [varchar](8) NULL,
   [hicl] [int] NULL,
   [genderspecificdrugcode] [varchar](1) NULL,
   [medicaldeviceind] [smallint] NULL

   ,CONSTRAINT [PK_manufacturedDrug] PRIMARY KEY CLUSTERED ([rxnt_mdid])
)


GO
