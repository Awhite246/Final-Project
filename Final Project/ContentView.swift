//
//  ContentView.swift
//  Final Project
//
//  Created by Student on 9/14/21.
//

import SwiftUI

struct ContentView: View {
    @State private var characterName = ""
    @State private var charPic = "Zebra"
    @State private var rotation = 0.0
    @State private var showGame = false
    var body: some View {
        VStack{
            //since there is no back button needed, naviagtion view is unecessary and naviagtion view makes annying header space that you cant get rid of, so no naviagtion view
            if showGame {
                SwiftUIViewGame(characterName: characterName, characterPic: charPic)
            } else {
                CustomTitleText(text: "The Hunt for the Irish Disco King and his Crooked Crown")
                    .padding(.top, 100)
                CustomTextField(placeholder: "What's your name", variable: $characterName)
                    .padding()
                CustomText(text: "Choose your character")
                Image(charPic)
                    .resizable()
                    .frame(width: 125, height: 125, alignment: .center)
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(30)
                    .rotation3DEffect(
                        .degrees(rotation),
                        axis: (x: 0, y: 1, z: 0)
                    )
                    //cool spins and stuff
                    .onTapGesture {
                        //delay timer so you dont see when it switches the characeter picture
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.31){
                            if (charPic == "Zebra"){
                                charPic = "Cat"
                            }else if(charPic == "Cat"){
                                charPic = "Dog"
                            }else if(charPic == "Dog"){
                                charPic = "Zebra"
                            }
                        }
                        withAnimation(.interpolatingSpring(stiffness: 10, damping: 6)) {
                            rotation += 360
                        }
                    }
                if (characterName == ""){
                    CustomText(text: "Hello Username!")
                        .padding()
                }else{
                    CustomText(text: "Hello \(characterName)!")
                        .padding()
                }
                Spacer()
                Button ("Play Game") {
                    showGame.toggle()
                }
                //makes sure the user imputed a name before letting them start playing
                .disabled(characterName == "")
                .font(.title2)
                .padding(50)
            }
        }
        .preferredColorScheme(.dark)
    }
}

//since the text code is reused alot so there is struct for it.
struct CustomText: View{
    let text:String
    var body:some View{
        Text(text)
            .font(.body)
            .fontWeight(.medium)
    }
}
struct CustomTitleText: View{
    let text: String
    var body: some View{
        Text(text)
            .font(.title)
            .fontWeight(.heavy)
            .multilineTextAlignment(.center)
    }
}
struct CustomTextField: View {
    let placeholder : String
    let variable : Binding<String>
    var body: some View {
        TextField(placeholder, text: variable)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .multilineTextAlignment(.center)
            .frame(width: 200, height: 30, alignment: .center)
            .font(.body)
            .padding()
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
