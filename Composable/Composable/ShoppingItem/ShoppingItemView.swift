//
//  ShoppingItemView.swift
//  Composable
//
//  Created by Евгений Суханов on 23.10.2020.
//

import SwiftUI
import ComposableArchitecture

struct ProductView: View {
    let store: ProductStore

    var body: some View {
        WithViewStore(store) { viewStore in
            HStack {
                Button(action: { viewStore.send(.toggleStatus) }) {
                    Image(
                        systemName: viewStore.isInBox
                            ? "checkmark.square"
                            : "square"
                    )
                }
                .buttonStyle(PlainButtonStyle())
                TextField(
                    "New item",
                    text: viewStore.binding(
                        get: \.name,
                        send: ProductAction.updateName
                    )
                )
            }
            .foregroundColor(viewStore.isInBox ? .gray : nil)
        }
    }
}

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        ProductView(store: .mock)
    }
}
