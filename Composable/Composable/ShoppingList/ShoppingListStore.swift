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
    case load
    case save
    case setupProducts([Product])
    case productAction(Int, ProductAction)
    case addProduct
    case removeProduct(IndexSet)
}

struct ShoppingListEnviroment {
    var uuidGenerator: () -> UUID
    var save: ([Product]) -> Effect<Never, Never>
    var load: () -> Effect<[Product], Never>
}

let shoppingListReducer = Reducer<ShoppingListState, ShoppingListAction, ShoppingListEnviroment>.combine(
    productReducer.forEach(
        state: \.products,
        action: /ShoppingListAction.productAction,
        environment: { _ in ProductEnviroment() }
    ),
    Reducer { state, action, env in
        switch action {
        case .load:
            return env.load().map(ShoppingListAction.setupProducts)
        case .setupProducts(let products):
            state.products = products
            return .none
        case .addProduct:
            state.products.insert(Product(
                id: env.uuidGenerator(),
                name: "",
                isInBox: false
            ), at: 0)
            return Effect(value: .save)
        case .save, .productAction(_, .save):
            return env.save(state.products).fireAndForget()
        case .removeProduct(let indexSet):
            state.products.remove(atOffsets: indexSet)
            return .none
        case .productAction:
            return .none
        }
    }.debug()
)

extension ShoppingListEnviroment {
    static var mock: ShoppingListEnviroment {
        ShoppingListEnviroment(
            uuidGenerator: { fatalError("unimplemented") },
            save: { _ in fatalError("unimplemented") },
            load: { fatalError("unimplemented") }
        )
    }
}
