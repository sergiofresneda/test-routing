import Foundation
import Module2
import SwiftUI

final class Module2Router {
    private var module2: Module2

    @Published private(set) var step: NavigationModel?
    private(set) var currentState: Module2State
    private let fsm: Module2FSM

    init(fsm: Module2FSM = Module2FSM()) {
        module2 = Module2()
        self.fsm = fsm
        currentState = fsm.defaultState

        module2.setRouter(self)
    }

    func setState(_ state: ModulesStateChange, context: Any? = nil) {
        switch state {
        case .next:
            currentState = fsm.nextStep(from: currentState)
        case .exit:
            currentState = .dismiss
        }
        handleStateChange(context: context)
    }
}

private extension Module2Router {
    func handleStateChange(context: Any? = nil) {
        switch currentState {
        case .idle:
            break

        case .initial:
            guard let value = context as? Int else {
                setState(.exit)
                return
            }
            module2.present(with: value)

        case .dismiss:
            step = nil
        }
        debugPrint("🟣 MODULE 2 FSM DID CHANGE TO: \(currentState)")
    }
}

extension Module2Router: Module2Routes {
    func present(_ view: some View, context: Any?) {
        step = NavigationModel(data: context,
                               view: view)
    }

    func dismiss() {
        setState(.exit)
    }
}
