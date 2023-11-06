
import SwiftUI
import Combine

@MainActor
final class ContentViewModel: ObservableObject {

    @Published var timezone = TimeZone.current.identifier

    private var cancellables = Set<AnyCancellable>()

    init() {
        NotificationCenter.default.publisher(for: .NSSystemTimeZoneDidChange)
            .sink(receiveValue: { [weak self] _ in
                self?.update()
            })
            .store(in: &cancellables)
    }

    func update() {
        timezone = TimeZone.current.identifier
    }

}

struct ContentView: View {

    @StateObject private var viewModel = ContentViewModel()

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Current timezone: \(viewModel.timezone)")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
