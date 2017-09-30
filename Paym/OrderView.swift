//
//  OrderView.swift
//  Paym
//
//  Created by 1amageek on 2017/09/27.
//  Copyright © 2017年 Stamp Inc. All rights reserved.
//

import UIKit

class OrderView: UIView {

    public weak var delegate: UITableViewDelegate? {
        set {
            self.tableView.delegate = newValue
        }
        get {
            return self.tableView.delegate
        }
    }

    public weak var dataSource: UITableViewDataSource? {
        set {
            self.tableView.dataSource = newValue
        }
        get {
            return self.tableView.dataSource
        }
    }

    private(set) lazy var tableView: UITableView = {
        let view: UITableView = UITableView(frame: .zero, style: .plain)
        view.contentInset = UIEdgeInsetsMake(0, 0, 100, 0)
        view.register(OrderViewCell.self, forCellReuseIdentifier: "OrderViewCell")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundView = nil
        view.backgroundColor = .clear
        view.rowHeight = UITableViewAutomaticDimension
        return view
    }()

    public let blurView: UIVisualEffectView = {
        let view: UIVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .extraLight))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 0
        return view
    }()

    private(set) lazy var paymentButtonView: PaymentButtonView = {
        let view: PaymentButtonView = PaymentButtonView()
        view.paymentBlock = {

        }
        return view
    }()

    public convenience init() {
        self.init(frame: .zero)
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        _init()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        _init()
    }

    private func _init() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(blurView)
        self.blurView.contentView.addSubview(tableView)
        blurView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        blurView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        blurView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        blurView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        tableView.leadingAnchor.constraint(equalTo: blurView.leadingAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: blurView.trailingAnchor, constant: 0).isActive = true
        tableView.topAnchor.constraint(equalTo: blurView.topAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: blurView.bottomAnchor, constant: 0).isActive = true
    }

    public override func didMoveToSuperview() {
        super.didMoveToSuperview()
        if !self.translatesAutoresizingMaskIntoConstraints {
            guard let superView: UIView = self.superview else { return }
            superView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
            superView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
            superView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
            superView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        }
    }

    public override var intrinsicContentSize: CGSize {
        let height: CGFloat = self.tableView.contentSize.height + self.tableView.contentInset.top + self.tableView.contentInset.bottom
        return CGSize(width: UIViewNoIntrinsicMetric, height: height)
    }
}
