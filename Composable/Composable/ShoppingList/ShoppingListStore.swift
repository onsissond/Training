//
//  ShoppingListStore.swift
//  Composable
//
//  Created by Евгений Суханов on 19.10.2020.
//

import Foundation
import ComposableArchitecture

struct ShoppingListState: Equatable {
    var products: [Product] = []
}

enum ShoppingListAction {
    case productAction(Int, ProductAction)
    case addProduct
}

struct ShoppingListEnviroment {}

let shoppingListReducer: Reducer<ShoppingListState, ShoppingListAction, ShoppingListEnviroment> = .combine(
    productReducer.forEach(
        state: \.products,
        action: /ShoppingListAction.productAction,
        environment: { _ in ProductEnviroment() }
    ),
    Reducer { state, action, env in
        switch action {
        case .addProduct:
            state.products.insert(Product(id: UUID(), name: "", isInBox: false), at: 0)
            return .none
        case .productAction:
            return .none
        }
    }
)

typealias ShoppingListStore = Store<ShoppingListState, ShoppingListAction>
extension ShoppingListStore {
    static var mock: ShoppingListStore {
        ShoppingListStore(
            initialState: ShoppingListState(
                products: [
                    Product(id: UUID(), name: "Learn Swift", isInBox: true),
                    Product(id: UUID(), name: "Read book"),
                    Product(id: UUID(), name: "Visit doctor")
                ]
            ),
            reducer: shoppingListReducer,
            environment: ShoppingListEnviroment()
        )
    }
}
