//
//  ExtensionUtil.swift
//  Shaadi.com
//
//  Created by Yashashree on 22/11/20.
//

import UIKit

extension UIApplication{
    var keyWindow: UIWindow?{
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first
    }
    
    func getStoryboard() -> UIStoryboard{
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
}

extension UIImageView {
    /// Loads image asynchronosly and caches it
    func load(path: String, placeholder: UIImage?) {
        guard let url = URL(string: API_URL.image(path: path).url()) else {
            return
        }
        
        let request = URLRequest(url: url)
        if let data = URLCache.shared.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
            self.image = image
        } else {
            self.image = placeholder
            URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                if let data = data, let response = response, ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300, let image = UIImage(data: data) {
                    let cachedData = CachedURLResponse(response: response, data: data)
                    URLCache.shared.storeCachedResponse(cachedData, for: request)
                    DispatchQueue.main.async {[weak self] in
                        self?.image = image
                    }
                }
            }).resume()
        }
    }
}

extension UIViewController {
    ///Show a basic alert OR actionsheet according to the style
    
    func showAlert(title: String?, message: String?, actionTitles:[String?], style:UIAlertController.Style, completion: @escaping (_ index: Int) -> Void) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        for (index, title) in actionTitles.enumerated() {
            let action = UIAlertAction(title: title, style: .default) { (_) in
                completion(index)
            }
            alert.addAction(action)
        }
        
        if style == .actionSheet{
            let action = UIAlertAction(title: "Cancel", style: .cancel , handler: nil)
            alert.addAction(action)
        }
        self.present(alert, animated: true, completion: nil)
    }
}

//MARK:- UIVIEW
@IBDesignable extension UIView {
    @IBInspectable var shadowColor: UIColor? {
        set {
            layer.shadowColor = newValue!.cgColor
        }
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor:color)
            }
            else {
                return nil
            }
        }
    }
    
    @IBInspectable var shadowOpacity: Float {
        set {
            layer.shadowOpacity = newValue
        }
        get {
            return layer.shadowOpacity
        }
    }
    
    @IBInspectable var shadowOffset: CGPoint {
        set {
            layer.shadowOffset = CGSize(width: newValue.x, height: newValue.y)
        }
        get {
            return CGPoint(x: layer.shadowOffset.width, y:layer.shadowOffset.height)
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat {
        set {
            layer.shadowRadius = newValue
        }
        get {
            return layer.shadowRadius
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
}
