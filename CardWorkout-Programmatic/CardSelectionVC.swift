//
//  CardSelectionVC.swift
//  CardWorkout-Programmatic
//
//  Created by Nikhil Kukreja on 24/08/24.
//

import UIKit

class CardSelectionVC: UIViewController {
    
    let cardImageView   = UIImageView();
    let stopButton      = CWButton(color: .systemRed, title: "Stop!", systemImageName: "stop.circle");
    let restartButton   = CWButton(color: .systemGreen, title: "Restart", systemImageName: "arrow.clockwise.circle");
    let rulesButton     = CWButton(color: .systemBlue, title: "Rules", systemImageName: "list.bullet");
    
    var timer: Timer!;
    
    var cards: [UIImage] = Deck.allValues;
    

    override func viewDidLoad() {
        super.viewDidLoad();
        view.backgroundColor = .systemBackground;
        configureUI();
        startTimer();
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated);
        timer.invalidate();
    }
    
    
    func configureUI() {
        configureCardImageView();
        configureStopButton();
        configureRestartButton();
        configureRulesButton();
        
    }
    
    func configureCardImageView() {
        view.addSubview(cardImageView);
        cardImageView.translatesAutoresizingMaskIntoConstraints = false;
        cardImageView.image = UIImage(named: "AS");
        
        NSLayoutConstraint.activate([
            cardImageView.widthAnchor.constraint(equalToConstant: 250),
            cardImageView.heightAnchor.constraint(equalToConstant: 350),
            cardImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cardImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -75),
        ]);
        
    }
    
    func configureStopButton() {
        view.addSubview(stopButton);
        
        stopButton.addTarget(self, action: #selector(stopButtonTapped), for: .touchUpInside);
        
        NSLayoutConstraint.activate([
            stopButton.widthAnchor.constraint(equalToConstant: 260),
            stopButton.heightAnchor.constraint(equalToConstant: 50),
            stopButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stopButton.topAnchor.constraint(equalTo: cardImageView.bottomAnchor, constant: 30),
        ]);
    }
    
    func configureRestartButton() {
        view.addSubview(restartButton);
        
        restartButton.addTarget(self, action: #selector(restartButtonTapped), for: .touchUpInside);
        
        NSLayoutConstraint.activate([
            restartButton.widthAnchor.constraint(equalToConstant: 115),
            restartButton.heightAnchor.constraint(equalToConstant: 50),
            restartButton.leadingAnchor.constraint(equalTo: stopButton.leadingAnchor, constant: 0),
            restartButton.topAnchor.constraint(equalTo: stopButton.bottomAnchor, constant: 20),
        
        ]);
    }
    
    func configureRulesButton() {
        view.addSubview(rulesButton);
        rulesButton.addTarget(self, action: #selector(presentRulesVC), for: .touchUpInside);
        
        NSLayoutConstraint.activate([
            rulesButton.widthAnchor.constraint(equalToConstant: 115),
            rulesButton.heightAnchor.constraint(equalToConstant: 50),
            rulesButton.trailingAnchor.constraint(equalTo: stopButton.trailingAnchor, constant: 0),
            rulesButton.topAnchor.constraint(equalTo: stopButton.bottomAnchor, constant: 20),
        ]);
    }
    
    @objc func presentRulesVC() {
        present(RulesVC(), animated: true);
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(showRandomImage), userInfo: nil, repeats: true);
    }
    
    @objc func showRandomImage() {
        cardImageView.image = cards.randomElement() ?? UIImage(named: "AS");
        
    }
    
    @objc func stopButtonTapped() {
        timer.invalidate();
    }
    
    @objc func restartButtonTapped() {
        timer.invalidate();
        startTimer();
    }

}
