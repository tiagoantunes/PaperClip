//
//  AppCoordinator.swift
//  PaperClip
//
//  Created by Tiago Antunes on 18/02/2025.
//

import SwiftUI

class AppCoordinator: AppCoordinatorProtocol {
    @Published var path: NavigationPath = NavigationPath()

    private let remoteDataService = RemoteDataService()

    // MARK: - Navigation Functions
    func push(_ screen: Screen) {
        path.append(screen)
    }

    func pop() {
        path.removeLast()
    }

    func popToRoot() {
        path.removeLast(path.count)
    }

    // MARK: - Presentation Style Providers
    @ViewBuilder
    func build(_ screen: Screen) -> some View {
        switch screen {
        case .home:
            let dataService = DataService(remoteDataService: remoteDataService)
            HomeView(viewModel: HomeViewModel(dataService: dataService))

        case .details(let ad, let category):
            DetailsView(viewModel: DetailsViewModel(ad: ad, category: category))
        }
    }
}
