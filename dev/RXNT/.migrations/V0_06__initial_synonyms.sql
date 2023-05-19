CREATE SYNONYM [dbo].[RsynFaxFaxReceiveMessages] FOR [RxNTFax].[fax].[FaxReceiveMessages]
GO
CREATE SYNONYM [dbo].[RsynMasterAddressTypes] FOR [RxNTMaster].[cmn].[AddressTypes]
GO
CREATE SYNONYM [dbo].[RsynMasterApplications] FOR [RxNTMaster].[rxn].[Applications]
GO
CREATE SYNONYM [dbo].[RsynMasterCasePayers] FOR [RxNTMaster].[mst].[MasterCasePayers]
GO
CREATE SYNONYM [dbo].[RsynMasterCases] FOR [RxNTMaster].[mst].[MasterCases]
GO
CREATE SYNONYM [dbo].[RsynMasterCompanies] FOR [RxNTMaster].[mst].[Companies]
GO
CREATE SYNONYM [dbo].[RsynMasterCompanyExternalAppMaps] FOR [RxNTMaster].[mse].[CompanyExternalAppMaps]
GO
CREATE SYNONYM [dbo].[RsynMasterCompanyModuleAccess] FOR [RxNTMaster].[msa].[CompanyModuleAccess]
GO
CREATE SYNONYM [dbo].[RsynMasterCompanyTypes] FOR [RxNTMaster].[cmn].[CompanyTypes]
GO
CREATE SYNONYM [dbo].[RsynMasterCorporateClientCompanyMaps] FOR [RxNTMASTER].[mst].[CorporateClientCompanyMaps]
GO
CREATE SYNONYM [dbo].[RsynMasterDoctors] FOR [RxNTMaster].[mst].[Doctors]
GO
CREATE SYNONYM [dbo].[RsynMasterDoctorSpecialities] FOR [RxNTMaster].[mst].[DoctorSpecialities]
GO
CREATE SYNONYM [dbo].[RsynMasterGroupAddresses] FOR [RxNTMaster].[mst].[GroupAddresses]
GO
CREATE SYNONYM [dbo].[RsynMasterGroupExtendedInfo] FOR [RxNTMaster].[mst].[GroupExtendedInfo]
GO
CREATE SYNONYM [dbo].[RsynMasterGroupExternalAppMaps] FOR [RxNTMaster].[mse].[GroupExternalAppMaps]
GO
CREATE SYNONYM [dbo].[RsynMasterGroups] FOR [RxNTMaster].[mst].[Groups]
GO
CREATE SYNONYM [dbo].[RsynMasterLoginInfo] FOR [RxNTMaster].[mst].[LoginInfo]
GO
CREATE SYNONYM [dbo].[RsynMasterMasterPatientRelations] FOR [RxNTMaster].[mst].[MasterPatientRelations]
GO
CREATE SYNONYM [dbo].[RsynMasterPatientExternalAppMaps] FOR [RxNTMaster].[mse].[PatientExternalAppMaps]
GO
CREATE SYNONYM [dbo].[RsynMasterPatientIndexes] FOR [RxNTMaster].[mst].[MasterPatientIndexes]
GO
CREATE SYNONYM [dbo].[RsynMasterPatients] FOR [RxNTMaster].[mst].[MasterPatients]
GO
CREATE SYNONYM [dbo].[RsynMasterPersonAddress] FOR [RxNTMaster].[mst].[MasterPersonAddress]
GO
CREATE SYNONYM [dbo].[RsynMasterPersonInfo] FOR [RxNTMaster].[mst].[MasterPersonInfo]
GO
CREATE SYNONYM [dbo].[RsynMasterPersonRelationships] FOR [RxNTMaster].[cmn].[PersonRelationships]
GO
CREATE SYNONYM [dbo].[RsynMasterPersons] FOR [RxNTMaster].[mst].[MasterPersons]
GO
CREATE SYNONYM [dbo].[RsynMasterProviderRoles] FOR [RxNTMaster].[cmn].[ProviderRoles]
GO
CREATE SYNONYM [dbo].[RsynMasterSpecialityLookup] FOR [RxNTMaster].[cmn].[SpecialityLookup]
GO
CREATE SYNONYM [dbo].[RsynMasterStates] FOR [RxNTMaster].[cmn].[States]
GO
CREATE SYNONYM [dbo].[RsynMasterZipCodes] FOR [RxNTMaster].[cmn].[ZipCodes]
GO
CREATE SYNONYM [dbo].[RsynPMV2ApplicationTableConstants] FOR [RxNTPMV2].[rxn].[ApplicationTableConstants]
GO
CREATE SYNONYM [dbo].[RsynPMV2DoctorCompanies] FOR [RxNTPMV2].[epm].[DoctorCompanies]
GO
CREATE SYNONYM [dbo].[RsynPMV2Encounters] FOR [RxNTPMV2].[epm].[Encounters]
GO
CREATE SYNONYM [dbo].[RsynPMV2PatientExternalAppMaps] FOR [RxNTPMV2].[epm].[PatientExternalAppMaps]
GO
CREATE SYNONYM [dbo].[RsynPMV2PatientRelations] FOR [RxNTPMV2].[epm].[PatientRelations]
GO
CREATE SYNONYM [dbo].[RsynPMV2Patients] FOR [RxNTPMV2].[epm].[Patients]
GO
CREATE SYNONYM [dbo].[RsynPMV2PersonAddress] FOR [RxNTPMV2].[epm].[PersonAddress]
GO
CREATE SYNONYM [dbo].[RsynPMV2PersonInfo] FOR [RxNTPMV2].[epm].[PersonInfo]
GO
CREATE SYNONYM [dbo].[RsynPMV2Persons] FOR [RxNTPMV2].[epm].[Persons]
GO
CREATE SYNONYM [dbo].[RsynPMV2ProcedureCodes] FOR [RxNTPMV2].[pmc].[ProcedureCodes]
GO
CREATE SYNONYM [dbo].[RsynPMV2ZipCodes] FOR [RxNTPMV2].[pmc].[ZipCodes]
GO
CREATE SYNONYM [dbo].[RsynReportUtilsDocCompaniesAppInfo] FOR [RxNTReportUtils].[dbo].[docCompaniesAppInfo]
GO
CREATE SYNONYM [dbo].[RsynRxNTBillingCases] FOR [RxNTBilling]..[cases]
GO
CREATE SYNONYM [dbo].[RsynRxNTBillingEncounters] FOR [RxNTBilling].[dbo].[Encounters]
GO
CREATE SYNONYM [dbo].[RsynRxNTMasterApplicationsTable] FOR [RxNTMaster].[rxn].[Applications]
GO
CREATE SYNONYM [dbo].[RsynRxNTMasterCompaniesTable] FOR [RxNTMaster].[mst].[Companies]
GO
CREATE SYNONYM [dbo].[RsynRxNTMasterCompanyContactsTable] FOR [RxNTMaster].[cnt].[CompanyContacts]
GO
CREATE SYNONYM [dbo].[RsynRxNTMasterCompanyExternalAppMapsTable] FOR [RxNTMaster].[mse].[CompanyExternalAppMaps]
GO
CREATE SYNONYM [dbo].[RsynRxNTMasterInvoices] FOR [RxNTMaster].[lcn].[Invoices]
GO
CREATE SYNONYM [dbo].[RsynRxNTMasterInvoiceStatus] FOR [RxNTMaster].[cmn].[InvoiceStatus]
GO
CREATE SYNONYM [dbo].[RsynRxNTMasterInvoiceUserMapping] FOR [RxNTMaster].[lcn].[InvoiceUserMapping]
GO
CREATE SYNONYM [dbo].[RsynRxNTMasterLicenseTypes] FOR [RxNTMaster].[cmn].[LicenseTypes]
GO
CREATE SYNONYM [dbo].[RsynRxNTMasterLicensingProfiles] FOR [RxNTMaster].[lcn].[LicensingProfiles]
GO
CREATE SYNONYM [dbo].[RsynRxNTMasterLoginExternalAppMaps] FOR [RxNTMaster].[mse].[LoginExternalAppMaps]
GO
CREATE SYNONYM [dbo].[RsynRxNTMasterLogins] FOR [RxNTMaster].[mst].[Logins]
GO
CREATE SYNONYM [dbo].[RsynRxNTMasterReferringProviderExternalAppMapsTable] FOR [RxNTMaster].[mse].[MasterReferringProviderExternalAppMaps]
GO
CREATE SYNONYM [dbo].[RsynRxNTMasterStatesTable] FOR [RxNTMaster].[cmn].[States]
GO
CREATE SYNONYM [dbo].[RsynRxNTMasterUserLicenses] FOR [RxNTMaster].[lcn].[UserLicenses]
GO
CREATE SYNONYM [dbo].[RsynRxNTMasterZipcodesTable] FOR [RxNTMaster].[cmn].[ZipCodes]
GO
CREATE SYNONYM [dbo].[RsynSchedulerV2ApplicationTableConstants] FOR [RxNTSchedulerV2].[rxn].[ApplicationTableConstants]
GO
CREATE SYNONYM [dbo].[RsynSchedulerV2AppointmentNotes] FOR [RxNTSchedulerV2].[scl].[AppointmentNotes]
GO
CREATE SYNONYM [dbo].[RsynSchedulerV2Appointments] FOR [RxNTSchedulerV2].[scl].[Appointments]
GO
CREATE SYNONYM [dbo].[RsynSchedulerV2AppointmentStatusWorkflow] FOR [RxNTSchedulerV2].[scl].[AppointmentStatusWorkflow]
GO
CREATE SYNONYM [dbo].[RsynSchedulerV2CompanyAppointmentTemplates] FOR [RxNTSchedulerV2].[scl].[CompanyAppointmentTemplates]
GO
CREATE SYNONYM [dbo].[RsynSchedulerV2MasterAppRoles] FOR [RxNTSchedulerV2].[scl].[MasterAppRoles]
GO
CREATE SYNONYM [dbo].[RsynSchedulerV2MaterialResources] FOR [RxNTSchedulerV2].[scl].[MaterialResources]
GO
CREATE SYNONYM [dbo].[RsynSchedulerV2PersonResourceAppointmentSchedules] FOR [RxNTSchedulerV2].[scl].[PersonResourceAppointmentSchedules]
GO
CREATE SYNONYM [dbo].[RsynSchedulerV2PersonResources] FOR [RxNTSchedulerV2].[scl].[PersonResources]
GO
CREATE SYNONYM [dbo].[RsynSchedulerV2vwAppLogins] FOR [RxNTSchedulerV2].[scv].[vwAppLogins]
GO
CREATE SYNONYM [dbo].[RsynSchedulerV2vwDoctorGroups] FOR [RxNTSchedulerV2].[scv].[vwDoctorGroups]
GO
CREATE SYNONYM [dbo].[RsynSchedulerV2vwPatientIndexes] FOR [RxNTSchedulerV2].[scv].[vwPatientIndexes]
GO
CREATE SYNONYM [dbo].[RsynSchedulerV2vwPatients] FOR [RxNTSchedulerV2].[scv].[vwPatients]
GO
CREATE SYNONYM [dbo].[RsynSchedulerV2vwPersons] FOR [RxNTSchedulerV2].[scv].[vwPersons]
GO
CREATE SYNONYM [dbo].[synMasterAddressTypes] FOR [RxNTMaster].[cmn].[AddressTypes]
GO
CREATE SYNONYM [dbo].[synMasterApplications] FOR [RxNTMaster].[rxn].[Applications]
GO
CREATE SYNONYM [dbo].[synMasterCompanies] FOR [RxNTMaster].[mst].[Companies]
GO
CREATE SYNONYM [dbo].[synMasterCompanyExternalAppMaps] FOR [RxNTMaster].[mse].[CompanyExternalAppMaps]
GO
CREATE SYNONYM [dbo].[synMasterCompanyModuleAccess] FOR [RxNTMaster].[msa].[CompanyModuleAccess]
GO
CREATE SYNONYM [dbo].[synMasterCompanyTypes] FOR [RxNTMaster].[cmn].[CompanyTypes]
GO
CREATE SYNONYM [dbo].[synMasterLoginInfo] FOR [RxNTMaster].[mst].[LoginInfo]
GO
CREATE SYNONYM [dbo].[synMasterMasterPatientRelations] FOR [RxNTMaster].[mst].[MasterPatientRelations]
GO
CREATE SYNONYM [dbo].[synMasterPatientExternalAppMaps] FOR [RxNTMaster].[mse].[PatientExternalAppMaps]
GO
CREATE SYNONYM [dbo].[synMasterPatients] FOR [RxNTMaster].[mst].[MasterPatients]
GO
CREATE SYNONYM [dbo].[synMasterPersonAddress] FOR [RxNTMaster].[mst].[MasterPersonAddress]
GO
CREATE SYNONYM [dbo].[synMasterPersonInfo] FOR [RxNTMaster].[mst].[MasterPersonInfo]
GO
CREATE SYNONYM [dbo].[synMasterPersonRelationships] FOR [RxNTMaster].[cmn].[PersonRelationships]
GO
CREATE SYNONYM [dbo].[synMasterPersons] FOR [RxNTMaster].[mst].[MasterPersons]
GO
CREATE SYNONYM [dbo].[synMasterStates] FOR [RxNTMaster].[cmn].[States]
GO
CREATE SYNONYM [dbo].[synMasterZipCodes] FOR [RxNTMaster].[cmn].[ZipCodes]
GO
CREATE SYNONYM [dbo].[synPMV2ApplicationTableConstants] FOR [RxNTPMV2].[rxn].[ApplicationTableConstants]
GO
CREATE SYNONYM [dbo].[synPMV2DoctorCompanies] FOR [RxNTPMV2].[epm].[DoctorCompanies]
GO
CREATE SYNONYM [dbo].[synPMV2Encounters] FOR [RxNTPMV2].[epm].[Encounters]
GO
CREATE SYNONYM [dbo].[synPMV2PatientExternalAppMaps] FOR [RxNTPMV2].[epm].[PatientExternalAppMaps]
GO
CREATE SYNONYM [dbo].[synPMV2PatientRelations] FOR [RxNTPMV2].[epm].[PatientRelations]
GO
CREATE SYNONYM [dbo].[synPMV2Patients] FOR [RxNTPMV2].[epm].[Patients]
GO
CREATE SYNONYM [dbo].[synPMV2PersonAddress] FOR [RxNTPMV2].[epm].[PersonAddress]
GO
CREATE SYNONYM [dbo].[synPMV2PersonInfo] FOR [RxNTPMV2].[epm].[PersonInfo]
GO
CREATE SYNONYM [dbo].[synPMV2Persons] FOR [RxNTPMV2].[epm].[Persons]
GO
CREATE SYNONYM [dbo].[synPMV2ZipCodes] FOR [RxNTPMV2].[pmc].[ZipCodes]
GO
CREATE SYNONYM [dbo].[synRxNTBillingCases] FOR [RxNTBilling]..[cases]
GO
CREATE SYNONYM [dbo].[synRxNTBillingEncounters] FOR [RxNTBilling].[dbo].[Encounters]
GO
CREATE SYNONYM [dbo].[synRxNTMasterApplicationsTable] FOR [RxNTMASTER].[rxn].[Applications]
GO
CREATE SYNONYM [dbo].[synRxNTMasterCompaniesTable] FOR [RxNTMASTER].[mst].[Companies]
GO
CREATE SYNONYM [dbo].[synRxNTMasterCompanyContactsTable] FOR [RxNTMASTER].[cnt].[CompanyContacts]
GO
CREATE SYNONYM [dbo].[synRxNTMasterCompanyExternalAppMapsTable] FOR [RxNTMASTER].[mse].[CompanyExternalAppMaps]
GO
CREATE SYNONYM [dbo].[synRxNTMasterInvoices] FOR [RxNTMASTER].[lcn].[Invoices]
GO
CREATE SYNONYM [dbo].[synRxNTMasterInvoiceStatus] FOR [RxNTMASTER].[cmn].[InvoiceStatus]
GO
CREATE SYNONYM [dbo].[synRxNTMasterInvoiceUserMapping] FOR [RxNTMaster].[lcn].[InvoiceUserMapping]
GO
CREATE SYNONYM [dbo].[synRxNTMasterLicenseTypes] FOR [RxNTMaster].[cmn].[LicenseTypes]
GO
CREATE SYNONYM [dbo].[synRxNTMasterLoginExternalAppMaps] FOR [RxNTMaster].[mse].[LoginExternalAppMaps]
GO
CREATE SYNONYM [dbo].[synRxNTMasterLogins] FOR [RxNTMaster].[mst].[Logins]
GO
CREATE SYNONYM [dbo].[synRxNTMasterReferringProviderExternalAppMapsTable] FOR [RxNTMASTER].[mse].[MasterReferringProviderExternalAppMaps]
GO
CREATE SYNONYM [dbo].[synRxNTMasterStatesTable] FOR [RxNTMASTER].[cmn].[States]
GO
CREATE SYNONYM [dbo].[synRxNTMasterUserLicenses] FOR [RxNTMaster].[lcn].[UserLicenses]
GO
CREATE SYNONYM [dbo].[synRxNTMasterZipcodesTable] FOR [RxNTMASTER].[cmn].[ZipCodes]
GO
