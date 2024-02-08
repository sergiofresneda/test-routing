import SwiftUI

struct BuyView: View {
    private var router: Module1Routes?
    private let sizes: Range<Int> = (1..<8)

    init(router: Module1Routes? = nil) {
        self.router = router
    }

    var body: some View {
        VStack {
            Text("Hello, User!")
            HStack {
                ForEach(sizes) { size in
                    Button {
                        router?.finishStepWithData(size)
                    } label: {
                        Text("Buy Size \(size)")
                    }
                }
            }
        }
    }
}

#Preview {
    BuyView()
}
