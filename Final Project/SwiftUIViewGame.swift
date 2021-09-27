//
//  SwiftUIViewGame.swift
//  Final Project
//
//  Created by Student on 9/15/21.
//

import SwiftUI

struct SwiftUIViewGame: View {
    let characterName : String
    let characterPic : String
    @State private var screenCounter = 0;
    @State private var titleText = "Title"
    @State private var bodyText = "Body"
    @State private var choice1 = "Choice 1"
    @State private var choice2 = "Choice 2"
    @State private var choicePath = ""
    var body: some View{
        NavigationView{
            VStack{
                CustomTop(characterName: characterName, characterPic: characterPic, choicePath: choicePath)
                CustomTitleText(text: titleText)
                CustomText(text: bodyText)
                    .padding()
                CustomText(text: choicePath)
                HStack{
                    Button(choice1){
                        switch choicePath {
                        case "":
                            pathA1()
                        case "1":
                            pathA1B1()
                        case "2":
                            pathA2B1()
                        default:
                            defaultText()
                        }
                        choicePath += "1"
                        screenCounter += 1
                    }
                    .padding()
                    Button(choice2){
                        switch choicePath {
                        case "":
                            pathA2()
                        case "1":
                            pathA1B2()
                        case "2":
                            pathA2B2()
                        default:
                            defaultText()
                        }
                        choicePath += "2"
                        screenCounter += 1
                    }
                    .padding()
                }
                Button("Back"){
                    if (screenCounter > 0){
                        screenCounter -= 1
                        choicePath.removeLast()
                        switch choicePath{
                        case "1":
                            pathA1()
                        case "2":
                            pathA2()
                        case "11":
                            pathA1B1()
                        case "12":
                            pathA1B2()
                        case "21":
                            pathA2B1()
                        case "22":
                            pathA2B2()
                        default:
                            defaultText()
                            
                        }
                    }
                }
                Spacer()
            }
        }
        .preferredColorScheme(.dark)
    }
    func pathA1() {
        titleText = "Path A1"
        bodyText = "Path 0"
        choice1 = "choose me"
        choice2 = "no choose me"
    }
    func pathA2() {
        titleText = "Path A2"
        bodyText = "Path 0"
        choice1 = "choice 1"
        choice2 = "choice 2"
    }
    func pathA1B1(){
        titleText = "Path A1B1"
        bodyText = "Path 1"
        choice2 = "Choice 2"
        choice1 = "Choice 1"
    }
    func pathA1B2(){
        titleText = "Path A1B2"
        bodyText = "Path 2"
        choice2 = "Choice 2"
        choice1 = "Choice 1"
    }
    func pathA2B1(){
        titleText = "Path A2B1"
        bodyText = "Path 1"
        choice2 = "Choice 2"
        choice1 = "Choice 1"
    }
    func pathA2B2(){
        titleText = "Path A2B2"
        bodyText = "Path 2"
        choice2 = "Choice 2"
        choice1 = "Choice 1"
    }
    func defaultText() {
        titleText = "Title"
        bodyText = "Body"
        choice2 = "Choice 2"
        choice1 = "Choice 1"
    }
}

struct SwiftUIViewGame_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIViewGame(characterName: "Billy Bob", characterPic: "Zebra")
    }
}
