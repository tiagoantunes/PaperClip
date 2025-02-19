//
//  ListViewCell.swift
//  PaperClip
//
//  Created by Tiago Antunes on 17/02/2025.
//

import UIKit


class ListViewCell: UITableViewCell {
    static let cellId = "AdViewCell"

    private let adImageView: UIImageView = {
        let videoImage = UIImageView()
        videoImage.translatesAutoresizingMaskIntoConstraints = false
        videoImage.layer.cornerRadius = 6
        videoImage.layer.masksToBounds = false;
        videoImage.layer.shadowOffset = CGSizeMake(0, 0);
        videoImage.layer.shadowRadius = 8;
        videoImage.layer.shadowOpacity = 0.5;
        videoImage.clipsToBounds = true
        videoImage.contentMode = .scaleAspectFit
        return videoImage
    }()

    private let adTitle: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.numberOfLines = 0
        title.adjustsFontSizeToFitWidth = true
        return title
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(adImageView)
        contentView.addSubview(adTitle)

        NSLayoutConstraint.activate([
            adImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            adImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            adImageView.heightAnchor.constraint(equalToConstant: 80),
            adImageView.widthAnchor.constraint(equalTo: adImageView.heightAnchor, multiplier: 16/9),

            adTitle.centerYAnchor.constraint(equalTo: centerYAnchor),
            adTitle.leadingAnchor.constraint(equalTo: adImageView.trailingAnchor, constant: 20),
            adTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            adTitle.heightAnchor.constraint(equalToConstant: 80)
        ])
    }

    func configure(with item: AdItem) {

        if let url = item.thumbImageUrl {
            adImageView.loadImage(from: url)
        }

        adTitle.text = item.title
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        adImageView.image = nil
        adTitle.text = nil
    }

}
