//
//  ViewController.swift
//  LinkedLabelDemo
//
//  Created by Leo Zhou on 2018/5/6.
//  Copyright © 2018年 Wiredcraft. All rights reserved.
//

import UIKit
import LinkedLabel

class ViewController: UIViewController {

    @IBOutlet weak var label: LinkedLabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        label.addLinks([
            (string: "Ut enim ad minim veniam", attributes: [.foregroundColor: UIColor.red], action: { print($0) }),
            (string: "Duis aute irure dolor in reprehenderit", attributes: [.foregroundColor: UIColor.green], action: { print($0) }),
            (string: "Excepteur sint occaecat cupidatat non proident", attributes: [.foregroundColor: UIColor.blue], action: { print($0) })
        ])
    }

}
