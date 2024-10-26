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

struct InteractiveWidgetView: View {
  let entry: Provider.Entry
  
  @AppStorage("singleNumber", store: .shared) private var singleNumber: Int = .zero
  
  var body: some View {
    Text("\(singleNumber)")
      .font(.system(size: 100, design: .serif))
      .foregroundStyle(.blue)
      // .monospacedDigit() // 글자 흔들리는 걸 막고 싶다면
      .contentTransition(
        .numericText(value: Double(singleNumber))
      )
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .overlay(alignment: .bottomTrailing) {
        Button(intent: NumberUpIntent()) {
          Image(systemName: "plus")
            .frame(width: 20, height: 20)
        }
        .buttonBorderShape(.circle)
        .padding(8)
      }
      .overlay(alignment: .bottomLeading) {
        Button(intent: NumberDownIntent()) {
          Image(systemName: "minus")
            .frame(width: 20, height: 20)
        }
        .buttonBorderShape(.circle)
        .padding(8)
      }
  }

  private var timer: some View {
    Text(entry.date, style: .relative)
      .font(.system(size: 60, design: .serif))
      .multilineTextAlignment(.center)
  }
}

struct InteractiveWidget: Widget {
  let kind: String = "InteractiveWidget"

  var body: some WidgetConfiguration {
    StaticConfiguration(kind: kind, provider: Provider()) { entry in
      InteractiveWidgetView(entry: entry)
        .containerBackground(.fill.quinary, for: .widget)
    }
    .configurationDisplayName("Let's Swift!")
    .description("앱의 경계를 넘다: Interactive Widget")
    .contentMarginsDisabled()
  }
}

#Preview(as: .systemSmall) {
  InteractiveWidget()
} timeline: {
  SimpleEntry(date: .now)
}
