//
//  AppCoordinatorProtocol.swift
//  PaperClip
//
//  Created by Tiago Antunes on 18/02/2025.
//

import SwiftUI

protocol AppCoordinatorProtocol: ObservableObject {
    var path: NavigationPath { get set }
    func push(_ screen:  Screen)
    func pop()
    func popToRoot()
}

enum Screen: Identifiable, Hashable {
    case home
    case details(ad: AdItem, category: AdCategory?)

    var id: Self { return self }
}
