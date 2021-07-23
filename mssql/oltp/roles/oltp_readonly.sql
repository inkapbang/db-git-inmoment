CREATE ROLE [oltp_readonly]
GO

GRANT SELECT ON SCHEMA::[dbo] TO [oltp_readonly]

GO
