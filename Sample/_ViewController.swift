//
//  ViewController.swift
//  Sample
//
//  Created by 1amageek on 2017/07/09.
//  Copyright © 2017年 Stamp Inc. All rights reserved.
//

import UIKit

class _ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let paymView: PaymView = PaymView(frame: .zero)
        self.view.addSubview(paymView)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

