//
//  ContentView.swift
//  LetsSwiftWidget
//
//  Created by 유재호 on 10/24/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {

  @AppStorage("singleNumber") private var singleNumber: Int = .zero

  var body: some View {
    VStack {
      GroupBox("@AppStorage 저장된 숫자") {
        Text("\(singleNumber)")
      }
      .font(.largeTitle)
      
      HStack {
        Button("UP!", action: { singleNumber += 1 })
        Button("DOWN!", action: { singleNumber -= 1 })
      }
      .buttonStyle(.borderedProminent)
    }
  }
}

#Preview {
  ContentView()
}
