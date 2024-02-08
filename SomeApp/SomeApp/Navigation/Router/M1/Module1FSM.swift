import Foundation

struct Module1FSM {
    let sortedStates: [Module1State] = [.idle, .initial, .purchase, .purchaseStepFinished, .dismiss]
    let defaultState: Module1State = .idle
    private var nextOfFinish: Module1State = .initial

    func nextStep(currentState: Module1State) -> Module1State {
        guard let index = sortedStates.firstIndex(where: { $0 == currentState }),
              index >= sortedStates.startIndex && (sortedStates.endIndex - 1) > index else {
            return nextOfFinish
        }
        return sortedStates[index + 1]
    }
}
