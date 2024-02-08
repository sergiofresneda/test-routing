import Foundation

struct Module2FSM {
    let sortedStates: [Module2State] = [.idle, .initial, .dismiss]
    let defaultState: Module2State = .idle
    private var nextOfFinish: Module2State = .initial

    func nextStep(currentState: Module2State) -> Module2State {
        guard let index = sortedStates.firstIndex(where: { $0 == currentState }),
              index >= sortedStates.startIndex && (sortedStates.endIndex - 1) > index else {
            return nextOfFinish
        }
        return sortedStates[index + 1]
    }
}
