//
//  GridView.swift
//  PaperClip
//
//  Created by Tiago Antunes on 16/02/2025.
//

import SwiftUI

struct GridView<ViewModel>: View where ViewModel: HomeViewModelProtocol {
    @EnvironmentObject var appCoordinator: AppCoordinator
    @StateObject private var viewModel: ViewModel

    init(viewModel: @autoclosure @escaping () -> ViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel())
    }

    private let spacing: CGFloat = 16

    private let size: CGFloat = 160  // min width

    private var columns: [GridItem] {
      return [
        .init(.adaptive(minimum: size, maximum: .infinity))
      ]
    }

    var body: some View {
        ScrollView(.vertical) {
            LazyVGrid(
                columns: columns,
                spacing: spacing,
                content: {
                    ForEach(Array(viewModel.ads.enumerated()), id: \.offset) { index, ad in
                        Button(
                            action: {
                                appCoordinator.push(
                                    .details(
                                        ad: ad,
                                        category: viewModel.categoryFor(id: ad.categoryId)
                                    )
                                )
                            },
                            label: {
                                ZStack(alignment: .topTrailing) {
                                    posterImage(index: index, ad: ad)
                                    detailsBar(index: index, ad: ad, category: viewModel.categoryFor(id: ad.categoryId))
                                    if ad.isUrgent {
                                        UrgentItemView(isUrgent: ad.isUrgent, size: 30)
                                            .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 5))
                                    }
                                }
                            }
                        )
                    }
                }
            )
            .padding(.horizontal, 16)
        }
    }

    private func posterImage(index: Int, ad: AdItem) -> some View {
        PosterImageView(
            imageUrl: ad.smallImageUrl,
            title: ad.title,
            width: size
        )
        .frame(width: size)
        .cornerRadius(6)
        .shadow(color: .white.opacity(0.5), radius: 8, x: 0, y: 0)
        .overlay {
            RoundedRectangle(cornerRadius: 6)
                .stroke(.white.opacity(0.5), lineWidth: 1)
        }
    }

    private func detailsBar(index: Int, ad: AdItem, category: AdCategory?) -> some View {
        VStack {
            Spacer()
            InfoBarView(
                title: ad.title,
                category: category?.name ?? "",
                price: String(format: Strings.productPrice, ad.price)
            )
            .frame(width: size)
            .clipShape(
                .rect(
                    topLeadingRadius: 0,
                    bottomLeadingRadius: 6,
                    bottomTrailingRadius: 6,
                    topTrailingRadius: 0
                )
            )
        }
    }
}
