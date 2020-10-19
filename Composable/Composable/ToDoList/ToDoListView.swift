//
//  ToDoListView.swift
//  ComposableArchitecture
//
//  Created by Евгений Суханов on 19.10.2020.
//

import SwiftUI
import ComposableArchitecture

struct ToDoListView: View {
    let store: Store<ToDoListState, ToDoListAction>

    var body: some View {
        NavigationView {
            WithViewStore(store) { viewStore in
                List {
                    ForEach(Array(viewStore.todos.enumerated()), id: \.element.id) { index, todo in
                        HStack() {
                            Button(action: { viewStore.send(.toggleStatus(index)) }) {
                                Image(systemName: todo.isCompleted ? "checkmark.square" : "square")
                            }.buttonStyle(PlainButtonStyle())
                            TextField("Enter todo", text: .constant(todo.title))
                        }
                    }
                }.navigationTitle("My todo")
            }
        }
    }
}

struct ToDoListView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListView(store: Store<ToDoListState, ToDoListAction>(
            initialState: ToDoListState(
                todos: [
                    ToDo(id: UUID(), title: "Learn Swift", isCompleted: true),
                    ToDo(id: UUID(), title: "Read book"),
                    ToDo(id: UUID(), title: "Visit doctor")
                ]
            ),
            reducer: toDoListReducer,
            environment: ToDoListEnviroment()
        ))
    }
}
