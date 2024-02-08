import SwiftUI

struct Module2View: View {
    private var router: Module2Routes?

    init(data: String,
         router: Module2Routes? = nil) {
        self.data = data
        self.router = router
    }

    var data: String

    var body: some View {
        VStack {
            Text("Purchase \(data) 🎉🎉🎉")
        }
        .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .global)
            .onEnded({ value in
                guard value.translation.height > 0 else { return }
                router?.dismiss()
            })
        )
    }
}

#Preview {
    Module2View(data: "Test")
}

//extension DragGesture {
//    func onSwipeDown(do action: @escaping (() -> Void)) -> _EndedGesture<Self> {
//        self
//    }
//}
