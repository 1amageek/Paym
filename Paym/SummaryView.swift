//
//  SummaryView.swift
//  Paym
//
//  Created by 1amageek on 2017/07/11.
//  Copyright © 2017年 Stamp Inc. All rights reserved.
//

import UIKit

public class SummaryView: UIView, UITableViewDelegate, UITableViewDataSource {

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

    public let contentInset: UIEdgeInsets = UIEdgeInsets(top: 6, left: 0, bottom: 6, right: 0)

    private(set) lazy var tableView: UITableView = {
        let view: UITableView = UITableView(frame: self.bounds, style: .plain)
        view.dataSource = self
        view.delegate = self
        view.separatorColor = .clear
        view.backgroundColor = .clear
        view.contentInset = self.contentInset
        view.decelerationRate = 0.2
        view.isScrollEnabled = false
        view.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    convenience init() {
        self.init(frame: .zero)
        _init()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        _init()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        _init()
    }

    private func _init() {
        self.backgroundColor = .clear
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableView)
        self.topAnchor.constraint(equalTo: tableView.topAnchor, constant: 0).isActive = true
        self.bottomAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 0).isActive = true
        self.leadingAnchor.constraint(equalTo: tableView.leadingAnchor, constant: 0).isActive = true
        self.trailingAnchor.constraint(equalTo: tableView.trailingAnchor, constant: 0).isActive = true
    }

    public override var intrinsicContentSize: CGSize {
        var height: CGFloat = 0
        (0..<self.tableView.numberOfSections).forEach { (section) in
            let headerHeight: CGFloat = self.tableView.delegate?.tableView?(self.tableView, heightForHeaderInSection: section) ?? 0
            let footerHeight: CGFloat = self.tableView.delegate?.tableView?(self.tableView, heightForFooterInSection: section) ?? 0
            height += headerHeight
            height += footerHeight
            (0..<self.tableView.numberOfRows(inSection: section)).forEach({ (row) in
                let rowHeight: CGFloat = self.tableView.delegate?.tableView?(self.tableView, heightForRowAt: IndexPath(row: row, section: section)) ?? 0
                height += rowHeight
            })
        }
        return CGSize(width: UIViewNoIntrinsicMetric, height: height)
    }

    // MARK: -
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return Section.values.count
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch Section(rawValue: section)! {
        case .detail: return DetailItem.values.count
        case .total: return 1
        }
    }

    public func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: .value1, reuseIdentifier: "UITableViewCell")
        cell.backgroundColor = .clear
        configure(cell: cell, at: indexPath)
        return cell
    }

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 20
    }

    public func configure(cell: UITableViewCell, at indexPath: IndexPath) {
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
