//
//  ShoppingListSnapshotTests.swift
//  ComposableTests
//
//  Created by Евгений Суханов on 06.11.2020.
//

import XCTest
import ComposableArchitecture
import SnapshotTesting
@testable import Composable

class ShoppingListSnapshotTests: XCTestCase {

    func testEmptyList() {
        let listView = ShoppingListView(
            store: ShoppingListStore(
                initialState: ShoppingListState(products: []),
                reducer: Reducer { _, _, _ in .none },
                environment: ShoppingListEnviroment.mock
            )
        )
        assertSnapshot(matching: listView, as: .image)
    }

    func testNewItem() {
        let listView = ShoppingListView(
            store: .mock(state: ShoppingListState(
                products: [Product(id: .mock, name: "", isInBox: false)]
            ))
        )
        assertSnapshot(matching: listView, as: .image)
    }

    func testSingleItem() {
        let listView = ShoppingListView(
            store: .mock(state: ShoppingListState(
                products: [Product(id: .mock, name: "Milk", isInBox: false)]
            ))
        )
        assertSnapshot(matching: listView, as: .image)
    }

    func testCompleteItem() {
        let listView = ShoppingListView(
            store: .mock(state: ShoppingListState(
                products: [Product(id: .mock, name: "Milk", isInBox: true)]
            ))
        )
        assertSnapshot(matching: listView, as: .image)
    }
}

extension ShoppingListStore {
    static func mock(state: ShoppingListState) -> ShoppingListStore {
        ShoppingListStore(
            initialState: state,
            reducer: Reducer { _, _, _ in .none },
            environment: ShoppingListEnviroment.mock
        )
    }
}
