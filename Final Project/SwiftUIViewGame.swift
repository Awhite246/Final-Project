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
    var body: some View{
        VStack{
            CustomTop(characterName: characterName, characterPic: characterPic)
            CustomText(text: "hello world")
            Spacer()
        }
        .preferredColorScheme(.dark)
    }
}

struct SwiftUIViewGame_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIViewGame(characterName: "", characterPic: "Zebra")
    }
}
