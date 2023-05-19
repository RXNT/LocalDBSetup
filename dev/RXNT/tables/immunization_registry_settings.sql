CREATE TABLE [dbo].[immunization_registry_settings] (
   [reg_id] [int] NOT NULL
      IDENTITY (1,1),
   [sending_facilityid] [varchar](25) NULL,
   [dg_id] [int] NULL,
   [entered_on] [datetime] NULL,
   [added_by] [bigint] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [Receving_FacilityId] [varchar](50) NULL,
   [Sending_Facility_Name] [varchar](50) NULL,
   [Receiving_Facility_Name] [varchar](50) NULL

   ,CONSTRAINT [PK__immuniza__740387725D591B74] PRIMARY KEY CLUSTERED ([reg_id])
)


GO
