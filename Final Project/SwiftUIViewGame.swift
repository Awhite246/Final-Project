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
                //the top bit of screen
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
                        .onChange(of: triggerTrophy, perform: { value in
                            withAnimation(.interpolatingSpring(stiffness: 10, damping: 6)) {
                                rotation += triggerTrophy ? 720 : 0
                            }
                            DispatchQueue.main.asyncAfter(deadline: triggerTrophy ? (.now() + 0.50) : (.now() + 0.16)){
                                triggerTrophy = false
                            }
                        })
                        .onTapGesture {
                            if !trophy8 {
                                triggerTrophy = true
                            } else {
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
                ScrollView{
                    CustomText(text: bodyText)
                }
                .padding()
                Spacer()
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
            .navigationBarHidden(true)
        }
        .onAppear{
            defaultText()
        }
        .preferredColorScheme(.dark)
    }
    func checkText(){
        switch choicePath{
        case "1":
            path1()
        case "2":
            path2()
        case "11":
            path11()
        case "12":
            path12()
        case "21":
            path21()
        case "22":
            path22()
        case "111":
            path111()
        case "121":
            path121()
        case "211":
            path211()
        case "221":
            //ending
            path221()
            addFinishedPath(string: choicePath, goodEnding: false)
        case "112":
            path112()
        case "122":
            path122()
        case "212":
            path212()
        case "222":
            path222()
        case "2221":
            path2221()
        case "2222":
            path2222()
        default:
            defaultText()
        }
    }
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
        //checks if player got atleast 10 bad endings
        if badEndings == 10 {
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
        //checks to see if player got first good ending
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
        if finishedPathsList.count == 16 {
            if !trophy7 {
                triggerTrophy = true
            }
            trophy7 = true
        }
    }
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
        bodyText = "Body"
        choice1 = "choose me"
        choice2 = "no choose me"
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
        titleText = "Path 11"
        bodyText = "Body"
        choice2 = "Choice 2"
        choice1 = "Choice 1"
        disableChoice1 = false
        disableChoice2 = false
    }
    
    func path12(){
        titleText = "Path 12"
        bodyText = "Body"
        choice2 = "Choice 2"
        choice1 = "Choice 1"
        disableChoice1 = false
        disableChoice2 = false
    }
    
    func path21(){
        titleText = "You look for your machete"
        bodyText = "Body"
        choice2 = "Choice 2"
        choice1 = "Choice 1"
        disableChoice1 = false
        disableChoice2 = false
    }
    
    func path22(){
        titleText = "Your brave on without your machete"
        bodyText = "You decided it would be foolish to look for your machete. As you take a step forward you can’t help but look back. Are you sure you don’t want to look for your machete?"
        choice1 = "Yes"
        choice2 = "NO"
        disableChoice1 = false
        disableChoice2 = false
    }
    
    func path111(){
        titleText = "Path 111"
        bodyText = "Body"
        choice2 = "Choice 2"
        choice1 = "Choice 1"
        disableChoice1 = false
        disableChoice2 = false
    }
    
    func path121(){
        titleText = "Path 121"
        bodyText = "Body"
        choice2 = "Choice 2"
        choice1 = "Choice 1"
        disableChoice1 = false
        disableChoice2 = false
    }
    
    func path211(){
        titleText = "Path 211"
        bodyText = "Body"
        choice2 = "Choice 2"
        choice1 = "Choice 1"
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
    
    func path112(){
        titleText = "Path 112"
        bodyText = "Body"
        choice2 = "Choice 2"
        choice1 = "Choice 1"
        disableChoice1 = false
        disableChoice2 = false
    }
    
    func path122(){
        titleText = "Path 122"
        bodyText = "Body"
        choice2 = "Choice 2"
        choice1 = "Choice 1"
        disableChoice1 = false
        disableChoice2 = false
    }
    
    func path212(){
        titleText = "Path 212"
        bodyText = "Body"
        choice2 = "Choice 2"
        choice1 = "Choice 1"
        disableChoice1 = false
        disableChoice2 = false
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
        titleText = "Path 2221"
        bodyText = "Body"
        choice2 = "Choice 2"
        choice1 = "Choice 1"
        disableChoice1 = false
        disableChoice2 = false
    }
    func path2222(){
        titleText = "Path 2222"
        bodyText = "Body"
        choice2 = "Choice 2"
        choice1 = "Choice 1"
        disableChoice1 = false
        disableChoice2 = false
    }
}

struct SwiftUIViewGame_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIViewGame(characterName: "Billy Bob", characterPic: "Zebra")
    }
}

