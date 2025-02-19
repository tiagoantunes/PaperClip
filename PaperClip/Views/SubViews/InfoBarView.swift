//
//  InfoBarView.swift
//  PaperClip
//
//  Created by Tiago Antunes on 17/02/2025.
//

import SwiftUI

struct InfoBarView: View {
    let title: String
    let category: String
    let price: String

    var body: some View {
        HStack {
            Spacer()
            VStack {
                Text(title)
                    .foregroundStyle(.white)
                    .font(.system(size: 15))
                    .padding(.bottom, 5)
                    .lineLimit(3)
                HStack {
                    Text(category)
                        .foregroundStyle(.white)
                        .font(.system(size: 12, weight: .light))
                        .lineLimit(1)
                        .padding(.bottom, 5)
                    Text(price)
                        .foregroundStyle(.white)
                        .font(.system(size: 12, weight: .light))
                        .lineLimit(1)
                        .padding(.bottom, 5)
                }
            }
            .padding(5)
            Spacer()
        }
        .background(Color.black.opacity(0.7))
    }
}

#Preview {
    InfoBarView(
        title: "Statue homme noir assis en plâtre polychrome",
        category: "Véhicule",
        price: "140.00 €"
    )
}
