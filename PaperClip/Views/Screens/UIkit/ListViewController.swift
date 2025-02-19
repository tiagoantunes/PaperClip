//
//  ListViewController.swift
//  PaperClip
//
//  Created by Tiago Antunes on 17/02/2025.
//

import UIKit

final class ListViewController: UIViewController {

    let viewModel: ListViewModel

    init(viewModel: ListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .clear
        table.rowHeight = 100
        table.separatorStyle = .none
        table.register(ListViewCell.self, forCellReuseIdentifier: ListViewCell.cellId)
        return table
    }()

    //private lazy var videoList = Videos()

    override func loadView() {
        super.loadView()
        setup()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func reloadTableView() {
        tableView.reloadData()
    }
}

private extension ListViewController {
    func setup() {
        // add subview
        view.addSubview(tableView)

        tableView.dataSource = self
        tableView.delegate = self

        // add constraints
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.ads.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.row < viewModel.ads.count else {
            Logger.log(error: "Index out of bounds: \(indexPath.row)")
            return UITableViewCell()
        }

        let ad = viewModel.ads[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: ListViewCell.cellId, for: indexPath) as! ListViewCell

        cell.configure(with: ad)

        return cell
    }
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.didSelectAd(for: viewModel.ads[indexPath.row])
    }
}
