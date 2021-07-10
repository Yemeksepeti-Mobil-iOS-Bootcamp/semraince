//
//  PageViewController.swift
//  ImageTableView
//
//  Created by semra on 9.07.2021.
//  Copyright © 2021 semra. All rights reserved.
//

import UIKit

class PageViewController: UIViewController {

    var pageViewController:UIPageViewController!
        var viewControllersArray:Array<UIViewController> = []
        let imageNames = ["image1", "image2", "image3"]
        lazy var pageControl: UIPageControl = {
            let pageControl = UIPageControl();
            pageControl.currentPage = 0;
            pageControl.tintColor = UIColor.black
            pageControl.backgroundColor = .none
            pageControl.translatesAutoresizingMaskIntoConstraints = false;
                return pageControl;
            }();
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            self.view.backgroundColor = .black
            for index in 0 ..< imageNames.count {
                let viewController = UIViewController()

                viewController.view.tag = index
                let imageView = UIImageView();
                imageView.image = UIImage(named: imageNames[index] )
                imageView.clipsToBounds = true;
                imageView.contentMode = .scaleAspectFit;
                viewController.view.addSubview(imageView)
                imageView.translatesAutoresizingMaskIntoConstraints = false;
                imageView.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor).isActive = true;
                imageView.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor).isActive = true;
                imageView.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor).isActive = true;
                imageView.topAnchor.constraint(equalTo: viewController.view.topAnchor).isActive = true;
                
                viewControllersArray.append(viewController)
            }
            

            pageViewController = UIPageViewController(transitionStyle: UIPageViewController.TransitionStyle.scroll,
                                                      navigationOrientation: UIPageViewController.NavigationOrientation.horizontal,
                                                      options: nil)
            pageViewController.dataSource = self
            pageViewController.delegate = self
            
            pageViewController.setViewControllers([viewControllersArray.first!], direction: .forward, animated: true, completion: nil)
            pageViewController.view.frame = self.view.frame
            self.view.addSubview(pageViewController.view!)
            self.view.addSubview(pageControl)
            pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true;
            pageControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30.0).isActive = true;
            pageControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30.0).isActive = true;
            pageControl.heightAnchor.constraint(equalToConstant: 50).isActive = true;
            
            
            pageControl.numberOfPages = imageNames.count
            
            pageControl.currentPage = 0
            pageControl.isUserInteractionEnabled = false
            
        }
        
    }

    extension PageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
           var index = viewController.view.tag
           pageControl.currentPage = index
           if index == imageNames.count - 1{
               return nil
           }
           index = index + 1
           return viewControllersArray[index]
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
            var index = viewController.view.tag
            pageControl.currentPage = index
            index = index - 1
            if index < 0{
                return nil
            }
            return viewControllersArray[index]
        }
    



}
