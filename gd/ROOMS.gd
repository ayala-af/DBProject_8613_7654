
[General]
Version=1

[Preferences]
Username=
Password=2274
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=AYALA
Name=ROOMS
Count=500

[Record]
Name=ROOM_ID
Type=NUMBER
Size=5
Data=Sequence(11,1)
Master=

[Record]
Name=ROOM_FLOOR
Type=NUMBER
Size=5
Data=Random(0,4)
Master=

[Record]
Name=ISSTUDIO
Type=CHAR
Size=1
Data=List('F,'T') 
Master=

[Record]
Name=ROOM_CAPACITY
Type=NUMBER
Size=5
Data=Random(4,40)
Master=

