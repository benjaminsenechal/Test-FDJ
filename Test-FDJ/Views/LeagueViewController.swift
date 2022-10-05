//
//  ViewController.swift
//  Test-FDJ
//
//  Created by Benjamin Sénéchal on 29/09/2022.
//

import UIKit
import Combine

class LeagueViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet weak var emptyStateView: UIView!
    
    private var items = [TeamState]()
    private var presenter:LeaguesPresenter?
    private var router = HomeRouter()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = LeaguesPresenter(self)
        self.presenter?.getTeams(name: "French ligue 1")

        self.router.leagueViewController = self

        updateUI()
    }
    
    func updateUI() {
        navigationItem.searchController = UISearchController()
        navigationItem.searchController?.searchBar.delegate = self
    }
    
    func refreshLeagues(teamStateAction : TeamState.Action) {
        switch teamStateAction {
        case .refresh(let teamState):
            self.items = teamState
            self.emptyStateView.isHidden = self.items.count != 0
            self.collectionView.reloadData()
        }
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.presenter?.getTeams(name: searchText)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let state = items[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TeamCollectionViewCell.identifier, for: indexPath) as! TeamCollectionViewCell
        cell.set(state:state)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        router.routeToDetail(team: item)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.view.frame.size.width)/2.2, height:(self.view.frame.size.width)/2.2)
    }
}

