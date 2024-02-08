import Foundation
import SwiftUI

public protocol Module2Routes {
    func present(_ view: some View, context: Any?)
    func dismiss()
}

public final class Module2 {
    private var router: Module2Routes!

    public init() {}

    public func setRouter(_ router: Module2Routes) {
        self.router = router
    }

    public func present(with data: Int) {
        buildUI(with: String(data))
    }
}

// MARK: - Build
private extension Module2 {
#warning("implement throw on build methods")
    func buildUI(with data: String) {
        guard let router else { return }
        router.present(Module2View(data: data, router: router), context: nil)
    }
}
