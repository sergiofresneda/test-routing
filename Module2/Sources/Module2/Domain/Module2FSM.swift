import Foundation

public struct Module2FSM {
    public let sortedStates: [Module2State]
    public let defaultState: Module2State
    private let nextOfFinish: Module2State

    public init(sortedStates: [Module2State] = [.idle, .initial, .dismiss],
                defaultState: Module2State = .idle,
                nextOfFinish: Module2State = .initial) {
        self.sortedStates = sortedStates
        self.defaultState = defaultState
        self.nextOfFinish = nextOfFinish
    }

    public func nextStep(from currentState: Module2State) -> Module2State {
        guard let currentIndex = sortedStates.firstIndex(of: currentState),
              currentIndex < sortedStates.endIndex - 1 else {
            return nextOfFinish
        }
        return sortedStates[currentIndex + 1]
    }
}
