import Foundation
import SwiftUI

struct NavigationModel: Equatable, Hashable, Identifiable {
    static func == (lhs: NavigationModel, rhs: NavigationModel) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    var id: UUID = UUID()
    var data: Any?
    var view: any View
}
