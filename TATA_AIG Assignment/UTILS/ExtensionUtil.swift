//
//  ExtensionUtil.swift
//  Shaadi.com
//
//  Created by Yashashree on 22/11/20.
//

import UIKit

extension UIButton{
    func setFavourite(value: Bool){
        let imageName = value ? "star.fill" : "star"
        self.setImage(UIImage(systemName: imageName), for: .normal)
    }
}

extension UIApplication{
    func getNavigation() -> UINavigationController?{
        return UIApplication.shared.keyWindow?.rootViewController as? UINavigationController
    }
    
    func getStoryboard() -> UIStoryboard{
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
}
