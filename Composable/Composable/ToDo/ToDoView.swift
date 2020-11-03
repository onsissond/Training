//
//  ToDoView.swift
//  Composable
//
//  Created by Евгений Суханов on 23.10.2020.
//

import SwiftUI
import ComposableArchitecture

struct ToDoView: View {
    let store: ToDoStore

    var body: some View {
        WithViewStore(store) { viewStore in
            HStack {
                Button(action: { viewStore.send(.toggleStatus) }) {
                    Image(
                        systemName: viewStore.isCompleted
                            ? "checkmark.square"
                            : "square"
                    )
                }
                .buttonStyle(PlainButtonStyle())

                TextField(
                    "New item",
                    text: viewStore.binding(get: \.title, send: ToDoAction.textFieldChanged)
                )
            }
            .foregroundColor(viewStore.isCompleted ? .gray : nil)
        }
    }
}

struct ToDoView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoView(store: .mock)
    }
}
