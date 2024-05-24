
[General]
Version=1

[Preferences]
Username=
Password=2113
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=AYALA
Name=CLIENTS
Count=500

[Record]
Name=CLIENT_ID
Type=NUMBER
Size=5
Data=Sequence(11,1)
Master=

[Record]
Name=CLIENT_FNAME
Type=VARCHAR2
Size=15
Data=FirstName
Master=

[Record]
Name=CLIENT_LNAME
Type=VARCHAR2
Size=15
Data=LastName
Master=

[Record]
Name=CLIENT_ADDR
Type=NUMBER
Size=5
Data=Random(1,400)
Master=

[Record]
Name=CLIENT_TEL
Type=NUMBER
Size=5
Data=Random(10000,99999)
Master=

[Record]
Name=CLIENT_PAYMENT
Type=NUMBER
Size=5
Data=Random(150,400)
Master=

[Record]
Name=BIRTHDAY
Type=DATE
Size=
Data=Random(1.1.1924,1.1.2021)
Master=

