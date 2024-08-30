import SwiftUI

@main
struct MoonshotSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            MainView(viewMode: MainViewModel())
        }
    }
}
