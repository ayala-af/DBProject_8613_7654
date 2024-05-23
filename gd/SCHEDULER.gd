
[General]
Version=1

[Preferences]
Username=
Password=2582
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=AYALA
Name=SCHEDULER
Count=10

[Record]
Name=SC_TIME
Type=NUMBER
Size=5
Data=Random(13,22)
Master=

[Record]
Name=SC_DAY
Type=NUMBER
Size=5
Data=Random(1,7)
Master=

[Record]
Name=SCHEDULER_ID
Type=NUMBER
Size=5
Data=Sequence(1,1])
Master=

[Record]
Name=GROUP_ID
Type=NUMBER
Size=5
Data=Sequence(1,1])
Master=

[Record]
Name=WORKSHOP_ID
Type=NUMBER
Size=5
Data=Sequence(1,1])
Master=

[Record]
Name=ROOM_ID
Type=NUMBER
Size=5
Data=Random(1,10)
Master=

[Record]
Name=TEACHER_ID
Type=NUMBER
Size=5
Data=Random(1,10)
Master=

