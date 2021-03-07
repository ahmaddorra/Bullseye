//
//  ContentView.swift
//  Bullseye
//
//  Created by Ahmad Dorra on 8/3/20.
//  Copyright © 2020 Ahmad Dorra. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var alertIsvisible = false
    @State var sliderValue = 50.0
    @State var target = Int.random(in: 1...100)
    @State var score = 0
    @State var roundsCount = 1
    let midNightBlue = Color(red: 0 / 255.0, green: 51.0 / 255.0, blue: 102.0 / 255)
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Text("Put the bullseye as close as you can to").modifier(LabelStyle())
                Text("\(target)").modifier(ValueStyle())
            }
            
            Spacer()
            
            HStack {//Slider
                Text("1").modifier(LabelStyle())
                Slider(value: $sliderValue , in: 1...100).accentColor(Color.green)// value of type Binding<Double>
                Text("100").modifier(LabelStyle())
            }
            
            Spacer()
            Button(action: {
                print("Button pressed")
                self.alertIsvisible = true
            }) {
                Text("Hit me !").modifier(ButtonLargeTextStyle())
            }
            .foregroundColor(Color.blue)
            .alert(isPresented: $alertIsvisible) { () ->Alert in
                let roundedValue = sliderValueRounded()
                return Alert(
                    title: Text(alertTitle()),
                    message: Text("The slider value is \(roundedValue) \n" +
                        "You scored \(pointsForCurrentRound()) points this round "),
                    dismissButton: .default(Text("dismiss")) {
                        self.score = self.score + self.pointsForCurrentRound()
                        self.target = Int.random(in: 1...100)
                        self.roundsCount += 1
                    }
                )
            }
            .background(Image("Button"))
            .modifier(Shadow())
            Spacer()
            
            
            HStack{
                Button(action: {self.startOver()} ) {
                    HStack {
                        Image("StartOverIcon")
                        Text("Start Over").modifier(ButtonSmallTextStyle())
                    }
                }
                .background(Image("Button"))
                .modifier(Shadow())
                
                Spacer()
                Text("Score:").modifier(LabelStyle())
                Text("\(score)").modifier(ValueStyle())
                Spacer()
                Text("Round:").modifier(LabelStyle())
                Text("\(roundsCount)").modifier(ValueStyle())
                Spacer()
                NavigationLink(destination: AboutView()){
                    HStack {
                        Image("InfoIcon")
                        Text("Info").modifier(ButtonSmallTextStyle())
                    }
                }.background(Image("Button"))
                .modifier(Shadow())
            }
            .padding(.bottom,20)
        }
        .background(Image("Background"))
        .accentColor(midNightBlue)
        .navigationBarTitle("Bullseye")
    }
    
    struct LabelStyle: ViewModifier{
        func body(content: Content) -> some View {
            content
                .font(Font.custom("Arial Rounded MT Bold", size: 18)) //iosfonts.com
                .foregroundColor(Color.white)
            .modifier(Shadow())
        }
    }
    
    struct ValueStyle: ViewModifier{
        func body(content: Content) -> some View {
            content
                .font(Font.custom("Arial Rounded MT Bold", size: 24))
                .foregroundColor(Color.yellow)
                .modifier(Shadow())
        }
    }
    
    struct Shadow: ViewModifier{
           func body(content: Content) -> some View {
               content
                   .shadow(color: Color.black, radius: 5, x: 2, y: 2)
           }
    }
    
    struct ButtonLargeTextStyle: ViewModifier{
        func body(content: Content) -> some View {
            content
                .font(Font.custom("Arial Rounded MT Bold", size: 18))
                .foregroundColor(Color.black)
        }
    }
    
    struct ButtonSmallTextStyle: ViewModifier{
        func body(content: Content) -> some View {
            content
                .font(Font.custom("Arial Rounded MT Bold", size: 12))
                .foregroundColor(Color.black)
        }
    }
    
    func sliderValueRounded() -> Int {
        Int (sliderValue.rounded())
    }
    func amountOff() -> Int {
        return abs(sliderValueRounded() - target)
    }
    func pointsForCurrentRound() -> Int{
        let maxScore = 100
        let diff = amountOff()
        let bonus: Int
        if diff  == 0 {
            bonus = 100
        }
        else if diff == 1 {
            bonus = 50
        }
        else{
            bonus = 0
        }
        return maxScore - diff + bonus
    }
    func alertTitle() -> String {
        let score = pointsForCurrentRound()
        let title: String
        if score == 100 {
            title = "Perfect!"
        }
        else if score > 95{
            title = "You almost had it!"
        }
        else if score >= 90 {
            title = "Not bad."
        }
        else{
            title = "Are you even trying?"
        }
        return title
    }
    func startOver() {
        score = 0
        target = Int.random(in: 1...100)
        roundsCount = 1
        sliderValue = 50.0
    }
    
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewLayout(.fixed(width: 896, height: 414))
    }
}
