import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), timezone: "Europe/Warsaw")
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), timezone: TimeZone.current.identifier)
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let entry = SimpleEntry(date: Date(), timezone: TimeZone.current.identifier)
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let timezone: String
}

struct TimeZoneWidgetEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        VStack {
            Text("Time:")
            Text(entry.date, style: .time)
            
            Text("Time Zone:")
            Text(entry.timezone)
        }
    }
}

struct TimeZoneWidget: Widget {
    let kind: String = "TimeZoneWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            TimeZoneWidgetEntryView(entry: entry)
                .padding()
                .background(.black)
        }
        .configurationDisplayName("Current TimeZone Widget")
        .description("This is an widget displaying current timezone")
    }
}

#Preview(as: .systemSmall) {
    TimeZoneWidget()
} timeline: {
    SimpleEntry(date: .now, timezone: TimeZone.current.identifier)
}
