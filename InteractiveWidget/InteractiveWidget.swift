//
//  InteractiveWidget.swift
//  InteractiveWidget
//
//  Created by 유재호 on 10/24/24.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {

  func placeholder(in context: Context) -> SimpleEntry {
    SimpleEntry(date: .now)
  }

  func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
    let entry = SimpleEntry(date: .now)
    completion(entry)
  }

  func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
    let timeline = Timeline(entries: [SimpleEntry(date: .now)], policy: .never)
    completion(timeline)
  }
}

struct SimpleEntry: TimelineEntry {
  let date: Date
}

struct InteractiveWidgetEntryView : View {
  let entry: Provider.Entry
  
  @AppStorage("singleNumber", store: .shared) private var singleNumber: Int = .zero
  
  var body: some View {
    Text("\(singleNumber)")
      .font(.system(size: 100, design: .serif))
      .foregroundStyle(.blue)
      .contentTransition(.numericText())
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .overlay(alignment: .bottomLeading) {
        Circle()
          .frame(width: 30, height: 30)
      }
      .overlay(alignment: .bottomTrailing) {
        Circle()
          .frame(width: 30, height: 30)
      }
  }
}

struct InteractiveWidget: Widget {
  let kind: String = "InteractiveWidget"

  var body: some WidgetConfiguration {
    StaticConfiguration(kind: kind, provider: Provider()) { entry in
      InteractiveWidgetEntryView(entry: entry)
        .containerBackground(.fill.quinary, for: .widget)
    }
    .configurationDisplayName("Let's Swift!")
    .description("앱의 경계를 넘다: Interactive Widget")
  }
}

#Preview(as: .systemSmall) {
  InteractiveWidget()
} timeline: {
  SimpleEntry(date: .now)
}
