//
//  ToDoView.swift
//  Composable
//
//  Created by Евгений Суханов on 23.10.2020.
//

import SwiftUI
import ComposableArchitecture

struct ToDoView: View {
    let store: Store<ToDo, ToDoAction>

    var body: some View {
        WithViewStore(store) { viewStore in
            HStack {
                Button(action: { viewStore.send(.toggleStatus) }) {
                    Image(systemName: viewStore.isCompleted ? "checkmark.square" : "square")
                }.buttonStyle(PlainButtonStyle())
                TextField("Enter todo", text: .constant(viewStore.title))
            }
        }
    }
}
