import Foundation
import Module1
import SwiftUI

final class Module1Router {
    private var module1: Module1

    @Published private(set) var step: NavigationModel?
    private(set)var currentState: Module1State
    private let fsm: Module1FSM

    init(fsm: Module1FSM = Module1FSM()) {
        module1 = Module1()
        self.fsm = fsm
        currentState = fsm.defaultState

        module1.setRouter(self)
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
private extension Module1Router {
    func handleStateChange(context: Any? = nil) {
        switch currentState {
        case .idle:
            break
        case .initial:
            module1.presentRoot()
        case .purchase:
            module1.presentBuy()
        case .purchaseStepFinished:
            /// This view paremeter here must be improved, this `AnyView` is not needed
            step = NavigationModel(data: context, view: AnyView(_fromValue: ""))
        case .dismiss:
            step = nil
        }

        debugPrint("🔴 MODULE 1 FSM DID CHANGE TO: \(currentState)")
    }
}
extension Module1Router: Module1Routes {
    func present(_ view: some View, context: Any?) {
        step = NavigationModel(data: context, view: view)
    }

    func startPurchaseFlow() {
        setState(.next)
    }

    func finishStepWithData(_ data: Int) {
        setState(.next, context: data)
    }

    func dismiss() {
        setState(.exit)
    }
}
