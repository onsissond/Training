//
//  ContentView.swift
//  ComposableArchitecture
//
//  Created by Евгений Суханов on 19.10.2020.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ToDoListView(store: .mock)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
