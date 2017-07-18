//
//  CartViewController.swift
//  Paym
//
//  Created by 1amageek on 2017/07/09.
//  Copyright © 2017年 Stamp Inc. All rights reserved.
//

import UIKit

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private(set) lazy var tableView: UITableView = {
        let view: UITableView = UITableView(frame: self.view.bounds, style: .plain)
        view.dataSource = self
        view.delegate = self
        view.register(UINib(nibName: "CartViewCell", bundle: nil), forCellReuseIdentifier: "CartViewCell")
        return view
    }()

    private(set) lazy var summaryView: SummaryView = {
        let view: SummaryView = SummaryView()
        return view
    }()

    private(set) lazy var paymentMethodView: PaymentMethodView = {
        let view: PaymentMethodView = PaymentMethodView()
        view.applePayBlock = {

        }
        view.otherPaymentBlock = {
            let viewController: OrderViewController = OrderViewController()
            let navigationController: OrderNavigationController = OrderNavigationController(rootViewController: viewController)
            self.addChildViewController(navigationController)
            self.view.addSubview(navigationController.view)
            navigationController.didMove(toParentViewController: self)
        }
        return view
    }()

    override func loadView() {
        super.loadView()
        self.view.addSubview(tableView)
        self.view.addSubview(summaryView)
        self.view.addSubview(paymentMethodView)
    }

    func layoutSummaryView() {
        summaryView.sizeToFit()
        let contentSize: CGSize = summaryView.bounds.size
        summaryView.frame = CGRect(x: 0, y: self.view.bounds.height - contentSize.height - self.paymentMethodView.height, width: contentSize.width, height: contentSize.height)
    }

    override func viewWillLayoutSubviews() {
        self.layoutSummaryView()
    }
    
    // MARK: -

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CartViewCell = tableView.dequeueReusableCell(withIdentifier: "CartViewCell", for: indexPath) as! CartViewCell
        return cell
    }

}
