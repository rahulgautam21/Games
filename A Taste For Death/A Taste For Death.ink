You respond to a 911 call reporting a suspected homicide at 32 Wall Street. When you walk in, there are five people gathered in the kichen around the body of Kevin Conner, a multimillionaire and the founder and President of the popular music software company "BeatsGoUpNDown." Being a well-known celebrity, it is crucial to identify the reason for and person(s) responsible for this horrific wrongdoing.

After carefully examining Kevin's body, you notice blue coloring around this throat and foam around his mouth. You take samples from his mouth and ask your partner to send them for forensic analyis at the lab.
Meanwhile, you attempt to question each suspect, you request that they all remain in the penthouse. Each suspect is segregated in a unique portion of the home.

VAR knowAboutClintAndWanda = false
VAR clintRelationshipAsked = false
VAR clintIntro = false
VAR wandaIntro = false
VAR moves = 0
VAR labResults = false
VAR knowNatashaStoleDrugs = false
VAR tonyDrugs = false

-> Options

=== Options === 
 * [Interrogate Business Partner Tony] -> TonyIntro
 * [Interrogate House-Keeper Natasha] -> NatashaIntro
 * [Interrogate VP Steve] -> SteveIntro
 * [Interrogate Dr. Clint] -> ClintIntro
 * [Interrogate Mrs. Wanda] -> WandaIntro
 * [Go inside Kevin's room] -> Room
 * {knowAboutClintAndWanda and clintIntro} [Confront Clint about relationship with Wanda] -> ClintAnsToRelationship
 * {knowAboutClintAndWanda and wandaIntro} [Confront Wanda about relationship with Clint] -> WandaAnsToRelationship
 * {moves > 7} [Analyze Lab Reports] -> Labreport
 * {moves > 7} [Choose the culprit] -> Culprit
 * {labResults} [Ask Dr. Clint about who had access to drugs] -> AskDoctor
 * {knowNatashaStoleDrugs} [Confront Natasha about the Cynide] -> ConfrontNatasha
 * {tonyDrugs} [Confront Tony about the drugs] -> ConfrontTony
 
 
=== TonyIntro === 
~ moves = moves + 1
You approach Tony in the hope of information about this murder. Tony is dressed in an Armani suit with a Rolex watch. (You think maybe there is some friction between the co-founders which could be the motive behind this homicide) You ask Tony how he came about Kevin's dead body and if he suspects someone. <br><br> Tony: We were all celeberating the recent series B fundraising and having a small get together. I was on a call with one of our investors in the balcony when I heard the housekeeper Natasha scream and ran inside and saw my dear friend lying dead inside. I asked Dr. Clint to look into it and it was I who called 911. To be very honest I do not suspect anyone as this is a very close group and we trust each other a lot. Kevin did speak to me about feeling uneasy before the party but I assumed it was just fatigue. <br> <br> You: Hmm... It's sad that the world has lost such an innovato.. <br> <br> Tony (Interepting): HE WAS NO INNOVATOR!! IT WAS ALL MY BRAIN CHILD!! HE STOLE MY IDEA!! I'm sorry I acted out of aggression but I grieve the passing of Kevin. Irrespective of our differences, he handled the company really well and everyone loved him for that. <br> <br> You: So you will now receive all of his shares, correct? Please correct me if I'm wrong, but you are now the company's new founder and owner. Well, this murder is advantageous to someone. <br><br> Tony: Let's just say when god closes a door, he also opens a window! I believe that as the owner of this business, I will now have to shoulder its load and duty. Furthermore, in my opinion, this company's future would be safer in more capable hands, and I believe he wasn't qualified to guide us into the future. <br><br> You: Hmm..Interesting...
-> Options

=== NatashaIntro === 
~ moves = moves + 1
You approach Natasha the house-keeper. She is weeping uncontrollably. You make an effort to comfort her and inquire about her suspicions and how she came to learn about Kevin's passing. <br><br> Natasha: So, I was walking to the wine cellar to get more wine for Dr. Clint when I noticed Kevin on the ground. I panicked and screamed for help. He wasn't responding when I moved his head in an attempt to wake him up. Then Dr. Clint arrived and attempted to revive him, but it was too late. <br><br> You: I see... I am however, more interested in you. You are his housekeeper, therefore you would undoubtedly be aware of any concerns or recent stress he may be experiencing. You got to know something. <br><br> Natasha: Well, during the past few days, Kevin started arriving late from work. He worried most of the time he was by himself on the patio. Still, that's it. I just know that. <br><br> You: Alright. What did he consume for supper? I need a detailed account of everything he ate today. <br><br> Natasha: He was very peculiar about his food and had Pancakes with AppleSauce as breakfast and usually used to dine out in the evening. You ask your partner to send the applesauce to the laboratory as well for testing. <br><br> You: Apart from you who all had access to the house? <br><br> Natasha : Apart from me only Mrs Wanda, Kevin's wife had access to the apartment.
-> Options

=== ClintIntro ===
~ moves = moves + 1
~ clintIntro = true
You approach Dr. Clint the doctor who first checked on Kevin. You enquire as to Dr. Clint's suspicions and his background. You: How long have you known Kevin.  <br><br> Dr. Clint: I have known Kevin for around 5 years know and I am his personal physician. <br><br> You: Do you find anything suspicious about his death. <br><br> Dr. Clint: When I heard Natasha's scream I rushed to the room to find Kevin on the floor. I did not suspect poisoning as his conditions resembled more like a heart attack.
-> Options

=== SteveIntro ===
~ moves = moves + 1
You approach Steve the vice-president of the company. You ask him if he has any suspicions. <br><br> Steve: Although I do not have any suspicions and I am deeply saddened by the death of Kevin however there have been some ...disagreements between Kevin and the co-founder Tony regarding the ownership. However, I do not think that Tony would take such extreme steps. <br><br> You: Will you not be promoted to President since now Kevin is dead. <br><br> Steve: I will be (with a grim smile)... hopefully. However I do not beleive that the company would be the same without his charm and vision.
-> Options

=== WandaIntro ===
~ moves = moves + 1
~ wandaIntro = true
You approach Wanda (Kevin's wife) and enquire as to Wanda's suspicions and her background. She looks surprisingly calm for someone whose husband just died. <br><br> Wanda: Well to be very honest I think Natasha did it since and I secretely think that she and my husband were having an affair. I confronted them about it but they blatanly denied it. Also, she is the only one with access to the apartment apart from me.
-> Options

=== Room === 
~ moves = moves + 1
You go inside Kevin's room and start opening up the wardrobes and dresser. In the dresser's drawer you find a photo of Wanda and Clint kissing.
~ knowAboutClintAndWanda = true
-> Options

=== ClintAnsToRelationship === 
~ moves = moves + 1
You confront Clint and show him the picture and ask him about it. Clint seems taken back with the photo and tries to composes himself. <br>
Clint: Well I'll be honest Wanda was my crush since we attended the same pre-med college. Recently, she approached me if I was interested in her and being out of a messy breakup I obviously said yes and we have been dating ever since. However, this is the first time I met Kevin in person. 
-> Options

=== WandaAnsToRelationship === 
~ moves = moves + 1
You confront Wanda and show her the picture and ask her about it given that she is married to Kevin. She still maintains her calm posture. <br>
Wanda: For a while I have known Kevin has been cheating on me first with his secretary from office and now I believe it is Natasha. Clint is just a fling I am having. I made sure Kevin knew that I was meeting Clint just to make him feel what I feel.  
-> Options

=== Labreport === 
~ moves = moves + 1
~ labResults = true
Your partner brings up the lab reports. On analyzing them you see that Kevin was actually poisined with Acetonitrile which converts into cynide upon inhalation or ingestion. However, to your surprise the AppleSauce is free of any toxins. That means that the culprit had access to a hospital containing Acetonitrile.
-> Options

=== AskDoctor ===
~ moves = moves + 1
~ knowNatashaStoleDrugs = true
You inform the doctor about Kevin's death from cynide poisoning and point it out that it is only he who had access to the drugs and he turns pale and starts to fumble.
Dr Clint: I-Ii-Ii am innocent I swear to god. I know based on the evidence it will point to me as the killer but its not me. 
Dr Clint: Well apart from me Natasha also used to visit me regularly to pickup drugs from the hospital for Kevin for treating his heart condition. I dont know how but maybe she got access to the drugs. 
You: But what motive could Natasha have for killing Kevin.
Dr Clint: I do not know that but recently I saw her spend a lot of time with Tony in the apartment.
-> Options

=== LieToNatasha === 
~ tonyDrugs = true
Natasha starts moving about haphazardly through the room. She decides to talk then stops. Then walks about again. Finally, she stops takes a big sigh and starts speaking.
Natasha: I have nothing to do with the crime. I admit that I did steal some drugs but that is because Tony asked me to steal some drugs for him. I do not know what the drugs do and only stole it since he paid me a lot of money to do it. I thought they were for recreational purposes. I never knew that that they were connected to the crime. Are they? 
You: I think they are but lets wait and see. You can go back to the dining room.
-> Options

=== AskNatashaAboutDrugs
Natasha: Is that what he told you? You should never trust anything that comes out of his mouth. He himself has been having an affair with Mrs. Wanda and he would have told you instead that I was having an affair with Kevin or Tony. He thinks of me as a gold digger and does not spare any opportunity to scandalize me.
-> Options

=== ConfrontNatasha ===
~ moves = moves + 1
* Lie to Natasha that Dr Clint has CCTV footage of her stealing drugs -> LieToNatasha
* Ask if she has been stealing drugs from Dr Clint -> AskNatashaAboutDrugs

=== ConfrontTony ===
~ moves = moves + 1
You: Tony, over my 35-year career as a detective, I have witnessed many people drown in their own thirst for money, but I have never witnessed someone sink so low! I know you and Kevin have had your disagreements over the years, but planning a murder? Tell me right now, honestly, why you did it?

Tony: Are you insane? I just told you at the start that I am innocent. Why would I kill him? If I did the crime why would I call 911.

-> Options

=== Culprit === 
 * [Business Partner Tony] -> Win
 * [House-Keeper Natasha] -> Lose
 * [VP Steve] -> Lose
 * [Dr. Clint] -> Lose
 * [Mrs. Wanda] -> Lose

=== Win ===

You: CUT THE CRAP TONY!! I KNOWW!! I KNOWW how you lured that innocent girl to aid you into this heinuous crime!! I've got you dead to rights!! NOW TELL ME THE TRUTH and ONLY BUT THE TRUTH!!!

Tony: Okay Okay I confess... I confess that it was me who told Natasha to steal the poison from Dr. Clint's office and sprinkled some Acetonitrile into his wine glass. It was me who planned all this. And why wouldn't I? He stole everything from me!! Everything!! It was I who created this application and he stole all the credit. Whenever I used to see his photograph on the business magazines it would boil my blood. Morever, this series B funding that everyone thinks Kevin brought to the table, IT WAS MY HARDWORK, I gave up everything for this company and seeing him climbing the ladders of success would infuriate me!! I am glad that he is dead. May he rot in the hells!!

You: ENOUGH!! I am taking you in!!

You were able to successfully guess the culprit in {moves} moves.
-> Ending

=== Lose ===
Even after {moves} moves you were not able to successfully guess the culprit.
-> Ending

=== Ending === 
-> END
