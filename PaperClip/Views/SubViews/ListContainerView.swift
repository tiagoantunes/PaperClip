//
//  ListContainerView.swift
//  PaperClip
//
//  Created by Tiago Antunes on 17/02/2025.
//

import SwiftUI

protocol ListViewDataSource {
    func numberOfRowsInSection() -> Int
    func elementForIndex(indexpath: IndexPath) -> AdItem
}

protocol ListViewDelegate {
    func didSelectElement(indexpath: IndexPath)
}

struct ListContainerView: UIViewControllerRepresentable {
    private let delegate: ListViewDelegate
    private let dataSource: ListViewDataSource

    init(
        delegate: ListViewDelegate,
        dataSource: ListViewDataSource
    ) {
        self.delegate = delegate
        self.dataSource = dataSource
    }

    func makeUIViewController(context: Context) -> ListViewController {
        ListViewController(delegate: delegate, dataSource: dataSource)
    }

    func updateUIViewController(_ uiViewController: ListViewController, context: Context) {
        uiViewController.reloadTableView()
    }
}

