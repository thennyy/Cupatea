//
//  WordCountStackView.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 11/1/22.
//

import UIKit

class WordCountView: UIView {
    
  //  static var wordCount = 0
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.text = "Max"
        return label
    }()
    let wordCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
       // label.text = "50"
        return label
    }()
    
    convenience init(wordCount: String) {
        self.init()


        wordCountLabel.text = wordCount
        let stackView = UIStackView(arrangedSubviews: [titleLabel, wordCountLabel]).withAttributes(axis: .horizontal, spacing: 9,distribution: .fillEqually, aligment: .center)
       
        
        addSubview(stackView)
        stackView.fillSuperview()
        
    }

    func overMaximumWordCount() {
        wordCountLabel.textColor = .red
    }
    func underMaximumWordCount() {
        wordCountLabel.textColor = .gray
    }
}
