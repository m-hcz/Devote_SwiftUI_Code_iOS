//
//  DevoteWidget.swift
//  DevoteWidget
//
//  Created by M H on 18/12/2021.
//

import WidgetKit
import SwiftUI
import Devote

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

// MARK: body
struct DevoteWidgetEntryView : View {
    var entry: Provider.Entry
	
	@Environment(\.widgetFamily) var widgetFamily
	var fontStyle: Font {
		if widgetFamily != .systemSmall {
			return .system(.footnote, design: .rounded)
		} else {
			return .system(.headline, design: .rounded)
		}
	}
	
	// fetching data
//	@Environment(\.managedObjectContext) private var viewContext
//
//	@FetchRequest(
//		sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
//		animation: .default)
//	private var items: FetchedResults<Item>
	
	@State private var checked = true
	@State private var unChecked = false
	
    var body: some View {
//        Text(entry.date, style: .time)
		GeometryReader { geometry in
			ZStack{
				bgGradient
				
				Image("rocket-small")
					.resizable()
					.scaledToFit()
				
				Image("logo")
					.resizable()
					.frame(
						width: widgetFamily != .systemSmall ? 56 : 30,
						height: widgetFamily != .systemSmall ? 56 : 30)
					.offset(
						x: geometry.size.width / 2 - 20,
						y: geometry.size.height / -2 + 20)
					.padding(.top, widgetFamily != .systemSmall ? 32 : 12)
					.padding(.trailing, widgetFamily != .systemSmall ? 32 : 12)
				
//				VStack(spacing: 10){
//					ToggleView(checked: $checked, text: "0")
//					ToggleView(checked: $unChecked, text: "1")
//				}
				
				HStack {
					Text("Just Do It")
						.foregroundColor(.white)
						.font(fontStyle)
						.fontWeight(.bold)
						.padding(.horizontal, 12)
						.padding(.vertical, 4)
						.background(
							Color(red: 0, green: 0, blue: 0, opacity: 0.5)
										.blendMode(.overlay)
						)
					.clipShape(Capsule())
					
					if widgetFamily != .systemSmall {
						Spacer()
					}
				} // hstack
				.padding()
				.offset(y: geometry.size.height / 2 - 24)
			} // zstack
		} // geometry
    }
}

@main
struct DevoteWidget: Widget {
    let kind: String = "DevoteWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            DevoteWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Devote Launcher")
        .description("This is an example widget.")
    }
}

struct DevoteWidget_Previews: PreviewProvider {
    static var previews: some View {
		Group {
			DevoteWidgetEntryView(entry: SimpleEntry(date: Date()))
				.previewContext(WidgetPreviewContext(family: .systemSmall))
			DevoteWidgetEntryView(entry: SimpleEntry(date: Date()))
				.previewContext(WidgetPreviewContext(family: .systemMedium))
			DevoteWidgetEntryView(entry: SimpleEntry(date: Date()))
				.previewContext(WidgetPreviewContext(family: .systemLarge))
		}
    }
}
