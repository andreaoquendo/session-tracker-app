//
//  TintColor.swift
//  SessionTracker
//
//  Created by Andrea Oquendo on 20/12/23.
//

import SwiftUI

struct TintColor: Identifiable, Equatable {
    let id: UUID = .init()
    var color: String
    var value: Color
}

var tintColors: [TintColor] = [
    .init(color: "Yellow", value: .yellow),
    .init(color: "Orange", value: .orange),
    .init(color: "Green", value: .green),
    .init(color: "Blue", value: .blue),
    .init(color: "Cyan", value: .cyan),
    .init(color: "Purple", value: .purple),
    .init(color: "Black", value: .black)
]


