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
        var savedProducts: [Product] = []
        var numberOfSaves = 0
        let store = TestStore(
            initialState: ShoppingListState(products: []),
            reducer: shoppingListReducer,
            environment: ShoppingListEnviroment(
                uuidGenerator: { .mock },
                save: { products in Effect.fireAndForget { savedProducts = products; numberOfSaves += 1 } },
                load: { Effect(value: [Product(id: .mock, name: "Milk", isInBox: false)]) }
            )
        )
        store.assert(
            .send(.load),
            .receive(.setupProducts([Product(id: .mock, name: "Milk", isInBox: false)])) {
                $0.products = [
                    Product(id: .mock, name: "Milk", isInBox: false)
                ]
            },
            .send(.addProduct) {
                $0.products = [
                    Product(id: .mock, name: "", isInBox: false),
                    Product(id: .mock, name: "Milk", isInBox: false)
                ]
            },
            .receive(.save),
            .do {
                XCTAssertEqual(savedProducts, [
                    Product(id: .mock, name: "", isInBox: false),
                    Product(id: .mock, name: "Milk", isInBox: false)
                ])
            },
            .send(.productAction(0, .updateName("Banana"))) {
                $0.products = [
                    Product(id: .mock, name: "Banana", isInBox: false),
                    Product(id: .mock, name: "Milk", isInBox: false)
                ]
            },
            .send(.save),
            .do {
                XCTAssertEqual(savedProducts, [
                    Product(id: .mock, name: "Banana", isInBox: false),
                    Product(id: .mock, name: "Milk", isInBox: false)
                ])
            }
        )
        XCTAssertEqual(numberOfSaves, 2)
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
