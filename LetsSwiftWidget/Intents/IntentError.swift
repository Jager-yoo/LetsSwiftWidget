//
//  IntentError.swift
//  LetsSwiftWidget
//
//  Created by 유재호 on 11/10/24.
//

import Foundation

enum IntentError: Error, CustomLocalizedStringResourceConvertible {
  case networkError
  case message(_ message: String)

  var localizedStringResource: LocalizedStringResource {
    switch self {
    case .networkError:
      "네트워크 에러 발생"
    case .message(let message):
      "에러: \(message)"
    }
  }
}
