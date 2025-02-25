//
//  HomeView.swift
//  PaperClip
//
//  Created by Tiago Antunes on 16/02/2025.
//

import SwiftUI

struct HomeView<ViewModel>: View where ViewModel: HomeViewModelProtocol {
    @EnvironmentObject var appCoordinator: AppCoordinator
    @StateObject private var viewModel: ViewModel

    init(viewModel: @autoclosure @escaping () -> ViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel())
    }

    var body: some View {
        ZStack {
            if viewModel.isDataLoading {
                LoadingView()
            } else {
                contentView
            }
        }
        .navigationTitle(viewModel.navigationBarTitle)
        .searchable(text: $viewModel.searchText, prompt: Strings.searchPrompt)

        .task {
            await viewModel.fetchAdsData()
        }

        .alert(Strings.Alert.title, isPresented: $viewModel.showAlert) {
            Button(Strings.Alert.buttonTitle, role: .cancel) {
                viewModel.onTryAgain()
            }
        }
    }

    @ViewBuilder private var contentView: some View {
        if viewModel.isSearchActive {
            ListContainerView(delegate: self, dataSource: self)
        } else {
            GridView(viewModel: viewModel)
        }
    }
}

#Preview {
    HomeView(
        viewModel: HomeViewModel(
            dataService: DataService(
                remoteDataService: RemoteDataService()
            )
        )
    )
    .preferredColorScheme(.dark)
}


extension HomeView: ListViewDataSource {
    func numberOfRowsInSection() -> Int {
        viewModel.searchAds.count
    }

    func elementForIndex(indexpath: IndexPath) -> AdItem {
        viewModel.searchAds[indexpath.row]
    }
}

extension HomeView: ListViewDelegate {
    func didSelectElement(indexpath: IndexPath) {
        let ad = viewModel.ads[indexpath.row]
        appCoordinator.push(
            .details(
                ad: ad,
                category: viewModel.categoryFor(id: ad.categoryId)
            )
        )
    }
}
