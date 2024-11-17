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
  @AppStorage("widgetShowsResult", store: .shared) private var widgetShowsResult: Bool = false

  var body: some View {
    if widgetShowsResult {
      Button(intent: ResetIntent()) {
        ZStack {
          Color.green.opacity(0.5)

          VStack {
            Text("숫자 변경 성공")

            Text("It's **'\(singleNumber)'** now")
              .font(.system(size: 26, design: .rounded))
          }
        }
      }
      .buttonStyle(.plain)
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .transition(.blurReplace)
    } else {
      Text("\(singleNumber)")
        .font(.system(size: 100, design: .rounded))
        .foregroundStyle(.blue)
        .invalidatableContent()
        // .monospacedDigit() // 글자 흔들리는 걸 막고 싶다면
        .contentTransition(
          .numericText(value: Double(singleNumber))
        )
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .top) {
          timer
        }
        .overlay(alignment: .bottomTrailing) {
          Button(intent: NumberUpIntent()) {
            Image(systemName: "plus")
              .frame(width: 20, height: 20)
          }
          .buttonBorderShape(.circle)
          .padding(8)
        }
        .overlay(alignment: .bottomLeading) {
          Toggle(isOn: false, intent: NumberDownIntent()) {
            Image(systemName: "minus")
              .frame(width: 20, height: 20)
          }
          .buttonBorderShape(.circle)
          .padding(8)
        }
    }
  }

  private var timer: some View {
    Text(entry.date, style: .relative)
      .font(.system(size: 20, design: .rounded))
      .multilineTextAlignment(.center)
  }
}

struct LockScreenWidgetView: View {
  let entry: Provider.Entry

  @AppStorage("singleNumber", store: .shared) private var singleNumber: Int = .zero
  @AppStorage("widgetShowsResult", store: .shared) private var widgetShowsResult: Bool = false

  var body: some View {
    if widgetShowsResult {
      Button(intent: ResetIntent()) {
        ZStack {
          RoundedRectangle(cornerRadius: 16)
            .fill(Color.green.opacity(0.5))

          VStack {
            Text("숫자 변경 성공")

            Text("It's **'\(singleNumber)'** now")
              .font(.system(size: 24, design: .rounded))
          }
        }
      }
      .buttonStyle(.plain)
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .transition(.blurReplace)
    } else {
      HStack {
        Button(intent: NumberDownIntent()) {
          Image(systemName: "minus")
            .frame(width: 20, height: 20)
        }
        .buttonBorderShape(.circle)
        .padding(4)

        Spacer()

        Text("\(singleNumber)")
          .font(.system(size: 32, design: .rounded))
          .invalidatableContent()
          .contentTransition(
            .numericText(value: Double(singleNumber))
          )

        Spacer()

        Button(intent: NumberUpIntent()) {
          Image(systemName: "plus")
            .frame(width: 20, height: 20)
        }
        .buttonBorderShape(.circle)
        .padding(4)
      }
    }
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

struct InteractiveLockScreenWidget: Widget {
  let kind: String = "InteractiveLockScreenWidget"

  var body: some WidgetConfiguration {
    StaticConfiguration(kind: kind, provider: Provider()) { entry in
      LockScreenWidgetView(entry: entry)
        .containerBackground(.fill.quinary, for: .widget)
    }
    .configurationDisplayName("Let's Swift!")
    .description("앱의 경계를 넘다: Interactive Widget")
    .supportedFamilies([.accessoryRectangular])
  }
}

#Preview(as: .systemSmall) {
  InteractiveWidget()
} timeline: {
  SimpleEntry(date: .now)
}
