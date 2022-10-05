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
    }
    
    func set(state:TeamState) {
        imageView.image = nil

        if let logo = state.logo {
            self.restorationIdentifier = logo
            imageView.loadImageWithCombine(url: logo)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { _ in print("") }, receiveValue: { [weak self] value in
                    if value.id == self?.restorationIdentifier {
                        self?.imageView.image = value.0
                    }
                })
                .store(in: &cancellables)
        }
    }
}
