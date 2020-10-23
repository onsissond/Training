//
//  ToDoListView.swift
//  ComposableArchitecture
//
//  Created by Евгений Суханов on 19.10.2020.
//

import SwiftUI
import ComposableArchitecture
import CasePaths

struct ToDoListView: View {
    let store: Store<ToDoListState, ToDoListAction>

    var body: some View {
        NavigationView {
            List {
                ForEachStore(
                    store.scope(
                        state: \.todos,
                        action: ToDoListAction.todoAction
                    )
                ) { toDoStore in
                    WithViewStore(toDoStore) { viewStore in
                        HStack {
                            Button(action: { viewStore.send(.toggleStatus) }) {
                                Image(systemName: viewStore.isCompleted ? "checkmark.square" : "square")
                            }.buttonStyle(PlainButtonStyle())
                            TextField("Enter todo", text: .constant(viewStore.title))
                        }
                    }
                }
            }.navigationTitle("My todo")
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
