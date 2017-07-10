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

    let paymentViewController: PaymentViewController = PaymentViewController()

    override func loadView() {
        super.loadView()
        self.view.addSubview(tableView)
        self.addChildViewController(self.paymentViewController)
        self.view.addSubview(self.paymentViewController.view)
        self.paymentViewController.didMove(toParentViewController: self)
    }

    func layoutPaymentView() {
        let contentSize: CGSize = self.paymentViewController.sizeToFit()
        self.paymentViewController.view.frame = CGRect(x: 0, y: self.view.bounds.height - contentSize.height, width: contentSize.width, height: contentSize.height)
    }

    override func viewWillLayoutSubviews() {
        self.layoutPaymentView()
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
