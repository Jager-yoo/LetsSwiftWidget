//
//  NumberIntents.swift
//  LetsSwiftWidget
//
//  Created by 유재호 on 10/25/24.
//

import AppIntents
import SwiftUI

struct NumberUpIntent: AppIntent {
  
  static let title: LocalizedStringResource = "숫자 올리기 인텐트"

  @AppStorage("singleNumber", store: .shared) var singleNumber: Int = .zero

  func perform() async throws -> some ProvidesDialog {
    singleNumber += 1
    return .result(dialog: IntentDialog("숫자를 올렸어요: \(singleNumber)"))
  }
}

struct NumberDownIntent: AppIntent {

  static let title: LocalizedStringResource = "숫자 내리기 인텐트"

  @AppStorage("singleNumber", store: .shared) private var singleNumber: Int = .zero

  func perform() async throws -> some ProvidesDialog {
    singleNumber -= 1
    return .result(dialog: IntentDialog("숫자를 내렸어요: \(singleNumber)"))
  }
}
