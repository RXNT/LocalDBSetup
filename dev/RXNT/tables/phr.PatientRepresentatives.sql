CREATE TABLE [phr].[PatientRepresentatives] (
   [PatientRepresentativeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PatientId] [bigint] NOT NULL,
   [PersonRelationshipId] [bigint] NOT NULL,
   [FirstName] [varchar](50) NOT NULL,
   [MiddleInitial] [varchar](50) NULL,
   [LastName] [varchar](61) NOT NULL,
   [Sex] [varchar](3) NOT NULL,
   [DOB] [datetime2] NOT NULL,
   [MaritalStatusId] [bigint] NULL,
   [HomePhone] [varchar](20) NULL,
   [CellPhone] [varchar](20) NULL,
   [WorkPhone] [varchar](20) NULL,
   [OtherPhone] [varchar](20) NULL,
   [PhonePreferenceTypeId] [bigint] NULL,
   [Email] [varchar](80) NOT NULL,
   [Fax] [varchar](20) NULL,
   [Address1] [varchar](100) NOT NULL,
   [Address2] [varchar](100) NULL,
   [CityId] [bigint] NOT NULL,
   [StateId] [bigint] NOT NULL,
   [ZipCode] [varchar](5) NOT NULL,
   [ZipExtension] [varchar](4) NULL,
   [PasswordExpiryDate] [datetime2] NOT NULL,
   [Active] [bit] NOT NULL,
   [CreatedDate] [datetime2] NOT NULL,
   [CreatedBy] [bigint] NOT NULL,
   [ModifiedDate] [datetime2] NULL,
   [ModifiedBy] [bigint] NULL,
   [InactivatedDate] [datetime2] NULL,
   [InactivatedBy] [bigint] NULL,
   [Concurrency] [timestamp] NOT NULL,
   [accepted_terms_date] [datetime] NULL

   ,CONSTRAINT [PK_PatientRepresentatives] PRIMARY KEY CLUSTERED ([PatientRepresentativeId])
)


GO
