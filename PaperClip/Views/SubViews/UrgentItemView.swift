//
//  UrgentItemView.swift
//  PaperClip
//
//  Created by Tiago Antunes on 17/02/2025.
//

import SwiftUI

struct UrgentItemView: View {

    private enum Constants {
        static let isUrgentImage = "bolt.badge.clock.fill"
        static let isNotUrgentImage = "bolt.badge.clock"
    }

    let isUrgent: Bool
    let size: CGFloat

    var body: some View {
        Image(systemName: isUrgent ? Constants.isUrgentImage : Constants.isNotUrgentImage)
            .resizable()
            .foregroundColor(.white)
            .shadow(color: .black, radius: 10, x: 0, y: 0)
            .frame(width: size, height: size)
    }
}

#Preview {
    UrgentItemView(isUrgent: true, size: 100)
}
