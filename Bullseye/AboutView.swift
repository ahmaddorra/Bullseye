//
//  AboutView.swift
//  Bullseye
//
//  Created by Ahmad Dorra on 9/13/20.
//  Copyright © 2020 Ahmad Dorra. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    let beige = Color(red: 255 / 255, green: 214 / 255, blue: 179 / 255)
    var body: some View {
        Group {
            VStack {
                Text("🎯 Bullseye 🎯").modifier(AboutHeadingStyle())
                Text("This is Bullseye, the game where you can win points and earn fame by dragging a slider.")
                    .modifier(AboutBodyStyle())
                Text("Your goal is to place the slider as close as possible to the target value. The closer you are, the more points you score.")
                    .modifier(AboutBodyStyle())
                Text("Enjoy").modifier(AboutBodyStyle())
            }.background(beige)
            .navigationBarTitle("About Bullseye")
        }.background(Image("Background"))
    }
    
    struct AboutHeadingStyle: ViewModifier{
        func body(content: Content) -> some View {
            content
                .font(Font.custom("Arial Rounded MT Bold", size: 30))
                .foregroundColor(Color.black)
                .padding(.top, 20)
                .padding(.bottom, 20)
        }
    }
    struct AboutBodyStyle: ViewModifier{
        func body(content: Content) -> some View {
            content
                .font(Font.custom("Arial Rounded MT Bold", size: 16))
                .foregroundColor(Color.black)
                .padding(.leading, 60)
                .padding(.trailing, 60)
                .padding(.bottom, 20)
        }
    }
    
}



struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView().previewLayout(.fixed(width: 896, height: 414))
    }
}
