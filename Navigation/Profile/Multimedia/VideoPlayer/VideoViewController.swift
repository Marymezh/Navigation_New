//
//  VideoViewController.swift
//  Navigation
//
//  Created by Maria Mezhova on 09.01.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import UIKit
import YoutubeKit


class VideoViewController: UIViewController {
    
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    private let videoPlaylist = VideoPlaylist.playlist
    
    private var player: YTSwiftyPlayer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = "Video Player"
        navigationController?.navigationBar.topItem?.title = "Back"

        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = "Video Player"
        navigationController?.navigationBar.topItem?.title = "Back"
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

extension VideoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoPlaylist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = UITableViewCell(style: .default, reuseIdentifier: "CellID")
        let track = videoPlaylist[indexPath.row]

        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = track.title
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

extension VideoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let track = videoPlaylist[indexPath.row]
        let videoID = track.id
        let playerVC = YouTubePlayerViewController(videoID: videoID)
        
        navigationController?.present(playerVC, animated: true, completion: nil)
    }
}
