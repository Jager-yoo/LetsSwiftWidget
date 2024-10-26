//
//  CustomTransitionEffect.swift
//  LetsSwiftWidget
//
//  Created by 유재호 on 10/26/24.
//

import SwiftUI

extension AnyTransition {
  static var flipClockTransition: AnyTransition {
    .modifier(
      active: FlipClockEffect(angle: 90),
      identity: FlipClockEffect(angle: 0)
    )
  }

  static var zoomRotate: AnyTransition {
    .modifier(
      active: ZoomRotateEffect(scale: 0.1, angle: 90),
      identity: ZoomRotateEffect(scale: 1.0, angle: 0)
    )
  }
}

struct FlipClockEffect: ViewModifier {
  var angle: Double

  func body(content: Content) -> some View {
    content
      .rotation3DEffect(
        .degrees(angle),
        axis: (x: 1, y: 0, z: 0),
        anchor: .top,
        perspective: 0.5
      )
      .clipped() // 뷰의 클립을 유지해 깔끔하게 전환
  }
}

struct ZoomRotateEffect: ViewModifier {
  var scale: CGFloat
  var angle: Double

  func body(content: Content) -> some View {
    content
      .scaleEffect(scale)
      .rotationEffect(.degrees(angle))
      .opacity(scale == 1 ? 1 : 0) // 사라질 때는 투명도 0
  }
}
