//
//  AdCategory.swift
//  PaperClip
//
//  Created by Tiago Antunes on 17/02/2025.
//

import Foundation

struct AdCategory: Codable, Identifiable {
    private enum CodingKeys: String, CodingKey {
        case id
        case name
    }

    let id: Int
    let name: String

    init(
        id: Int,
        name: String
    ) {
        self.id = id
        self.name = name
    }
}

extension AdCategory: Equatable, Hashable {
    static func == (lhs: AdCategory, rhs: AdCategory) -> Bool {
        lhs.id == lhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
}
