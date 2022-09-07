"What is this place?" 
"Where am I and why does my head ache so much?"

You find yourself waking up on a blood-stained, creeky old bed in a bleak, cold, and completely dark room which appears to be a basement of a seemingly haunted house. 
You step out of the bed and feel a chill as the darkness engulfs you. Taking some timid steps in the utter darkness you collide with a table that has a flashlight and a gun.

Choose one:

VAR gunJammed = true
VAR tvOn = false
VAR fileCabExplored = false
-> TheBasement
=== TheBasement ===
~ tvOn = false
~ fileCabExplored = false
+ "Try to kill yourself with the gun!"
-> gun
+ "Try to turn on the flashlight and look around"
-> flashlight
=== gun === 
"BBBBRRRRRRRRRRRRRRRTTTTTTTTTTT. *Empty click*"
{gunJammed: The gun is empty.| Gun is empty. You look into your pockets and find some bullets. Load them into the gun and you kill yourself -> END}
+"Try to turn on the flashlight and look around"
-> flashlight
=== flashlight ===
You point your flashlight to the walls try to look for a light switch. Chills run down your spine as you see the blood-writings on the wall!!
"IT'S A TRAP!! STUCK HERE FOREVER....!!!"
"YOUR CHILDREN WAIT FOR YOU!! THEY HAVE HER!!"
and,
"TRUST ME, DON'T LEAVE!! THEY'LL KILL YOu....."

Horror-struck, you try to pace away from the wall while comprehending the meaning of those warnings and stumble across two doors.

Choose one:

+"Open the left door"
-> leftRoom
+"Open the right door"
-> rightRoom
=== leftRoom ===
"Who are you? Why am I here?"
"I want to go home!!!"
"No No No, what is in this injection? What are guys doing to mee??" 
"Please don't do this!!" 
"I want to go ho..."

Everything around you is blurry and you feel that qaint numbness around you as you close your eyes.
Days later, you wake up again on the same bed in the bleak and dark room and find a gun and flashlight lying on the floor.
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
