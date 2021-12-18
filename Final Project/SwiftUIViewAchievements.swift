//
//  SwiftUIViewAchievements.swift
//  Final Project
//
//  Created by Student on 10/5/21.
//

import SwiftUI

struct SwiftUIViewAchievements: View {
    let trophy : HasAchievements
    var body: some View {
        VStack{
            //scroll view so everything can fit confortably
            ScrollView{
                Group{
                    achievement(achievementName: "Adventure Awaits", achievementDescription: "Start your first story path", hasAchievement: trophy.trophy1)
                    achievement(achievementName: "Untimely End", achievementDescription: "Suffer your first death", hasAchievement: trophy.trophy2)
                    achievement(achievementName: "Bountiful Treasure", achievementDescription: "Get your first good ending", hasAchievement: trophy.trophy5)
                    achievement(achievementName: "Accident Prone", achievementDescription: "Get 10 bad endings", hasAchievement: trophy.trophy3)
                }
                Group{
                    achievement(achievementName: "Grand-Adventurer", achievementDescription: "Complete every story path", hasAchievement: trophy.trophy7)
                    achievement(achievementName: "Déjà Vu", achievementDescription: "Replay the same story path", hasAchievement: trophy.trophy6)
                    achievement(achievementName: "Hidden in Plain Sight", achievementDescription: "I wonder how to get this one", hasAchievement: trophy.trophy8)
                    achievement(achievementName: "Trophy Collecter", achievementDescription: "Get every achievement", hasAchievement: trophy.trophy4)
                }
            }
            Spacer()
        }
        .navigationBarTitle("Achievements")
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Title")
        .preferredColorScheme(.dark)
    }
}

//because each achievment is very simlar in code, and function didn't work becuase it uses views, struct is necessary
struct achievement : View {
    let achievementName : String
    let achievementDescription : String
    let hasAchievement : Bool
    @State private var displayText = ""
    @State private var clicked = true
    var body: some View{
        HStack{
            Image("trophy 1")
                .resizable()
                .frame(width: 75, height: 75, alignment: .leading)
                .aspectRatio(contentMode: .fit)
                .cornerRadius(15)
                .grayscale(hasAchievement ? 0.0 : 0.99)
                .blur(radius: hasAchievement ? 0.0 : 3.0)
                .padding()
            Spacer()
            Text(displayText)
                .font(clicked ? .title2 : .body)
                .fontWeight(.bold)
                .foregroundColor(hasAchievement ? .white : .gray)
                .multilineTextAlignment(.trailing)
                .padding(35)
            
        }
        //switches the description and title of achievement based on if it was clicked
        .onTapGesture {
            if clicked && achievementDescription != "" {
                displayText = achievementDescription
                clicked = false
            } else {
                displayText = achievementName
                clicked = true
            }
        }
        .onAppear(perform: {
            displayText = achievementName
        })
    }
}
struct HasAchievements{
    @State var trophy1 = false
    @State var trophy2 = false
    @State var trophy3 = false
    @State var trophy4 = false
    @State var trophy5 = false
    @State var trophy6 = false
    @State var trophy7 = false
    @State var trophy8 = false
}
struct SwiftUIViewAchievements_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIViewAchievements(trophy: HasAchievements())
    }
}
