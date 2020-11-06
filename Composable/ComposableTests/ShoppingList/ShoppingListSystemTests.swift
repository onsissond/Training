//
//  ShoppingListSystemTests.swift
//  ComposableTests
//
//  Created by Евгений Суханов on 06.11.2020.
//

import XCTest
import ComposableArchitecture
@testable import Composable

class ShoppingListSystemTests: XCTestCase {

    func testAddProduct() {
        let store = TestStore(
            initialState: ShoppingListState(),
            reducer: shoppingListReducer,
            environment: ShoppingListEnviroment(
                uuidGenerator: { UUID(uuidString: "00000000-0000-0000-0000-000000000000")! }
            )
        )
        store.assert(
            .send(.addProduct) {
                $0.products = [
                    Product(
                        id: UUID(uuidString: "00000000-0000-0000-0000-000000000000")!,
                        name: "",
                        isInBox: false
                    )
                ]
            }
        )
    }

    func testRemoveProduct() {
        let store = TestStore(
            initialState: ShoppingListState(
                products: [Product(id: .mock, name: "Milk", isInBox: false)]
            ),
            reducer: shoppingListReducer,
            environment: .mock
        )
        store.assert(
            .send(.removeProduct(IndexSet(integer: 0))) {
                $0.products = []
            }
        )
    }
}

extension UUID {
    static var mock: UUID {
        UUID(uuidString: "00000000-0000-0000-0000-000000000000")!
    }
}
