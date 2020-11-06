//
//  ShoppingListStore.swift
//  Composable
//
//  Created by Евгений Суханов on 19.10.2020.
//

import Foundation
import ComposableArchitecture

typealias ShoppingListStore = Store<ShoppingListState, ShoppingListAction>

struct ShoppingListState: Equatable {
    var products: [Product] = []
}

enum ShoppingListAction: Equatable {
    case productAction(Int, ProductAction)
    case addProduct
    case removeProduct(IndexSet)
}

struct ShoppingListEnviroment {
    var uuidGenerator: () -> UUID
}

let shoppingListReducer: Reducer<ShoppingListState, ShoppingListAction, ShoppingListEnviroment> = .combine(
    productReducer.forEach(
        state: \.products,
        action: /ShoppingListAction.productAction,
        environment: { _ in ProductEnviroment() }
    ),
    Reducer { state, action, env in
        switch action {
        case .addProduct:
            state.products.insert(
                Product(
                    id: env.uuidGenerator(),
                    name: "",
                    isInBox: false
                ),
                at: 0
            )
            return .none
        case .removeProduct(let indexSet):
            state.products.remove(atOffsets: indexSet)
            return .none
        case .productAction:
            return .none
        }
    }
)

extension ShoppingListEnviroment {
    static var mock: ShoppingListEnviroment {
        ShoppingListEnviroment(
            uuidGenerator: { fatalError("unimplemented") }
        )
    }
}
