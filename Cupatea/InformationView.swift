//
//  InformationView.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 11/1/21.
//

import UIKit

class InformationView: UIView {
    
    var textField: UITextField = {
        let tf = UITextField()
        tf.font = UIFont(name: .regular, size: 18)
        tf.textColor = .accentColor
        tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 9, height: tf.frame.height))
       // tf.placeholder = "Email"
        return tf
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(textField)
        textField.anchor(top: topAnchor,
                         left: leftAnchor,
                         bottom: bottomAnchor,
                         right: rightAnchor,
                         paddingTop: 6,
                         paddingLeft: 6,
                         paddingBottom: 6,
                         paddingRight: 6)
        let lineView = UIView()
        lineView.backgroundColor = .accentColor
            addSubview(lineView)
        lineView.anchor(left: leftAnchor,
                        bottom: bottomAnchor,
                        right: rightAnchor,
                        paddingLeft: 0,
                        paddingBottom: 0,
                        paddingRight: 0,
                        height: 0.3)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
