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
                    .frame(width: 100, height: 100, alignment: .center)
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(30)
                    
                    .onTapGesture {
                        withAnimation(Animation.easeIn){
                            if (charPic == "Zebra"){
                                charPic = "Cat"
                            }else if(charPic == "Cat"){
                                charPic = "Dog"
                            }else if(charPic == "Dog"){
                                charPic = "Zebra"
                            }
                        }
                    }
                    .rotation3DEffect(
                        .init(degrees: 0),
                        axis: (x: 0.0, y: 1.0, z: 0.0)
                    )
                NavigationLink("Play Game", destination: SwiftUIViewGame(characterName: characterName).navigationBarBackButtonHidden(true))
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
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
