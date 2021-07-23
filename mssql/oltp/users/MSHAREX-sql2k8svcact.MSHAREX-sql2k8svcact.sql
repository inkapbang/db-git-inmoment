CREATE USER [MSHAREX\sql2k8svcact] WITHOUT LOGIN WITH DEFAULT_SCHEMA = [MSHAREX\sql2k8svcact]
/*ALTER ROLE MSReplPAL_6_1 ADD MEMBER MSHAREX\sql2k8svcact*/ exec sp_addrolemember 'MSReplPAL_6_1', 'MSHAREX\sql2k8svcact'
/*ALTER ROLE MSReplPAL_8_1 ADD MEMBER MSHAREX\sql2k8svcact*/ exec sp_addrolemember 'MSReplPAL_8_1', 'MSHAREX\sql2k8svcact'
GO
