CREATE TABLE [dbo].[InsuranceServiceTypes] (
   [InsuranceServiceTypeId] [int] NOT NULL
      IDENTITY (1,1),
   [Code] [varchar](10) NOT NULL,
   [Definition] [varchar](50) NOT NULL,
   [CreatedDate] [datetime] NOT NULL,
   [UpdatedDate] [datetime] NULL

   ,CONSTRAINT [PK_InsuranceServiceTypes] PRIMARY KEY CLUSTERED ([InsuranceServiceTypeId])
)


GO
