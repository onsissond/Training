//
//  View+.swift
//  Composable
//
//  Created by Евгений Суханов on 09.11.2020.
//

#if canImport(SwiftUI)
import SwiftUI

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil, 
            from: nil,
            for: nil
        )
    }
}
#endif
