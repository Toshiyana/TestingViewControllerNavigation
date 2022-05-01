//
//  SpyNavigationController.swift
//  TestingViewControllerNavigationTests
//
//  Created by Toshiyana on 2022/05/01.
//

import UIKit

class SpyNavigationController: UINavigationController {
    
    var pushedViewController: UIViewController!
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        
        pushedViewController = viewController
    }
}
