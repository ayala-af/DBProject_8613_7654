
[General]
Version=1

[Preferences]
Username=
Password=2014
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=AYALA
Name=TEACHERS
Count=500

[Record]
Name=TEACHER_ID
Type=NUMBER
Size=5
Data=Sequence(11,1)
Master=

[Record]
Name=TEACHER_FNAME
Type=VARCHAR2
Size=15
Data=FirstName
Master=

[Record]
Name=TEACHER_LNAME
Type=VARCHAR2
Size=15
Data=LastName
Master=

[Record]
Name=TEACHER_ADDR
Type=NUMBER
Size=5
Data=Random(1,400)
Master=

[Record]
Name=TEACHER_TEL
Type=NUMBER
Size=5
Data=Random(10000, 99999) 
Master=

[Record]
Name=TEACHER_SALARY
Type=NUMBER
Size=5
Data=Random(8000, 20000) 
Master=

[Record]
Name=TEACHER_JOIN_DATE
Type=DATE
Size=
Data=Random(1.1.1950,1.1.2000)
Master=

