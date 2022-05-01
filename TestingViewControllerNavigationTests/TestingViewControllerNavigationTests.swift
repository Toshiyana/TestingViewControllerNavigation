//
//  TestingViewControllerNavigationTests.swift
//  TestingViewControllerNavigationTests
//
//  Created by Toshiyana on 2022/05/01.
//

import XCTest
@testable import TestingViewControllerNavigation

class TestingViewControllerNavigationTests: XCTestCase {
    
    var sut: ViewController!
    var navigationController: UINavigationController!

    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        sut = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController
        sut.loadViewIfNeeded()
        
        navigationController = UINavigationController(rootViewController: sut)
    }

    override func tearDownWithError() throws {
        sut = nil
        navigationController = nil
    }
    
    // Pattern1: use expectations to wait for push transition to complete
    func testNextViewButton_WhenTapped_SecondViewControllerIsPushed() {
        let myPredicate = NSPredicate { input, _ in
            return (input as? UINavigationController)?.topViewController is SecondViewController
        }
        
        expectation(for: myPredicate, evaluatedWith: navigationController)
        
        sut.nextViewButton.sendActions(for: .touchUpInside)
        
        waitForExpectations(timeout: 1.5) // 遷移時のanimation時間を考慮, 何回かテストしてみて時間が十分か確認
        
        // 以下の方法では、テストできない。（buttonをtapしてから遷移するまでのanimation時間を考慮していないため）
//        guard let _ = navigationController.topViewController as? SecondViewController else {
//            XCTFail()
//            return
//        }
    }
    
    // Pattern2: use loop to wait for push transition to complete
    func testNextViewButton_WhenTapped_SecondViewControllerIsPushed_V2() {
        sut.nextViewButton.sendActions(for: .touchUpInside)
        
        RunLoop.current.run(until: Date())
        
        guard let _ = navigationController.topViewController as? SecondViewController else {
            XCTFail()
            return
        }
    }

    // Pattern3: use spy object to test push navigation
    func testNextViewButton_WhenTapped_SecondViewControllerIsPushed_V3() {
        let spyNavigationController = SpyNavigationController(rootViewController: sut)
        
        sut.nextViewButton.sendActions(for: .touchUpInside)
        
        guard let _ = spyNavigationController.pushedViewController as? SecondViewController else {
            XCTFail()
            return
        }
    }
}
