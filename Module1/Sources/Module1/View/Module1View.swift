import SwiftUI

struct Module1View: View {
    private var router: Module1Routes?

    init(router: Module1Routes? = nil) {
        self.router = router
    }

    var body: some View {
        VStack {
            Text("Hello, Module 1")
            Button(action: {
                router?.dismiss()
            }, label: {
                Text("Close Module 1")
            })
            Button(action: {
                router?.startPurchaseFlow()
            }, label: {
                Text("Purchase flow")
            })
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action : {
            self.router?.dismiss()
        }){
            Image(systemName: "arrow.left")
        })

        .padding()
    }
}

#Preview {
    Module1View()
}
