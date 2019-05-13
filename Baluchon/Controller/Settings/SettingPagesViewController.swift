//
//  SettingPagesViewController.swift
//  Baluchon
//
//  Created by Nicolas Sommereijns on 09/05/2019.
//  Copyright © 2019 Nicolas Sommereijns. All rights reserved.
//

import UIKit

// This ViewController handle the page navigation
// between all of the settings

class SettingPagesViewController: UIPageViewController {

    // MARK: private properties

    // Array of all the ViewControllers to show ( in that order )
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [self.newViewController(function: "Change"),
                self.newViewController(function: "Translate"),
                self.newViewController(function: "Weather")]
    }()

    // MARK: public methods

    // Creation of the view architecture, array of all the views
    // And define the style of the dots at the bottom of the page
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
        stylePageControl()
    }

    // MARK: private methods

    // Creating a new viewController with the Storyboard ID of name "function"
    private func newViewController(function: String) -> UIViewController {
        return UIStoryboard(
            name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Setting\(function)ViewController")
    }

    // Define the style of the dots at the bottom of the page
    private func stylePageControl() {
        let pageControl = UIPageControl.appearance(whenContainedInInstancesOf: [type(of: self)])
        pageControl.currentPageIndicatorTintColor = UIColor.black
        pageControl.backgroundColor = orderedViewControllers.first!.view.backgroundColor
    }
}

// On this extension: all of the controls of the pageController
extension SettingPagesViewController: UIPageViewControllerDataSource {

    // The user swipe to the next page. We send the next ViewController
    // Unless we are at the end. If this is the case, we return nil
    func pageViewController
        (_ pageViewController: UIPageViewController,
         viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
            return nil
        }

        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count

        guard orderedViewControllersCount != nextIndex else {
            return nil
        }

        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        return orderedViewControllers[nextIndex]
    }

    // The user swipe to the previous page. We send the previous ViewController
    // Unless we are at the beginning. If this is the case, we return nil
    func pageViewController
        (_ pageViewController: UIPageViewController,
         viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
            return orderedViewControllers.last
        }

        let previousIndex = viewControllerIndex - 1

        guard previousIndex >= 0 else {
            return nil
        }

        guard orderedViewControllers.count > previousIndex else {
            return nil
        }

        return orderedViewControllers[previousIndex]
    }

    // The number of dots to show. this is the count of ViewControllers
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return orderedViewControllers.count
    }

    // Returning the state of the selection at first init.
    // This is the firstViewController
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first,
            let firstViewControllerIndex = orderedViewControllers.firstIndex(of: firstViewController) else {
                return 0
        }
        return firstViewControllerIndex
    }
}
