import SwiftUI

struct DefaultRootView: View {
    var startButtonAction: (() -> Void)?

    var body: some View {
        Image(systemName: "globe")
            .imageScale(.large)
            .foregroundStyle(.tint)
        Button(action: {
            startButtonAction?()
        }, label: {
            Text("Start")
        })
    }
}

#Preview {
    DefaultRootView()
}
