CREATE TABLE VendegMasked
(usernev nvarchar(40) MASKED with (Function = 'default()'),
nev nvarchar(100)	MASKED WITH (Function = 'partial(1,"XXX",1)'),
email nvarchar(120) MASKED WITH (function = 'email()'),
szaml_cim nvarchar(200) MASKED WITH (Function = 'default()'),
szul_dat date MASKED WITH (Function = 'default()'),
foglalas_pk int MASKED WITH (FUNCTION = 'random(1,5)')

)
INSERT INTO VendegMasked
SELECT v.*,
	f.FOGLALAS_PK --csak azért, hogy lehessen használni a randomot :-)
FROM Vendeg v JOIN Foglalas f ON v.USERNEV = f.UGYFEL_FK

CREATE USER MaskUser WITHOUT Login;
GRANT SELECT ON VendegMasked TO MaskUser

EXECUTE AS User= 'MaskUser';
SELECT * FROM VendegMasked
REVERT

