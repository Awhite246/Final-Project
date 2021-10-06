//
//  SwiftUIViewAchievements.swift
//  Final Project
//
//  Created by Student on 10/5/21.
//

import SwiftUI

struct SwiftUIViewAchievements: View {
    var body: some View {
        NavigationView{
            VStack{
                ScrollView{
                    Group{
                        achievement(imageName: "trophy 1", achievementName: "Achievement 1", achievementDescription: "test test", hasAchievement: true)
                        achievement(imageName: "trophy 1", achievementName: "Achievement 2", achievementDescription: "", hasAchievement: true)
                        achievement(imageName: "trophy 1", achievementName: "Achievement 3", achievementDescription: "", hasAchievement: true)
                        achievement(imageName: "trophy 1", achievementName: "Achievement 4", achievementDescription: "", hasAchievement: true)
                    }
                    Group{
                        achievement(imageName: "trophy 1", achievementName: "Achievement 1", achievementDescription: "", hasAchievement: false)
                        achievement(imageName: "trophy 1", achievementName: "Achievement 2", achievementDescription: "", hasAchievement: false)
                        achievement(imageName: "trophy 1", achievementName: "Achievement 3", achievementDescription: "", hasAchievement: false)
                        achievement(imageName: "trophy 1", achievementName: "Achievement 4", achievementDescription: "", hasAchievement: false)
                    }
                    
                }
                Spacer()
            }
        }
        .navigationBarTitle("Achievements")
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Title")
        .preferredColorScheme(.dark)
    }
}
struct achievement : View{
    let imageName : String
    let achievementName : String
    let achievementDescription : String
    let hasAchievement : Bool
    @State private var displayText = ""
    var body: some View{
        var clicked = false
        HStack{
            Image(imageName)
                .resizable()
                .frame(width: 75, height: 75, alignment: .leading)
                .aspectRatio(contentMode: .fit)
                .cornerRadius(15)
                .grayscale(hasAchievement ? 0.0 : 0.99)
                .blur(radius: hasAchievement ? 0.0 : 3.0)
                .onTapGesture {
                    if clicked{
                        displayText = achievementDescription
                        clicked = false
                    }else{
                        displayText = achievementName
                        clicked = true
                    }
                }
                .padding()
            Spacer()
            Text(displayText)
                .font(clicked ? .body : .title2)
                .fontWeight(.bold)
                .foregroundColor(hasAchievement ? .white : .gray)
                .padding(35)
            
        }
        .onAppear(perform: {
            displayText = achievementName
        })
    }
}
struct SwiftUIViewAchievements_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIViewAchievements()
    }
}
