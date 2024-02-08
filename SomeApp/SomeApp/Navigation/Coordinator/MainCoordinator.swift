import Foundation
import SwiftUI
import Combine

final class MainCoordinator: ObservableObject {

    private var m1Router = Module1Router()
    private var m2Router = Module2Router()
    
    private var cancellables: Set<AnyCancellable> = []
    
    @Published var path: NavigationPath
    @Published var currentView: (any View)!
    @Published var modal: NavigationModel?
    
    init() {
        self.path = NavigationPath()
        self.currentView = DefaultRootView(startButtonAction: {
            self.start()
        })
        bindM1()
        bindM2()
    }
    
    func start() {
        m1Router.setState(.next)
    }
    
    func bindM1() {
        m1Router
            .$step
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { step in
                self.handleNewM1Step(step)
            })
            .store(in: &cancellables)
    }
    func bindM2() {
        m2Router
            .$step
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { step in
                self.handleNewM2Step(step)
            })
            .store(in: &cancellables)
    }
    
    func dismissModal(_ model: NavigationModel) {
        m2Router.setState(.exit)
    }
}

private extension MainCoordinator {
    func handleNewM1Step(_ step: NavigationModel?) {
        switch m1Router.currentState {
        case .idle:
            break

        case .initial:
            guard let step else { return }
            addElementToStack(step)

        case .purchase:
            guard let step else { return }
            modal = step

        case .purchaseStepFinished:
            m2Router.setState(.next, context: step?.data ?? 0)
        case .dismiss:
            removeLastElementFromStack()
        }
    }

    func handleNewM2Step(_ step: NavigationModel?) {
        switch m2Router.currentState {
        case .idle:
            break

        case .initial:
            modal = step

        case .dismiss:
            modal = nil
            m1Router.setState(.exit)
        }
    }
}

// MARK: - Navigation
private extension MainCoordinator {
    func addElementToStack(_ element: NavigationModel) {
        path.append(element)
    }

    func removeLastElementFromStack() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }

    func removeAll() {
        path = NavigationPath()
    }

    func setNewRootElement(_ element: NavigationModel) {
        path = NavigationPath([element])
    }
}
