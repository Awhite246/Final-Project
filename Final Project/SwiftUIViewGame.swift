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
    var body: some View{
        NavigationView{
            VStack{
                HStack{
                    NavigationLink("Achievements", destination: SwiftUIViewAchievements())
                        .padding()
                    Spacer()
                    CustomText(text: "\(characterName)")
                        .frame(height: 50, alignment: .topLeading)
                    Image(characterPic)
                        .resizable()
                        .frame(width: 50, height: 50, alignment: .topTrailing)
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(15)
                        .padding()
                }
                CustomTitleText(text: titleText)
                    .padding()
                ScrollView{
                    CustomText(text: bodyText)
                }
                .padding()
                HStack{
                    Button(choice1){
                        choicePath += "1"
                        screenCounter += 1
                        checkText()
                    }
                    .disabled(screenCounter == 3 || disableChoice1)
                    .padding()
                    Button(choice2){
                        choicePath += "2"
                        screenCounter += 1
                        checkText()
                    }
                    .disabled(screenCounter == 3 || disableChoice2)
                    .padding()
                }
                .padding()
                HStack{
                    Button("Back"){
                        screenCounter -= 1
                        choicePath.removeLast()
                        checkText()
                    }
                    .padding(30)
                    .disabled(screenCounter == 0)
                    Button("Reset"){
                        screenCounter = 0
                        choicePath = ""
                        checkText()
                    }
                    .padding(30)
                }
                Spacer()
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
            path221()
        case "112":
            path112()
        case "122":
            path122()
        case "212":
            path212()
        case "222":
            path222()
        default:
            defaultText()
        }
    }
    func defaultText() {
        titleText = "This is a story"
        bodyText = "A great story even. Some might say the best of stories. They would be correct. This is the best of stories. In the world. A great story even. Some might say the best of stories. They would be correct. This is the best of stories. In the world. A great story even. Some might say the best of stories. They would be correct. This is the best of stories. In the world. A great story even. Some might say the best of stories. They would be correct. This is the best of stories. In the world. A great story even. Some might say the best of stories. They would be correct. This is the best of stories. In the world. A great story even. Some might say the best of stories. They would be correct. This is the best of stories. In the world. A great story even. Some might say the best of stories. They would be correct. This is the best of stories. In the world. A great story even. Some might say the best of stories. They would be correct. This is the best of stories. In the world. A great story even. Some might say the best of stories. They would be correct. This is the best of stories. In the world. A great story even. Some might say the best of stories. They would be correct. This is the best of stories. In the world. A great story even. Some might say the best of stories. They would be correct. This is the best of stories. In the world. A great story even. Some might say the best of stories. They would be correct. This is the best of stories. In the world. A great story even. Some might say the best of stories. They would be correct. This is the best of stories. In the world. A great story even. Some might say the best of stories. They would be correct. This is the best of stories. In the world. A great story even. Some might say the best of stories. They would be correct. This is the best of stories. In the world. A great story even. Some might say the best of stories. They would be correct. This is the best of stories. In the world. A great story even. Some might say the best of stories. They would be correct. This is the best of stories. In the world. A great story even. Some might say the best of stories. They would be correct. This is the best of stories. In the world. A great story even. Some might say the best of stories. They would be correct. This is the best of stories. In the world. A great story even. Some might say the best of stories. They would be correct. This is the best of stories. In the world. A great story even. Some might say the best of stories. They would be correct. This is the best of stories. In the world. A great story even. Some might say the best of stories. They would be correct. This is the best of stories. In the world. A great story even. Some might say the best of stories. They would be correct. This is the best of stories. In the world. A great story even. Some might say the best of stories. They would be correct. This is the best of stories. In the world. A great story even. Some might say the best of stories. They would be correct. This is the best of stories. In the world. A great story even. Some might say the best of stories. They would be correct. This is the best of stories. In the world. A great story even. Some might say the best of stories. They would be correct. This is the best of stories. In the world. A great story even. Some might say the best of stories. They would be correct. This is the best of stories. In the world. A great story even. Some might say the best of stories. They would be correct. This is the best of stories. In the world. A great story even. Some might say the best of stories. They would be correct. This is the best of stories. In the world. A great story even. Some might say the best of stories. They would be correct. This is the best of stories. In the world. A great story even. Some might say the best of stories. They would be correct. This is the best of stories. In the world. "
        choice2 = "Choice 2"
        choice1 = "Choice 1"
        disableChoice1 = false
        disableChoice2 = false
    }
    
    func path1() {
        titleText = "Path 1"
        bodyText = "Body"
        choice1 = "choose me"
        choice2 = "no choose me"
        disableChoice1 = false
        disableChoice2 = false
    }
    
    func path2() {
        titleText = "Path 2"
        bodyText = "Body"
        choice1 = "choice 1"
        choice2 = "choice 2"
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
        titleText = "Path 21"
        bodyText = "Body"
        choice2 = "Choice 2"
        choice1 = "Choice 1"
        disableChoice1 = false
        disableChoice2 = false
    }
    
    func path22(){
        titleText = "Path 22"
        bodyText = "Body"
        choice2 = "Choice 2"
        choice1 = "Choice 1"
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
        titleText = "Path 221"
        bodyText = "Body"
        choice2 = "Choice 2"
        choice1 = "Choice 1"
        disableChoice1 = false
        disableChoice2 = false
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
        titleText = "Path 222"
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

