//
//  ToDoStore.swift
//  Composable
//
//  Created by Евгений Суханов on 19.10.2020.
//

import Foundation
import ComposableArchitecture

struct ToDoListState: Equatable {
    var todos: [ToDo] = []
}

enum ToDoListAction {
    case todoAction(Int, ToDoAction)
}

struct ToDoListEnviroment {}

let toDoListReducer: Reducer<ToDoListState, ToDoListAction, ToDoListEnviroment> = toDoReducer.forEach(
    state: \.todos,
    action: /ToDoListAction.todoAction,
    environment: { _ in ToDoEnviroment() }
)

typealias ToDoListStore = Store<ToDoListState, ToDoListAction>
extension ToDoListStore {
    static var mock: ToDoListStore {
        Store<ToDoListState, ToDoListAction>(
            initialState: ToDoListState(
                todos: [
                    ToDo(id: UUID(), title: "Learn Swift", isCompleted: true),
                    ToDo(id: UUID(), title: "Read book"),
                    ToDo(id: UUID(), title: "Visit doctor")
                ]
            ),
            reducer: toDoListReducer,
            environment: ToDoListEnviroment()
        )
    }
}
