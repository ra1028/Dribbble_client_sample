//
//  ShotsListParentViewController.swift
//  Dribbble_client_sample
//
//  Created by Ryo Aoyama on 2/2/15.
//  Copyright (c) 2015 Ryo Aoyama. All rights reserved.
//

import UIKit

class ShotsListParentViewController:
    ViewController,
    UIPageViewControllerDelegate,
    UIPageViewControllerDataSource
{
    @IBOutlet weak var pageTitleScrollView: UIView!
    private var pageViewController: UIPageViewController!
    private var viewControllers: [UIViewController]! = []
    private var pageIndex: Int = 0
    
    override init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configure()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configurePageViewController()
        self.fillNavigationBar(color: UIColor.whiteColor())
    }
    
    private func configure() {
        self.pageViewController = UIPageViewController(
            transitionStyle: .Scroll,
            navigationOrientation: .Horizontal,
            options: nil)
        self.pageViewController.delegate = self
        self.pageViewController.dataSource = self
        
        let RecentVC = RecentShotsViewController()
        RecentVC.controllerIndex = 0
        let DebutsVC = DebutsShotsViewController()
        DebutsVC.controllerIndex = 1
        let popularVC = PopularShotsViewController()
        popularVC.controllerIndex = 2
        self.viewControllers = [RecentVC, DebutsVC, popularVC]
        
        self.pageViewController.setViewControllers(
            [RecentVC],
            direction: .Forward,
            animated: true,
            completion: nil)
    }
    
    private func configurePageViewController() {
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor(red:0.94, green:0.94, blue:0.94, alpha:1)
        
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMoveToParentViewController(self)
        
        self.view.bringSubviewToFront(self.pageTitleScrollView)
    }
    
    private func fillNavigationBar(#color: UIColor) {
        if self.navigationController == nil {
            return
        }
        
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        for view in self.navigationController!.navigationBar.subviews {
            if view.isKindOfClass(NSClassFromString("_UINavigationBarBackground")) {
                if view.isKindOfClass(UIView) {
                    (view as UIView).backgroundColor = color
                }
            }
        }
    }
    
    private func evalNextIndex(page: Int) -> Bool {
        let count = self.viewControllers.count
        if page >= count - 1 {
            return false
        }
        return true
    }
    
    private func evalPrevIndex(page: Int) -> Bool {
        if page <= 0 {
            return false
        }
        return true
    }
    
    /* Datasource */
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let afterIndex = (viewController as ShotsListViewController).controllerIndex
        if !self.evalNextIndex(afterIndex) {
            return nil
        }
        return self.viewControllers[afterIndex + 1]
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let beforeIndex = (viewController as ShotsListViewController).controllerIndex
        if !self.evalPrevIndex(beforeIndex) {
            return nil
        }
        return self.viewControllers[beforeIndex - 1]
    }
}