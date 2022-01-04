//
//  ContentView.swift
//  SwiftUIDemo
//
//  Created by min on 2021/05/13.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
//        Text("Hello, world!")
//            .padding()
//            .font(.largeTitle)
        VStack{
            Text("1")
            Text("2")
            Text("3")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        /*
        ContentView()
            //디바이스 실제 이름
            .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro Max"))
            //보여지는 이름
            .previewDisplayName("Name : iPhone 12 Pro Max")
        */
        
        //디바이스 여러 개 보려면 Group
        Group{
            ContentView()
                .previewDevice(PreviewDevice(rawValue: "iPhone SE (2nd generation)"))
                .previewDisplayName("iPhone SE 2")
                //다크모드
                //.environment(\.colorScheme, .dark)
            ContentView()
                .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
                .previewDisplayName("iPhone 12")
        }
    }
}
