//
//  NumberIntents.swift
//  LetsSwiftWidget
//
//  Created by 유재호 on 10/25/24.
//

import AppIntents
import SwiftUI

struct NumberUpIntent: AppIntent, AudioPlaybackIntent {

  static let title: LocalizedStringResource = "숫자 올리기 인텐트"

  @AppStorage("singleNumber", store: .shared) private var singleNumber: Int = .zero
  @AppStorage("widgetShowsResult", store: .shared) private var widgetShowsResult: Bool = false

  func perform() async throws -> some ProvidesDialog {
    SoundPlayer.shared.play(.click)
    try await Task.sleep(for: .seconds(2))
    singleNumber += 1
    widgetShowsResult = true
    SoundPlayer.shared.play(.levelUp)
    return .result(dialog: IntentDialog("숫자를 올렸어요: \(singleNumber)"))
  }
}

struct NumberDownIntent: AppIntent, AudioPlaybackIntent {

  static let title: LocalizedStringResource = "숫자 내리기 인텐트"

  @AppStorage("singleNumber", store: .shared) private var singleNumber: Int = .zero
  @AppStorage("widgetShowsResult", store: .shared) private var widgetShowsResult: Bool = false

  func perform() async throws -> some ProvidesDialog {
    SoundPlayer.shared.play(.click)
    try await Task.sleep(for: .seconds(2))
    singleNumber -= 1
    widgetShowsResult = true
    SoundPlayer.shared.play(.levelUp)
    return .result(dialog: IntentDialog("숫자를 내렸어요: \(singleNumber)"))
  }
}

struct ResetIntent: AppIntent {

  static let title: LocalizedStringResource = "위젯 되돌아가기"
  static let isDiscoverable: Bool = false // 단축어에서 노출 안 되게 막음 (사용자가 꺼내 쓰지 못하게)

  @AppStorage("widgetShowsResult", store: .shared) var widgetShowsResult: Bool = false

  func perform() async throws -> some IntentResult {
    widgetShowsResult = false
    return .result()
  }
}
