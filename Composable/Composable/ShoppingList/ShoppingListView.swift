//
//  ShoppingListView.swift
//  ComposableArchitecture
//
//  Created by Евгений Суханов on 19.10.2020.
//

import SwiftUI
import ComposableArchitecture
import CasePaths

struct ShoppingListView: View {
    let store: ShoppingListStore

    var body: some View {
        WithViewStore(store) { viewStore in
            NavigationView {
                List {
                    ForEachStore(
                        store.scope(
                            state: \.products,
                            action: ShoppingListAction.productAction
                        ),
                        content: ProductView.init
                    )
                    .onDelete(perform: { indexSet in
                        viewStore.send(.removeProduct(indexSet))
                    })
                }
                .navigationTitle("Shopping list")
                .navigationBarItems(
                    trailing: Button("Add item") {
                        viewStore.send(.addProduct)
                    }
                )
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .onAppear(perform: {
                viewStore.send(.load)
            })
            .onTapGesture {
                hideKeyboard()
            }
        }
    }
}

struct ShoppingListView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingListView(store: ShoppingListStore(
            initialState: ShoppingListState(
                products: [
                    Product(id: UUID(), name: "Chocolate", isInBox: true),
                    Product(id: UUID(), name: "Milk", isInBox: false),
                    Product(id: UUID(), name: "Tea", isInBox: false)
                ]
            ),
            reducer: shoppingListReducer,
            environment: ShoppingListEnviroment(
                uuidGenerator: UUID.init,
                save: { _ in .none },
                load: {
                    Effect(value: [
                        Product(id: UUID(), name: "Chocolate", isInBox: true),
                        Product(id: UUID(), name: "Milk", isInBox: false),
                        Product(id: UUID(), name: "Tea", isInBox: false)
                    ])
                }
            )
        ))
    }
}
