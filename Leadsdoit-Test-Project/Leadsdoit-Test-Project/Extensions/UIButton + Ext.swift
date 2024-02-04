//
//  UIButton + Ext.swift
//  Leadsdoit-Test-Project
//
//  Created by Diana on 30/01/2024.
//

import UIKit

enum ActionType {
    case exit
    case accept
    case whiteExit
    case history
    case left
}

extension UIButton {
    static func setupAction(type: ActionType) -> UIButton {
        let button = UIButton()
        switch type {
        case .exit:
            button.setImage(UIImage(named: "closeBlack"), for: .normal)
        case .accept:
            button.setImage(UIImage(named: "tick"), for: .normal)
        case .whiteExit:
            button.setImage(UIImage(named: "closeWhite"), for: .normal)
        case .history:
            button.setImage(UIImage(named: "history1"), for: .normal)
        case .left:
            button.setImage(UIImage(named: "left"), for: .normal)
        }
        return button
    }
}
