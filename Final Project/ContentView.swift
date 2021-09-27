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
    var body: some View {
        NavigationView{
            VStack{
                CustomTitleText(text: "The Hunt for the Irish Disco King and his Merciless Gnome Squadron")
                CustomTextField(placeholder: "Enter in your name", variable: $characterName)
                CustomText(text: "Click to change your character")
                Image(charPic)
                    .resizable()
                    .frame(width: 125, height: 125, alignment: .center)
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(30)
                    
                    .onTapGesture {
                        
                        if (charPic == "Zebra"){
                            charPic = "Cat"
                        }else if(charPic == "Cat"){
                            charPic = "Dog"
                        }else if(charPic == "Dog"){
                            charPic = "Zebra"
                        }
                        
                    }
                NavigationLink("Play Game", destination: SwiftUIViewGame(characterName: characterName, characterPic: charPic).navigationBarBackButtonHidden(true))
                    .disabled(characterName == "")
                    .font(.title2)
                    .padding()
                
                if (characterName == ""){
                    CustomText(text: "Hello Username!")
                }else{
                    CustomText(text: "Hello \(characterName)!")
                }
                Spacer()
            }
        }
        .preferredColorScheme(.dark)
    }
}
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
struct CustomTop: View{
    let characterName : String
    let characterPic : String
    let choicePath : Int
    var body: some View{
        HStack{
            CustomText(text: "Path: \(choicePath)")
            Spacer()
            CustomText(text: characterName)
                .frame(height: 50, alignment: .topLeading)
            Image(characterPic)
                .resizable()
                .frame(width: 50, height: 50, alignment: .topTrailing)
                .aspectRatio(contentMode: .fit)
                .cornerRadius(15)
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
