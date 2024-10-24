//
//  ContentView.swift
//  LetsSwiftWidget
//
//  Created by 유재호 on 10/24/24.
//

import SwiftUI
import WidgetKit

struct ContentView: View {

  @AppStorage("singleNumber", store: .shared) private var singleNumber: Int = .zero
  @Environment(\.scenePhase) private var scenePhase

  var body: some View {
    VStack {
      GroupBox("@AppStorage 저장된 숫자") {
        Text("\(singleNumber)")
          .font(.system(size: 100, design: .serif))
          .foregroundStyle(.blue)
      }
      .font(.largeTitle)
      
      HStack {
        Button("UP!", action: { singleNumber += 1 })
        Button("DOWN!", action: { singleNumber -= 1 })
      }
      .buttonStyle(.borderedProminent)
    }
    .onChange(of: scenePhase) { _, newValue in
      if newValue == .background {
        // BG 로 갈 때 위젯 리프레시
        WidgetCenter.shared.reloadAllTimelines()
      }
    }
  }
}

#Preview {
  ContentView()
}
