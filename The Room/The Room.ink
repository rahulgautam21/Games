Its dark and cold, you find yourself in a creeky old bed in a room which appears to be a basement of a seemingly haunted house. You are distressed and scared.

You find a gun and and a flashlight
Choose one:
VAR gunJammed = true
VAR tvOn = false
VAR fileCabExplored = false
-> TheBasement
=== TheBasement ===
~ tvOn = false
~ fileCabExplored = false
+ "gun"
-> gun
+ "flashlight"
-> flashlight
=== gun === 
"You try to kill yourself"
{gunJammed: Gun is empty. | Gun is empty. You look into your pockets and find some bullets. Load them into the gun and you kill yourself -> END}
+"flashlight"
-> flashlight
=== flashlight ===
Roams around the room trying to find a way out
Sees blood markings saying its a trap and children names
flashlight scene. Follow flashlight find two rooms room 1 and room 2.
+"Enter Left Room"
-> leftRoom
+"Enter Right Room"
-> rightRoom
=== leftRoom ===
Something happens and he is captured and put to sleep again.
-> TheBasement
=== rightRoom ===
{not fileCabExplored and not tvOn : Notices old tv that is switched off and a file cabinet }
+ {not fileCabExplored} "Open file Cabinet"
-> fileCabinet
+ {not tvOn} "Try to fix TV"
-> tv
+ {tvOn and fileCabExplored} -> entry
=== fileCabinet ===
Open fileCabinet and read about file
~ fileCabExplored = true
+ "Search more"
-> bullets
+ "Go back"
-> rightRoom
=== bullets ===
~ gunJammed = false
finds box hidden with bullets and keeps them -> rightRoom
=== tv ===
Very carefully he tunes TV and sees news about experimental drug trials. expand..
~ tvOn = true
->rightRoom
=== entry ===
You explore more find a door and  a riddle.. expand here
Riddle goes here 
+ Option 1
-> guardsScene
+ Correct Answer
-> experimentalLab
=== experimentalLab ===
Explain experimental lab about chemicals test trials. Dead bodies of his family in tubes with cut body parts. You go down further suddenly you feel a beep and an alarm sets of with the bracelet on your ankle. Guards surround you.
+ "Run"
-> run
+ "Fight"
-> guardsScene
=== guardsScene === 
"Guards come and inject you" -> TheBasement
=== run ===
Describe a running sequence and then jump of the window and kill yourself -> ending
=== ending ===
-> END
