//
//  ToDoStore.swift
//  Composable
//
//  Created by Евгений Суханов on 23.10.2020.
//

import Foundation
import ComposableArchitecture

struct ToDo: Identifiable, Equatable {
    let id: UUID
    let title: String
    var isCompleted: Bool = false
}

enum ToDoAction {
    case toggleStatus
}

struct ToDoEnviroment {}

let toDoReducer = Reducer<ToDo, ToDoAction, ToDoEnviroment> { state, action, env in
    switch action {
    case .toggleStatus:
        state.isCompleted.toggle()
    }
    return .none
}
