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
    
}
