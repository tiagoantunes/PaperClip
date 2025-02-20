//
//  DetailsView.swift
//  PaperClip
//
//  Created by Tiago Antunes on 16/02/2025.
//

import SwiftUI

struct DetailsView<ViewModel>: View where ViewModel: DetailsViewModel {

    private enum Constants {
        static var imageSeparatorName: String { "star.fill" }
        static var backButtonImageName: String { "arrow.backward.circle.fill" }
    }

    @EnvironmentObject var appCoordinator: AppCoordinator
    @StateObject private var viewModel: ViewModel

    init(viewModel: @autoclosure @escaping () -> ViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel())
    }

    var body: some View {
        ZStack(alignment: .topLeading) {
            detailsView
            HStack {
                backButton
            }
        }
        .navigationBarHidden(true)
    }

    private var detailsView: some View {
        ScrollView(.vertical) {
            VStack(alignment: .center, spacing: 16) {
                PosterImageView(
                    imageUrl: viewModel.smallImageUrl,
                    title: viewModel.title,
                    width: UIScreen.main.bounds.width
                )
                .shadow(color: .white.opacity(0.5), radius: 8, x: 0, y: 0)
                .clipped()

                VStack(alignment: .center, spacing: 8) {
                    Text(viewModel.title)
                        .font(.title)
                        .multilineTextAlignment(.center)

                    Rectangle().fill(.black)
                        .frame(height: 1)
                        .padding(.horizontal, 80)

                    HStack {
                        Text(viewModel.creationDate ?? "")
                        Image(systemName: Constants.imageSeparatorName).scaleEffect(0.5)
                        Text(viewModel.price)
                    }
                    .font(.caption)

                    HStack {
                        Text(viewModel.categoryName ?? "")
                        Image(systemName: Constants.imageSeparatorName).scaleEffect(0.5)
                        Text(viewModel.saleType)
                    }
                    .font(.caption)

                    HStack {
                        Text(viewModel.siretCode ?? "")
                    }
                    .font(.caption)

                    Text(viewModel.description)
                        .font(.subheadline)
                }
                .foregroundStyle(.white)
                .padding(.horizontal, 16)
            }
        }
        .ignoresSafeArea(edges: .top)
    }

    private var backButton: some View {
        Button(
            action: {
                appCoordinator.pop()
            },
            label: {
                Image(systemName: Constants.backButtonImageName)
                    .resizable()
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 10, x: 0, y: 0)
                    .frame(width: 40, height: 40)
            }
        )
        .frame(width: 48, height: 48)
        .padding(.leading, 16)
    }
}
