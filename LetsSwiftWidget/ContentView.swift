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
          .font(.system(size: 100, design: .rounded))
          .foregroundStyle(.blue)
          .transition(.flipClockTransition.animation(.default))
          .id(singleNumber)
      }
      .font(.largeTitle)
      
      HStack {
        Button("DOWN!", action: { singleNumber -= 1 })
        Button("UP!", action: { singleNumber += 1 })
      }
      
      HStack {
        Button("(인텐트) DOWN!", intent: NumberDownIntent())
        Button("(인텐트) UP!", intent: NumberUpIntent())
      }
    }
    .buttonStyle(.borderedProminent)
    .sensoryFeedback(trigger: singleNumber) { oldValue, newValue in
      newValue > oldValue ? .increase : .decrease // 버튼과 인텐트 모두 작동 함!
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
