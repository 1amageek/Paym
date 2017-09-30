//
//  OrderViewCell.swift
//  Paym
//
//  Created by 1amageek on 2017/09/29.
//  Copyright © 2017年 Stamp Inc. All rights reserved.
//

import UIKit

public class OrderViewCell: UITableViewCell {

    private(set) lazy var thumbnailImageView: UIImageView = {
        let view: UIImageView = UIImageView(frame: .zero)
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .green
        return view
    }()

    private(set) lazy var titleLabel: UILabel = {
        let label: UILabel = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private(set) lazy var detailLabel: UILabel = {
        let label: UILabel = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(thumbnailImageView)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(detailLabel)

        self.detailLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        self.detailLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -16).isActive = true
        self.detailLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 110).isActive = true
        self.detailLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true

        self.titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        self.titleLabel.trailingAnchor.constraint(equalTo: detailLabel.leadingAnchor, constant: -16).isActive = true

        self.thumbnailImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        self.thumbnailImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -16).isActive = true
        self.thumbnailImageView.trailingAnchor.constraint(equalTo: detailLabel.leadingAnchor, constant: -16).isActive = true
        self.thumbnailImageView.widthAnchor.constraint(equalToConstant: 32).isActive = true
        self.thumbnailImageView.heightAnchor.constraint(equalToConstant: 21).isActive = true
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func prepareForReuse() {
        super.prepareForReuse()
        self.titleLabel.text = nil
        self.detailLabel.text = nil
        self.thumbnailImageView.image = nil
    }
    public override func setSelected(_ selected: Bool, animated: Bool) {

    }

    public override func setHighlighted(_ highlighted: Bool, animated: Bool) {
//        self.backgroundColor = highlighted ? UIColor(white: 0, alpha: 0.2) : .clear
    }
}
