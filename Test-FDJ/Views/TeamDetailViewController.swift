//
//  TeamDetailViewController.swift
//  Test-FDJ
//
//  Created by Benjamin Sénéchal on 30/09/2022.
//

import UIKit
import Combine

class TeamDetailViewController: UIViewController {
    static let identifier = "TeamDetailViewController"

    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var leagueLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    private var presenter:TeamDetailPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func updateUI(teamState:TeamState) {
        if let banner = teamState.banner, let url = URL(string: banner) {
            bannerImageView.load(url: url, placeholder: UIImage(named: "placeholder"), shouldCacheImage:false) { downloadedImage in
                self.bannerImageView.image = downloadedImage
            }
        }
        leagueLabel.text = teamState.league
        descriptionLabel.text = teamState.description
        nameLabel.text = teamState.name
        self.title = teamState.name
    }
    
    func set(teamName:String) {
        presenter = TeamDetailPresenter(self)
        presenter?.getTeam(name: teamName)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
