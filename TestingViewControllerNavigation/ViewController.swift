//
//  ViewController.swift
//  TestingViewControllerNavigation
//
//  Created by Toshiyana on 2022/05/01.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nextViewButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func nextViewButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondViewController = storyboard.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        
        navigationController?.pushViewController(secondViewController, animated: true)
    }
    

}

