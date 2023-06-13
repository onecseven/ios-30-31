//
//  ContentView.swift
//  timer0.1
//
//  Created by Tatiana Talavera on 06-06-23.
//

import SwiftUI

struct pollo {
  var text: String {
    return ""
  }
}

struct ContentView: View {
    var body: some View {
      Text("Hm")
        .padding()
        .onAppear(){
          print(TimerColors.gray)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
