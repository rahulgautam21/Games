You find yourself waking up on a blood-stained, creeky old bed in a bleak, cold, and completely dark room which appears to be a basement of a seemingly haunted house. 

"What is this place?" 
"Where am I and why does my head ache so much?"

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
"YOUR CHILDREN WAIT FOR YOU!! THEY HAVE M!!"
and,
"TRUST ME, DON'T LEAVE!! THEY'LL KILL YOu....."

Horror-struck, you try to pace away from the wall while comprehending the meaning of those warnings and stumble across two doors.

Choose one:

+"Open the left door"
-> leftRoom
+"Open the right door"
-> rightRoom
=== leftRoom ===
As soon as the door opens you see someone standing right in front of you and you shout:
"WHO ARE YOU?! And Why am I here? What is this place ?!"
The man doesn't move a muscle and continues to stare at you in a scary way, you beg him:
"I want to go home!!!"
But then you see he starts taking out an injection from his pocket you plead him to let you go:
"No No No, what is in this injection? What are guys doing to me??" 
"Please don't do this!!" 
"I want to go home"

And then, after a mild struggle he injects you. Everything around you is blurry and you feel that qaint numbness around you as you close your eyes.
Days later, you wake up again on the same bed in the bleak and dark room and find a gun and flashlight lying on the floor.
-> TheBasement
=== rightRoom ===
{not fileCabExplored and not tvOn : The door opens with a loud creak. "What is this place, why does it stink so much?" You enter the room, point your flashlight towards the walls and immediately jump back startled; there's scribbling all overr the walls and it seems as if it was painted in fresh blood. Once you calm yourself, you notice an old television set that is flickering in the background and a file cabinet covered in dust and cowebs in the corner of the room. You wonder what could that be linked to. You decide to look for clues: }
+ {not fileCabExplored} "Open file Cabinet"
-> fileCabinet
+ {not tvOn} "Try to tune TV and see what's playing"
-> tv
+ {tvOn and fileCabExplored} -> entry
=== fileCabinet ===
"How do I open this jammed file cabinet?!"

After grunting and heaving, you finally manage to wrench open the cabinet drawer. There are stacks of files inside the drawer, and you haphazardly go through them to find some information about what this place is. Suddenly you stumble upon a file that has your name on it. Stunned, you immediately drop the file and take a minute to gather your nerves. With trembling hands, you pick up the file again. As you peruse through the file you find information about you and your family. You also find pictures of yourself being administered some sort of inections.

Dumb-struck you question yourself.

"Is this a dream or am I going insane?!"
"Why is all my information present in this file?"
"Why do they know everything about me?"
"Why am I being administered drugs?"
"What is happening to me?"

Holding your head in your hands, you stumble across the room trying to make sense of what is happening to you.

You catch a glimpse of a rusty old box sitting back in the cabinet drawer and you are scared to even open it.

Choose one:
~ fileCabExplored = true
+ "Search more"
-> bullets
+ "Go back"
-> rightRoom
=== bullets ===
~ gunJammed = false
As soon as you open the rusty old box, a jolt of lightening goes through you as you see a box of bullets. 
"Wouldn't hurt to have a couple of bullets!!"

Given the circumstances, you decide to pick them up.

In search for more answers, you direct yourself towards the flickering TV.
-> rightRoom
=== tv ===
Very carefully he tunes the TV and sees news about experimental drug trials. expand..
You walk across the room toward the TV and try tuning it. There is a small antena on the top of the television, and you fiddle around with it. Finally, you hear some noise from the TV and on the screen, you see a doctor working on a patient. The patient seems in a lot of pain, and finally the doctor thrusts a needle in the patient's neck. More than curing the patient, the doctor looked like he was manhandling the patient. You start walking away from the screen, but suddenly something catches your eye. The patient had a ring on his index finger, similar to the ring you're wearing and with a start you realize you've been watching yourself being administered some injection on the television. 

"I need to get out of this place and see my family!"
"I hope they are safe!"
"Please god! Give me a clue!! Something!! I need to get out of this place"

~ tvOn = true
->rightRoom
=== entry ===
With trembling hands, you decide to move around the room and explore a way out! And a ray of hope appears as you see a metal door in distance. You rush towards that door and try to open it.
"Damn! It's locked!!"
"How do I open it?"

You see a keypad next to the door and reckon that it is password protected. 

You flash your flashlight around the door in order to find something and you are unfortunate to find any clue.

"How do I open it??" You cry as you accidentaly point your flashlight towards the ceiling.

Stupified, you see a blood writing saying:

"I was carried into a dark room, and set on fire. I wept, and then my head was cut off. What am I?"
 
+ CANDLE
-> guardsScene
+ MARIA
-> experimentalLab
=== experimentalLab ===
Explain experimental lab about chemicals test trials. Dead bodies of his family in tubes with cut body parts. You go down further suddenly you feel a beep and an alarm sets of with the bracelet on your ankle. Guards surround you.

The keypad beeps twice and then turns green. The door swings open and you find yourself in a laboratory. It is pitch black inside, so you turn on your flashlight. To your dismay, the torch starts flickering and a very feeble light emerges from it.

"Damn, I don't have much time left. At this rate, my torch will die out in a couple of minutes."

Reassuring himself, he walks in a more determined manner to explore the insides of the laboratory. Time is not on his side. 

There are vials all over the place, it looks like the place had been ransacked. There was a weird odor all over the place, probably a result of all the broken vials on the floor. Some of the vials were even emitting a ghastly light from within. Keeping your hands to yourself, you stumble across the lab trying to make sense of what the place is and how you can escape. As you make your way across the lab, you see a large tube that is spewing a white colored gas. Intrigued you walk towards it, not knowing that that tube would spell your doom.

Inching closer to the tube, you see the backside of the tube is made of glass. You squint inside and almost faint. There are three corpses inside the tube, badly scarred and tortured. The body parts float in some kind of liquid inside the tube, and you turn around and throw up in disgust. Suddenly, you notice a familiar bracelet on the floating hands and chills run down your spine. You are scared to even turn around but gather some strength to face the daunting reality.

"NOOOO!!!"
 You sink down on your knees wailing uncontrollably. The scream of your cries travel everywhere.
 
 "What have they done??""
 "My life, My children, My love"
 "Please NOOO"
 "MARIA NOOOOOO!!! Please comebackk!!"
 
 An alarm starts to beep, some gaurds starts approachingtowards you and you decide to run or fight!!
+ "Run"
-> run
+ "Fight"
-> guardsScene2
=== guardsScene === 
"The sound of sirens surround you. You turn around and see an army of guards. You feel a pinch on your neck and recognise that you have been shot with a dark. You feel drowsy and fall into a deep sleep. Days later, you wake up again on the same bed in the bleak and dark room and find a gun and flashlight lying on the floor." -> TheBasement
=== guardsScene2 === 
"You are surrounded by 3 guards. You decide to fight. You hit one in the head but the other two hold you down. The first guard gets up and punches you in the face. The second one kicks you from behind and you are forced down upon your knees. While two of the guards have your hands held behind your back, the third guard grabs you by your hair. With an evil grin, he takes out an injection and injects you in the neck. Days later, you wake up again on the same bed in the bleak and dark room and find a gun and flashlight lying on the floor." -> TheBasement
=== run ===
You realize there is no meaning to life given that your family is all dead. You decide its a time to end this madness and run frantically towards the window. The guards start shooting. You get up the balcony with blood flowing through the holes in your bullet ridden body and jump of the window and kill yourself -> ending
=== ending ===
-> END
