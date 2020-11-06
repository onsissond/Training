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
                }
                .navigationTitle("Shopping list")
                .navigationBarItems(
                    trailing: Button("Add item") {
                        viewStore.send(.addProduct)
                    }
                )
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

struct ShoppingListView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingListView(store: .mock)
    }
}
