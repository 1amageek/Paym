//
//  SummaryView.swift
//  Paym
//
//  Created by 1amageek on 2017/07/11.
//  Copyright © 2017年 Stamp Inc. All rights reserved.
//

import UIKit

class SummaryView: UIView, UITableViewDelegate, UITableViewDataSource {

    enum Section: Int {
        case detail
        case total
        static var values: [Section] {
            return [.detail, .total]
        }
    }

    enum DetailItem: Int {
        case subtotal
        case shippingFee
        static var values: [DetailItem] {
            return [.subtotal, .shippingFee]
        }

        var text: String {
            switch self {
            case .subtotal: return "Subtotal"
            case .shippingFee: return "ShippingFee"
            }
        }
    }

    let contentInset: UIEdgeInsets = UIEdgeInsets(top: 6, left: 0, bottom: 6, right: 0)

    private(set) lazy var tableView: UITableView = {
        let view: UITableView = UITableView(frame: self.bounds, style: .plain)
        view.dataSource = self
        view.delegate = self
        view.separatorColor = .clear
        view.backgroundColor = .clear
        view.rowHeight = 20
        view.contentInset = self.contentInset
        view.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        return view
    }()

    private(set) lazy var seperateView: UIView = {
        let view: UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: 0.5))
        view.backgroundColor = UIColor.lightGray
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(tableView)
        self.addSubview(seperateView)
        self.backgroundColor = .white
    }

    convenience init() {
        let frame: CGRect = UIScreen.main.bounds
        self.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.tableView.frame = self.bounds
    }

    override func sizeToFit() {
        self.tableView.setNeedsLayout()
        self.tableView.layoutIfNeeded()
        var contentSize: CGSize = self.tableView.contentSize
        contentSize.height += self.contentInset.top + self.contentInset.bottom
        self.bounds = CGRect(origin: .zero, size: contentSize)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.values.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch Section(rawValue: section)! {
        case .detail: return DetailItem.values.count
        case .total: return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: .value1, reuseIdentifier: "UITableViewCell")
        configure(cell: cell, at: indexPath)
        return cell
    }

    func configure(cell: UITableViewCell, at indexPath: IndexPath) {
        switch Section(rawValue: indexPath.section)! {
        case .detail:
            cell.textLabel?.font = UIFont.systemFont(ofSize: 13)
            cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 13)
            let detailItem: DetailItem = DetailItem(rawValue: indexPath.item)!
            switch detailItem {
            case .subtotal:
                cell.textLabel?.text = detailItem.text
                cell.detailTextLabel?.text = "0"
            case .shippingFee:
                cell.textLabel?.text = detailItem.text
                cell.detailTextLabel?.text = "0"
            }
        case .total:
            cell.textLabel?.text = "subtotal"
            cell.detailTextLabel?.text = "sub"
        }
    }

}
