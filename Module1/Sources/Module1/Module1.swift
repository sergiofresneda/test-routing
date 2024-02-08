import Foundation
import SwiftUI

public protocol Module1Routes {
    func present(_ view: some View, context: Any?)
    func startPurchaseFlow()
    func finishStepWithData(_ data: Int)
    func dismiss()
}

public final class Module1 {
    private var router: Module1Routes!

    public init() {
    }

    public func setRouter(_ router: Module1Routes) {
        self.router = router
    }

    public func presentRoot() {
        buildUI()
    }

    public func presentBuy() {
        buildBuyUI()
    }
}

// MARK: - Build
private extension Module1 {
#warning("implement throw on build methods")
    func buildUI() {
        guard let router else { return }
        router.present(Module1View(router: router), context: nil)
    }

    func buildBuyUI() {
        guard let router else { return }
        router.present(BuyView(router: router), context: nil)
    }
}
