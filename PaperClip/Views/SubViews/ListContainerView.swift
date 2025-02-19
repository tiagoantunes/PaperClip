//
//  ListContainerView.swift
//  PaperClip
//
//  Created by Tiago Antunes on 17/02/2025.
//

import SwiftUI

struct ListContainerView: UIViewControllerRepresentable {
    let viewModel: ListViewModel
    @EnvironmentObject var appCoordinator: AppCoordinator

    public init(viewModel: ListViewModel) {
        self.viewModel = viewModel
    }

    func makeUIViewController(context: Context) -> ListViewController {
        ListViewController(viewModel: viewModel)
    }

    func updateUIViewController(_ uiViewController: ListViewController, context: Context) {
        uiViewController.reloadTableView()
    }
}
