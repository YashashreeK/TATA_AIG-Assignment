//
//  ExtensionUtil.swift
//  Shaadi.com
//
//  Created by Yashashree on 22/11/20.
//

import UIKit

extension UIApplication{
    func getNavigation() -> UINavigationController?{
        return UIApplication.shared.keyWindow?.rootViewController as? UINavigationController
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
    ///Show a basic alert
    func showAlert(alertText : String, alertMessage : String) {
        let alert = UIAlertController(title: alertText, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

