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
            state.products.insert(Product(), at: 0)
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
                    Product(name: "Chocolate", isInBox: true),
                    Product(name: "Milk"),
                    Product(name: "Tea")
                ]
            ),
            reducer: shoppingListReducer,
            environment: ShoppingListEnviroment()
        )
    }
}


