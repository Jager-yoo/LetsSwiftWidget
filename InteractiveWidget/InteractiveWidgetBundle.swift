//
//  InteractiveWidgetBundle.swift
//  InteractiveWidget
//
//  Created by 유재호 on 10/24/24.
//

import WidgetKit
import SwiftUI

@main
struct InteractiveWidgetBundle: WidgetBundle {
  
  var body: some Widget {
    InteractiveWidget()
    InteractiveLockScreenWidget()
  }
}
