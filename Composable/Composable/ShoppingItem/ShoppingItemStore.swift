//
//  ShoppingItemStore.swift
//  Composable
//
//  Created by Евгений Суханов on 23.10.2020.
//

import Foundation
import ComposableArchitecture

struct Product: Identifiable, Equatable {
    let id: UUID
    var name: String
    var isInBox: Bool = false
}

enum ProductAction {
    case toggleStatus
    case updateName(String)
}

struct ProductEnviroment {}

let productReducer = Reducer<Product, ProductAction, ProductEnviroment> { state, action, env in
    switch action {
    case .toggleStatus:
        state.isInBox.toggle()
        return .none
    case .updateName(let newName):
        state.name = newName
        return .none
    }
}

typealias ProductStore = Store<Product, ProductAction>
extension ProductStore {
    static var mock: ProductStore {
        ProductStore(
            initialState: Product(id: UUID(), name: "Learn Swift", isInBox: true),
            reducer: productReducer,
            environment: ProductEnviroment()
        )
    }
}
