//
//  ActivityIndicator.swift
//  Flow-Test
//
//  Created by WorkStation on 12/11/18.
//  Copyright © 2018 Atul Prakash. All rights reserved.
//

import Foundation
import UIKit

/**
 * IBOutlet for the view created through Interface Builder
 * Required to change the value at run-time
**/

open class ActivityIndicator {
    
    /**
     * Declared Variable of the Class
    **/
    
    var containerView = UIView()
    var smallBlurView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var progressView = UIProgressView()
    
    /**
     * Shared Instanse to call the method of the Class using the class name
     **/
    
    open class var shared: ActivityIndicator {
        struct Static {
            static let instance: ActivityIndicator = ActivityIndicator()
        }
        return Static.instance
    }
    
    /**
     * In order to show the activity indicator, call the function from your view controller
     * ActivityIndicator.shared.showProgressView(view)
     **/
    
    open func showProgressView(_ view: UIView) {
        containerView.frame = view.frame
        containerView.center = view.center
        containerView.backgroundColor = UIColor(hex: 0xffffff, alpha: 0.0)
        
        smallBlurView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        smallBlurView.center = view.center
        smallBlurView.backgroundColor = UIColor(hex: 0x444444, alpha: 0.7)
        smallBlurView.clipsToBounds = true
        smallBlurView.layer.cornerRadius = 10
        
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator.activityIndicatorViewStyle = .whiteLarge
        activityIndicator.center = CGPoint(x: smallBlurView.bounds.width / 2, y: smallBlurView.bounds.height / 2)
        
        progressView = UIProgressView(progressViewStyle: UIProgressViewStyle.default)
        progressView.center = view.center
        
        smallBlurView.addSubview(activityIndicator)
        smallBlurView.addSubview(progressView)
        containerView.addSubview(smallBlurView)
        view.addSubview(containerView)
        
        activityIndicator.startAnimating()
    }
    
    /**
     * In order to hide the activity indicator, call the function from your view controller
     * ActivityIndicator.shared.hideProgressView(view)
     **/
    
    open func hideProgressView() {
        activityIndicator.stopAnimating()
        containerView.removeFromSuperview()
    }
}

