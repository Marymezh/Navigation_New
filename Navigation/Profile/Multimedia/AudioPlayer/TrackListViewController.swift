//
//  TrackListViewController.swift
//  Navigation
//
//  Created by Maria Mezhova on 07.01.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import UIKit

class TrackListViewController: UIViewController {
    
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    let tracklist = TrackList.tracks

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = "List of Audio Tracks"
        navigationController?.navigationBar.topItem?.title = "Back"

        setupTableView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.toAutoLayout()
        tableView.dataSource = self
        tableView.delegate = self
        
        let constraints = [
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }

}

extension TrackListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracklist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "CellID")

        let track = tracklist[indexPath.row]
        
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = track.trackName
        cell.detailTextLabel?.text = track.artistName
        cell.imageView?.image = track.image
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

extension TrackListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let position = indexPath.row
        let playerVC = AudioPlayerViewController()
        playerVC.tracklist = tracklist
        playerVC.position = position
        navigationController?.present(playerVC, animated: true, completion: nil)
    }
    
}
