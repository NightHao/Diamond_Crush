//
//  PreviousView.swift
//  Color_Crush
//
//  Created by nighthao on 2022/5/2.
//

import SwiftUI
struct PreviousView: View {
    @State private var showContentView = false
    @State private var showUniqueView = false
    var body: some View {
        VStack(spacing: 20){
            Text("Diamond Crush")
                .font(.title)
            Button("Square_Stage"){
                showContentView = true
            }.fullScreenCover(isPresented: $showContentView, content:{ContentView(showContentView: $showContentView)})
            Button("Unique_Stage"){
                showUniqueView = true
            }.fullScreenCover(isPresented: $showUniqueView, content:{UniqueView(showUniqueView: $showUniqueView)})
            /*Button("PVE"){
                showPveView = true
            }.fullScreenCover(isPresented: $showPveView, content:{PveView(showPveView: $showPveView)})*/
            
            }
        }
}

struct PreviousView_Previews: PreviewProvider {
    static var previews: some View {
        PreviousView()
    }
}
