//
//  SwiftUIViewGame.swift
//  Final Project
//
//  Created by Alistair on 9/15/21.
//

import SwiftUI
import Foundation

struct SwiftUIViewGame: View {
    let characterName : String
    let characterPic : String
    @State private var screenCounter = 0;
    @State private var titleText = ""
    @State private var bodyText = ""
    @State private var choice1 = ""
    @State private var choice2 = ""
    @State private var choicePath = ""
    @State private var disableChoice1 = false
    @State private var disableChoice2 = false
    @State private var trophy1 = false
    @State private var trophy2 = false
    @State private var trophy3 = false
    @State private var trophy4 = false
    @State private var trophy5 = false
    @State private var trophy6 = false
    @State private var trophy7 = false
    @State private var trophy8 = false
    @State private var triggerTrophy = false
    @State private var rotation = 0.0
    @State private var finishedPaths = 0
    @State private var goodEndings = 0
    @State private var badEndings = 0
    @State private var finishedPathsList = [String]()
    var body: some View {
        NavigationView {
            VStack{
                //the top bit of screen with username and pic
                HStack{
                    NavigationLink("Achievements", destination: SwiftUIViewAchievements(trophy: HasAchievements(trophy1: trophy1, trophy2: trophy2, trophy3: trophy3, trophy4: trophy4, trophy5: trophy5, trophy6: trophy6, trophy7: trophy7, trophy8: trophy8)))
                        .padding()
                    Spacer()
                    CustomText(text: "\(characterName)")
                        .frame(height: 50, alignment: .topLeading)
                    Image(triggerTrophy ? "trophy 1" : characterPic)
                        .resizable()
                        .frame(width: 50, height: 50, alignment: .topTrailing)
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(15)
                        .rotation3DEffect(
                            .degrees(rotation),
                            axis: (x: 0, y: 1, z: 0)
                        )
                        //triggers when you get a trophy, and does fun spinny stuffs
                        .onChange(of: triggerTrophy, perform: { value in
                            withAnimation(.interpolatingSpring(stiffness: 10, damping: 6)) {
                                rotation += triggerTrophy ? 720 : 0
                            }
                            DispatchQueue.main.asyncAfter(deadline: triggerTrophy ? (.now() + 0.50) : (.now() + 0.16)){
                                triggerTrophy = false
                            }
                        })
                        //for getting 8th achievment
                        .onTapGesture {
                            if !trophy8 {
                                triggerTrophy = true
                            } else {
                                //spins it without showing trophy because its fun to spin things
                                withAnimation(.interpolatingSpring(stiffness: 10, damping: 6)) {
                                    rotation += 720
                                }
                            }
                            trophy8 = true
                        }
                        .padding()
                }
                CustomTitleText(text: titleText)
                    .padding()
                //makes the long story text part scrollable so you can read the whole thing
                ScrollView{
                    CustomText(text: bodyText)
                }
                .padding()
                Spacer()
                //left and right choice buttons
                HStack{
                    Button(choice1){
                        choicePath += "1"
                        screenCounter += 1
                        checkText()
                        checkAchievement()
                    }
                    .disabled(disableChoice1)
                    .padding()
                    Button(choice2){
                        choicePath += "2"
                        screenCounter += 1
                        checkText()
                        checkAchievement()
                    }
                    .disabled(disableChoice2)
                    .padding()
                }
                .padding()
                //reset and go back buttons
                HStack{
                    Button("Back"){
                        screenCounter -= 1
                        choicePath.removeLast()
                        checkText()
                        checkAchievement()
                    }
                    .padding()
                    .disabled(screenCounter == 0)
                    Button("Reset"){
                        screenCounter = 0
                        choicePath = ""
                        checkText()
                        checkAchievement()
                    }
                    .padding()
                }
            }
            .navigationBarTitle("")
            //hides the navigation bar going from the home menu to game, becuase i dont want you going back
            .navigationBarHidden(true)
        }
        .onAppear{
            defaultText()
        }
        .preferredColorScheme(.dark)
    }
    //takes the choicePath string and finds the correct story bit that goes with it
    func checkText(){
        switch choicePath{
        case "1":
            path1()
        case "2":
            path2()
        case "11":
            //bad ending
            path11()
            addFinishedPath(string: choicePath, goodEnding: false)
        case "12":
            //bad ending
            path12()
            addFinishedPath(string: choicePath, goodEnding: false)
        case "21":
            //bad ending
            path21()
            addFinishedPath(string: choicePath, goodEnding: false)
        case "22":
            path22()
        case "221":
            //bad ending
            path221()
            addFinishedPath(string: choicePath, goodEnding: false)
        case "222":
            path222()
        case "2221":
            path2221()
        case "2222":
            //bad ending
            path2222()
            addFinishedPath(string: choicePath, goodEnding: false)
        case "22211":
            //good ending
            path22211()
            addFinishedPath(string: choicePath, goodEnding: true)
        case "22212":
            //bad ending
            path22212()
            addFinishedPath(string: choicePath, goodEnding: false)
        default:
            defaultText()
        }
    }
    
    //use for doing achievemnet checking, since same code will be reused alot
    func addFinishedPath (string : String, goodEnding : Bool) {
        if !finishedPathsList.contains(string) {
            finishedPathsList.append(string)
            if goodEnding {
                goodEndings += 1
            } else {
                badEndings += 1
            }
        }
        finishedPaths += 1
    }
    
    func checkAchievement(){
        //checks to see if the first choice was selected
        if screenCounter != 0 {
            if !trophy1 {
                triggerTrophy = true
            }
            trophy1 = true
        }
        //checks to see if the player got there first bad ending
        if badEndings != 0 {
            if !trophy2 {
                triggerTrophy = true
            }
            trophy2 = true
        }
        //checks if player got atleast 3 bad endings
        if badEndings == 3 {
            if !trophy3 {
                triggerTrophy = true
            }
            trophy3 = true
        }
        //checks if the play got every achievment (non inclusive)
        if (trophy1 && trophy2 && trophy3 && trophy5 && trophy6 && trophy7 && trophy8) {
            if !trophy4 {
                triggerTrophy = true
            }
            trophy4 = true
        }
        //checks to see if player got good ending
        if goodEndings != 0 {
            if !trophy5 {
                triggerTrophy = true
            }
            trophy5 = true
        }
        //checks if player has gone through same story path
        if finishedPathsList.count < finishedPaths {
            if !trophy6 {
                triggerTrophy = true
            }
            trophy6 = true
        }
        // checks if all the paths have been complete
        if finishedPathsList.count == 7 {
            if !trophy7 {
                triggerTrophy = true
            }
            trophy7 = true
        }
    }
    
    //While the functions are technicaly unecisary, it helps organize code so it's easier to edit the large text, and keeps them from breaking up code.
    func defaultText(){
        titleText = "Legendary Treasure"
        bodyText = "You are an adventurer looking for the most legendary treasure: the crown of the legendary Irish Disco King. You found the fabled lost chest with an ancient map leading you to where you are standing right now, in front of a large stone spire towering way above the largest mountain. The spire was outfitted with a gold garnishing and a beautiful mahogany door. Colorful glass windows line the side of the walls leading up to the very top where a large copper bell stood. As you glance to the side you can make out a dark cave behind the trees and shrubs surrounding the stone pillar. The map appears to lead past the tower and into an impossibly dark cave as if it sucked in the light around it. It seems unthinkable that the treasure doesn’t lie within the stone tower, but the map hasn’t failed you so far. The sound of bugs grows louder as the sun begins its slow descent downward. If you want to get back to safety before nightfall then you need to choose where to go now. You hope to not find out what hides in the jungle when night falls."
        choice2 = "The dark cave"
        choice1 = "The stone tower"
        disableChoice1 = false
        disableChoice2 = false
    }
    
    func path1(){
        titleText = "A Beautiful Tower"
        bodyText = "Glancing at the stone tower, you notice that light seemed to emanate off its walls. Approaching the door, you are able to make out three letters engraved on the door. “I D K”. Not knowing what they could stand for, you grab the handle and push the door open and take a step inside. As the door closes behind you, you make out a faint ringing coming from above you. The inside of the tower seems to be bigger than the outside. The expansive room is outfitted with a large red rug, gold chainlears, and many priceless relics on the wall. Many bejeweled weapons hung from the walls, while a set of armor sat as a centerpiece in the room. On the left of the armor lay a staircase going up, while on the right a staircase going down. Both seem like equally good options, but you would much rather be going up than down."
        choice1 = "Go up"
        choice2 = "Go down"
        disableChoice1 = false
        disableChoice2 = false
    }
    
    func path2(){
        titleText = "A Cave of Darkness"
        bodyText = "Against your better judgment, it was probably best to trust the map, it has gotten you this far after all. Bringing out your handy machete, you cut through the dense bushes and tall grass, making your way slowly towards the mouth of the cave. The cave seemed to grow in size the closer you got, big enough for a dragon to fit comfortably through. Huge stalactites and stalagmites reach 20 feet into their air, casting long shadows across the already dark landscape. The plants around you grew away from the cave as if trying to escape the cave's dark grasp. You took one final look around, the vibrant jungle suddenly feeling like the most enticing option ever, and took a step into the cave. Pitch black encircled you while a light buzzing filled your ears, numbing your senses. Thankfully you brought a torch with you, and fumbling around in the dark you find it in your pack. You hear a sharp clang echo through the cave as the weight dropped from your waist. Instead of looking for your machete in the dark with the risk of cutting yourself, you opt to finish lighting your torch. As you strike your flint against a nearby rock, bursting your light into flames, your surroundings flash with brightness and just as quickly fall back into darkness. The range of your torch seems to be diminished by the cave, and you can barely see in front of you. You toil with the option of looking for your machete or braving on without it. It would be near impossible to find the machete in the darkness but could come in handy if something dangerous was hiding in the cave. Then again, you are on a time limit and don’t want to waste all your time looking for a machete that you may not even need to use."
        choice1 = "Yes Machete"
        choice2 = "No Machete"
        disableChoice1 = false
        disableChoice2 = false
    }
    
    func path11(){
        titleText = "Going Up"
        bodyText = "You go up the stairs and trip and fall down."
        choice2 = "DIED"
        choice1 = "YOU"
        disableChoice1 = true
        disableChoice2 = true
    }
    
    func path12(){
        titleText = "Going Down"
        bodyText = "You go down the stairs and trip and fall down"
        choice2 = "DIED"
        choice1 = "YOU"
        disableChoice1 = true
        disableChoice2 = true
    }
    
    func path21(){
        titleText = "You look for your machete"
        bodyText = "You trace your steps to where you thought you lost your machete. Looking around you slowly make your way around the cave, cautiously searching every corner, the darkness making it a long grueling task. Placing your torch on the ground, you bend down to start moving a huge boulder when you see a glint in the corner of your eye. Quickly whipping around you spy a shiny object in the corner of the cave, barely illuminated by your torch. As you make your way closer, you can make out a beautiful fencing sword engraved with gems and gold. You bend down to grab the sword, but it doesn’t budge. Angry, you kick it and with a sudden white light, you are thrown to the back wall of the cave. You hear a rumble, and looking up and a crack starts forming on the roof. You try with all your might to get out of the way, but your legs don’t budge. Taking one last look upwards, the last thing you see is a stalactite falling down right for your head. "
        choice2 = "DIED"
        choice1 = "YOU"
        disableChoice1 = true
        disableChoice2 = true
    }
    
    func path22(){
        titleText = "Your brave on without your machete"
        bodyText = "You decided it would be foolish to look for your machete. As you take a step forward you can’t help but look back. Are you sure you don’t want to look for your machete?"
        choice1 = "Yes"
        choice2 = "NO"
        disableChoice1 = false
        disableChoice2 = false
    }
    
    func path221(){
        titleText = "Yes I'm Sure"
        bodyText = "You go on, not only feeling empty without your trusty machete, but vulnerable without a means for protection. You make your way through the cave, drops of water breaking the eerie silence every so often. As you go farther and farther through the cave it only seems to get larger, while the stalactites and stalagmites grow long enough to pierce the roof and floor of the cave. As you go to check your map you barely make out distinct clicks. You ignore the sound, knowing that getting in and out of the cave is more important. Tracing your path through the map, you can’t help but notice the clicks getting faster and louder, the sounds rebounding around the cave. Suddenly your skin turns cold, your hairs stand up, and the clicking stops. You slowly turn around to face a massive sized spider. Its legs where the size of your forearm and it’s eyes glowed a bright red, starting directly into your eyes. You cautiously reach for your machete only to come up empty handed. The spider lunges for you."
        choice1 = "YOU"
        choice2 = "DIED"
        disableChoice1 = true
        disableChoice2 = true
    }
    
    func path222(){
        titleText = "Lets Go Back"
        bodyText = "You make your way back to where you previously stood. Looking around you slowly make your way around the cave, cautiously searching every corner for your machete. Placing your torch on the ground, you bend down to start picking up a huge boulder when you see a glint in the corner of your eye. Quickly whipping around you spy a shiny object in the corner of the cave, barely illuminated by your torch. As you make your way closer, you are able to make out an intricately carved wooden chest with a huge red jewel in the place of a lock. You pull out your map to see if you truly stumbled upon the fabled crown, but to your dismay, the map leads your father into the cave. You ponder your choices, still, trust your map or break the chest and claim what is yours. The map seems to be leading you in circles, and you are starting to doubt its validity, but who put the legendary crown in a chest all by its lonesome."
        choice2 = "Break the chest"
        choice1 = "Keep looking"
        disableChoice1 = false
        disableChoice2 = false
    }
    
    func path2221(){
        titleText = "Finding the machete"
        bodyText = "You decide that the chest can wait, a machete is far more important in such a dangerous environment. After what felt like hours of non-stop searching you finally find it. Your machete, or at least you think it is yours, lay deep in a rock just like excalibur. You tug at it, but it doesn’t budge. You don’t know if you should just call it quits. The machete has been way more trouble than it is worth, but you don’t know what you could possibly use to defend yourself otherwise."
        choice2 = "Keep trying"
        choice1 = "Give up"
        disableChoice1 = false
        disableChoice2 = false
    }
    
    func path2222(){
        titleText = "Breaking the chest"
        bodyText = "You bend down to grab the chest, but it doesn’t budge. Looking to your left you see a sizable rock and grab it. Bringing it down onto the chest the red jewel flashes brightly, illuminating the previously pitch-black cave into a red hue, and you get thrown back into the back wall of the cave. You hear a rumble, and looking up and a crack starts forming on the roof. You try with all your might to get out of the way, but your legs don’t budge. Taking one last look upwards, the last thing you see is a stalactite falling down right for your head."
        choice2 = "DIED"
        choice1 = "YOU"
        disableChoice1 = true
        disableChoice2 = true
    }
    
    func path22211(){
        titleText = "Keep Trying"
        bodyText = "Circling around the stone, you try to find any weakness. Running your hand down the side, you feel a crack infinitesimally small and invisible to the naked eye. You smash a nearby rock into the crack, slowly increasing its size. Before long, the stone lay in pieces and the machete was in your hand. The sword seems to have given you new found strength, and a sudden inkling on where the crown could be. You rush through the cave, torch held high above you, and sword by your side, until you stumble upon it. The treasure room. In the very middle lay the crown, unmistakable in it’s infinite perfection. The crown of the Irish Disco King. You lung for it and put it onto your head. You did it. You found the treasure. You are now the new Irish Disco King."
        choice2 = ""
        choice1 = ""
        disableChoice1 = true
        disableChoice2 = true
    }
    
    func path22212(){
        titleText = "Give up"
        bodyText = "You give up and die. I don’t feel like writing stuff anymore. This is it. This path would have killed you anyways, I am just sparing you the effort."
        choice2 = "DIED"
        choice1 = "YOU"
        disableChoice1 = true
        disableChoice2 = true
    }
    
}

struct SwiftUIViewGame_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIViewGame(characterName: "Billy Bob", characterPic: "Zebra")
    }
}

