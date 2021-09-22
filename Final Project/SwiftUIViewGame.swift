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
                CustomTop(characterName: characterName, characterPic: characterPic, pageNum: screenCounter)
                CustomTitleText(text: titleText)
                CustomText(text: bodyText)
                    .padding()
                HStack{
                    Button(choice1){
                        switch screenCounter {
                        case 0:
                            titleText = "Hi there"
                            bodyText = "Wowowow"
                        default:
                            titleText = "wowowowowowowowow"
                            bodyText = "elelelele"
                        }
                        choicePath += "1"
                        screenCounter += 1
                    }
                    .padding()
                    Button(choice2){
                        switch screenCounter{
                        case 0:
                            titleText = "weewoo"
                            bodyText = "ahahahah"
                        default:
                            titleText = "big wow"
                            bodyText = "wow big"
                        }
                        choicePath += "2"
                        screenCounter += 1
                    }
                    .padding()
                }
//                Button("Back"){
//                    if (screenCounter > 0){
//                        screenCounter -= 1
//                    }
//                }
                Spacer()
            }
        }
        .preferredColorScheme(.dark)
    }
}

struct SwiftUIViewGame_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIViewGame(characterName: "Billy Bob", characterPic: "Zebra")
    }
}
