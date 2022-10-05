//
//  UIImage+utils.swift
//  Test-FDJ
//
//  Created by Benjamin Sénéchal on 30/09/2022.
//

import Foundation
import UIKit
import Combine

extension UIImageView {
    
    public func loadImageWithCombine(url: String) -> AnyPublisher<(UIImage?,id:String), Error> {
        return URLSession.shared.dataTaskPublisher(for: URL(string: url)!)
            .map { (UIImage(data: $0.data),id:url) }
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
    
    public func load(url: URL, placeholder: UIImage?, cache: URLCache? = nil, shouldCacheImage: Bool = true, completion:(( _ downloadedImage: UIImage?) -> Void)?) {
        let cache = cache ?? URLCache.shared
        let request = URLRequest(url: url)
        if shouldCacheImage {
            if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = image
                    if let callback = completion {
                        callback(image)
                    }
                }
            }
        } else {
            self.image = placeholder
            let dataTask = URLSession.shared.dataTask(with: request, completionHandler: { data, response, _ in
                if let data = data, let response = response, ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300, let image = UIImage(data: data) {
                    let cachedData = CachedURLResponse(response: response, data: data)
                    cache.storeCachedResponse(cachedData, for: request)
                    
                    DispatchQueue.main.async {
                        self.image = image
                        if let callback = completion {
                            callback(image)
                        }
                    }
                }
            })
            dataTask.resume()
        }
    }
}
