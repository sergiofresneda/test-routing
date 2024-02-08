import SwiftUI

struct ContentView: View {
    @StateObject private var mainCoordinator: MainCoordinator = MainCoordinator()
    @Environment(\.scenePhase) private var scenePhase
    
    @State private var dismissModalAction: (() -> Void)?

    var body: some View {
        NavigationStack(path: $mainCoordinator.path) {
            VStack {
                if let currentView = mainCoordinator.currentView {
                    AnyView(currentView)
                    Text(String(describing: mainCoordinator.path))
                        .font(.footnote)
                        .padding()
                }
            }
            .navigationDestination(for: NavigationModel.self, 
                                   destination: { model in
                AnyView(model.view)
                    .interactiveDismissDisabled()
            })
            .sheet(item: $mainCoordinator.modal,
                   content: { modal in
                AnyView(modal.view)
                    .interactiveDismissDisabled()
            })

        }
        .onChange(of: scenePhase) { phase in
            switch phase {
            case .active:
                debugPrint("active")
            case .inactive:
                debugPrint("inactive")
            case .background:
                debugPrint("background")
            @unknown default:
                debugPrint("unknown")
            }
        }
    }
}

#Preview {
    ContentView()
}
