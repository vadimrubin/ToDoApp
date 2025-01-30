//
//  TDDesciptionLabel.swift
//  ToDoApp
//
//  Created by Rubin Vadim on 30.01.2025.
//

import UIKit

class TDDesciptionLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        font = .systemFont(ofSize: 12, weight: .regular)
        textColor = .label
        translatesAutoresizingMaskIntoConstraints = false
        
    }

}
