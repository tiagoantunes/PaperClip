//
//  UrgentItemView.swift
//  PaperClip
//
//  Created by Tiago Antunes on 17/02/2025.
//

import SwiftUI

struct UrgentItemView: View {

    let isUrgent: Bool
    let size: CGFloat

    var body: some View {
        Image(systemName: isUrgent ? "bolt.badge.clock.fill" : "bolt.badge.clock")
            .resizable()
            .foregroundColor(.white)
            .shadow(color: .black, radius: 10, x: 0, y: 0)
            .frame(width: size, height: size)
    }
}

#Preview {
    UrgentItemView(isUrgent: true, size: 100)
}
