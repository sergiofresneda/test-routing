import Foundation

public struct Module1FSM {
    public let sortedStates: [Module1State]
    public let defaultState: Module1State
    private let nextOfFinish: Module1State

    public init(sortedStates: [Module1State] = [.idle, .initial, .purchase, .purchaseStepFinished, .dismiss],
                defaultState: Module1State = .idle,
                nextOfFinish: Module1State = .initial) {
        self.sortedStates = sortedStates
        self.defaultState = defaultState
        self.nextOfFinish = nextOfFinish
    }


    public func nextStep(from currentState: Module1State) -> Module1State {
        guard let currentIndex = sortedStates.firstIndex(of: currentState),
              currentIndex < sortedStates.endIndex - 1 else {
            return nextOfFinish
        }
        return sometimesPurchaseStepIsNotNeeded(sortedStates[currentIndex + 1])
    }
}

private extension Module1FSM {
    func sometimesPurchaseStepIsNotNeeded(_ step: Module1State) -> Module1State {
        if Module1State.purchase == step && Int.random(in: 1...2).isMultiple(of: 2) {
            return .purchaseStepFinished
        }
        return step
    }
}


