//
//  TeamCollectionViewCell.swift
//  Test-FDJ
//
//  Created by Benjamin Sénéchal on 29/09/2022.
//

import UIKit
import Combine

class TeamCollectionViewCell: UICollectionViewCell {
    static let identifier = "TeamCollectionViewCell"

    @IBOutlet weak var imageView: UIImageView!
    private var cancellables = [AnyCancellable]()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    func set(state:TeamState) {
        if let logo = state.logo, let logoURL = URL(string:logo) {
            
            imageView.load(url: logoURL, placeholder: UIImage(named: "placeholder"), shouldCacheImage:false) { downloadedImage in
                self.imageView.image = downloadedImage
            }
        }
    }
}
