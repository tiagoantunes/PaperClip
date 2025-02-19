//
//  PosterImageView.swift
//  PaperClip
//
//  Created by Tiago Antunes on 16/02/2025.
//

import SwiftUI

struct PosterImageView: View {
    let imageUrl: URL?
    let title: String
    let width: CGFloat

    private let imageAspectRatio: CGFloat = 1.2

    var body: some View {
        if let imageUrl {
            AsyncImage(
                url: imageUrl,
                content: { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipped()
                    } else if phase.error != nil {
                        placeholderView
                    } else {
                        ProgressView()
                            .tint(.white)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
            )
            .frame(width: width, height: width * imageAspectRatio)
        } else {
            placeholderView
                .frame(width: width, height: width)
        }
    }

    private var placeholderView: some View {
        VStack(alignment: .center, spacing: width / 10) {
            Image(systemName: "photo")
                .resizable()
                .scaledToFit()
                .foregroundColor(.white)
                .frame(width: width / 4)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
    }
}

#Preview {
    PosterImageView(
        imageUrl: URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-thumb/2c9563bbe85f12a5dcaeb2c40989182463270404.jpg"),
        title: "Statue homme noir assis en plâtre polychrome",
        width: 200
    )
}
