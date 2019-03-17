//
//  ViewController.swift
//  UCLoadingCircle
//
//  Created by yuch on 18/3/19.
//  Copyright © 2019 Yuch. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var loadingCircle: UCLoadingCircle!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingCircle.animation = true
    }


}

