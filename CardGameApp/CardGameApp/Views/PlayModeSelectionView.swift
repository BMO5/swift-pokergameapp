//
//  PlayModeSelectionView.swift
//  CardGameApp
//
//  Created by Chaewan Park on 2020/02/12.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

protocol PlayModeSelectionViewDelegate: class {
    func didModeChanged(to rule: GamePlay.Rule, playerCount: Players.Number)
}

struct PlayModeSelectionViewContents {
    let rule: [String]
    let numberOfPlayers: [String]
}

class PlayModeSelectionView: UIView {
    weak var delegate: PlayModeSelectionViewDelegate?
    
    private var contents: PlayModeSelectionViewContents?
    
    private lazy var selectionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()
    
    private lazy var ruleSegmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: self.contents?.rule)
        return control
    }()
    
    private lazy var playersSegmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: self.contents?.numberOfPlayers)
        return control
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    required init(with contents: PlayModeSelectionViewContents) {
        super.init(frame: .zero)
        self.contents = contents
        setupView()
    }
    
    func invokeByMode(block: (GamePlay.Rule, Players.Number) -> ()) {
        if let rule = rule(from: ruleSegmentedControl.selectedSegmentIndex),
            let count = participantCount(from: playersSegmentedControl.selectedSegmentIndex) {
            block(rule, count)
        }
    }
    
    @objc func notifyPlayModeDidChange() {
        if let rule = rule(from: ruleSegmentedControl.selectedSegmentIndex),
            let count = participantCount(from: playersSegmentedControl.selectedSegmentIndex) {
            delegate?.didModeChanged(to: rule, playerCount: count)
        }
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(selectionStackView)
        selectionStackView.fillSuperView()
        selectionStackView.addArrangedSubview(ruleSegmentedControl)
        selectionStackView.addArrangedSubview(playersSegmentedControl)
        selectionStackView.arrangedSubviews.forEach {
            guard let segmentedControl = $0 as? UISegmentedControl else { return }
            segmentedControl.selectedSegmentIndex = .zero
            segmentedControl.setTitleTextAttributes(
                [NSAttributedString.Key.foregroundColor: UIColor.white],
                for: .normal)
            segmentedControl.setTitleTextAttributes(
                [NSAttributedString.Key.foregroundColor: UIColor.black],
                for: .selected)
            segmentedControl.addTarget(self, action: #selector(notifyPlayModeDidChange), for: .valueChanged)
        }
    }
    
    private func rule(from index: Int) -> GamePlay.Rule? {
        switch index {
        case 0: return .sevenCardStud
        case 1: return .fiveCardStud
        default: return nil
        }
    }
    
    private func participantCount(from index: Int) -> Players.Number? {
        switch index {
        case 0: return .two
        case 1: return .three
        case 2: return .four
        default: return nil
        }
    }
}
