//
//  AudioPlayerViewController.swift
//  Navigation
//
//  Created by Maria Mezhova on 05.01.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import UIKit
import AVFoundation

class AudioPlayerViewController: UIViewController {
    
    private var player = AVAudioPlayer()
    public var position: Int = 0
    public var tracklist = TrackList.tracks

    private lazy var playbackButton: PlayerControlButton = {
        let button = PlayerControlButton(image: "play.fill"){
            self.playPressed()
        }
        
        return button
    }()
    
    private lazy var pauseButton: PlayerControlButton = {
        let button = PlayerControlButton(image: "pause.fill"){
            self.pausePressed()
        }
        
        return button
    }()
    
    private lazy var stopButton: PlayerControlButton = {
        let button = PlayerControlButton(image:"stop.fill"){
            self.stopPressed()
        }
        
        return button
    }()
    
    private lazy var previousButton: PlayerControlButton = {
        let button = PlayerControlButton(image: "backward.fill"){
            self.previousPressed()
        }
        
        return button
    }()
    
    private lazy var nextButton: PlayerControlButton = {
        let button = PlayerControlButton(image: "forward.fill"){
            self.nextPressed()
        }
        
        return button
    }()
    
    private lazy var playerControllsStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 30.0
        stackView.toAutoLayout()
        return stackView
    }()
    
    private let trackNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 27, weight: .bold)
        label.textAlignment = .center
        label.textColor = .black
        label.toAutoLayout()
        return label
    }()
    
    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textAlignment = .center
        label.textColor = .black
        label.toAutoLayout()
        return label
    }()
    
    private let trackPicture: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.borderWidth = 1
        image.layer.borderColor = UIColor.black.cgColor
        image.layer.cornerRadius = 6
        image.clipsToBounds = true
        image.toAutoLayout()
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareForPlaying()
        setupUI()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        player.stop()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemGray2
        
        view.addSubviews(artistNameLabel, trackNameLabel, trackPicture, playerControllsStack)
        playerControllsStack.addArrangedSubview(previousButton)
        playerControllsStack.addArrangedSubview(playbackButton)
        playerControllsStack.addArrangedSubview(pauseButton)
        playerControllsStack.addArrangedSubview(stopButton)
        playerControllsStack.addArrangedSubview(nextButton)
        
        let constraints = [
            
            artistNameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            artistNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            trackNameLabel.topAnchor.constraint(equalTo: artistNameLabel.bottomAnchor, constant: 30),
            trackNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            trackPicture.topAnchor.constraint(equalTo: trackNameLabel.bottomAnchor, constant: 30),
            trackPicture.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            trackPicture.widthAnchor.constraint(equalToConstant: 300),
            trackPicture.heightAnchor.constraint(equalTo: trackPicture.widthAnchor),
            
            playerControllsStack.topAnchor.constraint(equalTo: trackPicture.bottomAnchor, constant: 50),
            playerControllsStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playerControllsStack.heightAnchor.constraint(equalToConstant: 35),
            
            playbackButton.widthAnchor.constraint(equalToConstant: 35),
            pauseButton.widthAnchor.constraint(equalToConstant: 35),
            stopButton.widthAnchor.constraint(equalToConstant: 35),
            previousButton.widthAnchor.constraint(equalToConstant: 35),
            nextButton.widthAnchor.constraint(equalToConstant: 35),
        ]
        
        NSLayoutConstraint.activate(constraints)
        
    }
    
    private func prepareForPlaying() {
        
        let track = tracklist[position]
        
        trackPicture.image = track.image
        trackNameLabel.text = track.trackName
        artistNameLabel.text = track.artistName
        
        let url = Bundle.main.url(forResource: track.fileName, withExtension: "mp3")!
        do {
            player = try AVAudioPlayer(contentsOf: url)
            
            player.prepareToPlay()
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    private func playPressed() {
        if player.isPlaying {
            print("Already playing!")
        } else {
            player.play()
        }
    }
    
    private func pausePressed() {
        if player.isPlaying {
            player.pause()
        } else {
            print("Already paused!")
        }
    }
    
    private func stopPressed() {
        player.stop()
        player.currentTime = 0.0
    }
    
    private func nextPressed() {
        if position + 1 < tracklist.count {
            position += 1
            prepareForPlaying()
        }
    }
    
    private func previousPressed() {
        if position != 0 {
            position -= 1
            player.stop()
            prepareForPlaying()
        }
    }
}
