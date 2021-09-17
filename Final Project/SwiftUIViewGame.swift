//
//  SwiftUIViewGame.swift
//  Final Project
//
//  Created by Student on 9/15/21.
//

import SwiftUI

struct SwiftUIViewGame: View {
    let characterName : String
    var body: some View{
        CustomText(text: "hello world")
    }
}

struct SwiftUIViewGame_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIViewGame(characterName: "")
    }
}
