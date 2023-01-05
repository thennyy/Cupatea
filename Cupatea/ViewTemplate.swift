//
//  UIViewTemplate.swift
//  EnterAct-Dating
//
//  Created by Thenny Chhorn on 10/17/21.
//

import UIKit

enum AddLine {
    case addLine
    case noLine
}
enum SelectFont {
    case bold
    case medium
    case regular
}
class ViewTemplate: UIView {
    
 
    let textField = CustomTextField(placeholder: "",
                                    isSecureField: false)
    
    let button = UIButton()
    
    convenience init(image: String, imageColor: UIColor = .black, size: CGFloat, backGroundColor: UIColor = .accentColor, shadow: Bool = false){
      
        self.init()
      //  backGroundColor = .accentColor
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: image)?.withTintColor(imageColor).withRenderingMode(.alwaysOriginal)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        addSubview(imageView)
        imageView.anchor(width: size, height: size)
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        layer.cornerRadius = 60/2
        layer.masksToBounds = true
        layer.shadowRadius = 9
        layer.shadowOpacity = 0.6
        layer.shadowColor = UIColor.lightGray.cgColor
        
        self.backgroundColor = backGroundColor
    
        if shadow == true {
            layer.borderWidth = 0.6
            layer.borderColor = UIColor.gray.cgColor
            layer.shadowRadius = 9
            layer.shadowOpacity = 3
        }
        addSubview(button)
        button.anchor(top: topAnchor,
                      left: leftAnchor,
                      bottom: bottomAnchor,
                      right: rightAnchor)

        
    }
    convenience init(image: String, imageSize: CGFloat? = 30, text: String?,
                     textColor: UIColor?, weight: SelectFont = .regular,
                     fontSize: CGFloat = 18) {
        
        self.init()
        
        backgroundColor = .accentColor
        let image = UIImage(named: image)?.withTintColor(.white).withRenderingMode(.alwaysOriginal)
        let imageView = UIImageView(image: image)
        imageView.clipsToBounds = true
        
        addSubview(imageView)
        imageView.anchor(top: topAnchor,
                         paddingTop: 12,
                         width: imageSize,
                         height: imageSize)
        imageView.centerX(inView: self)
        
        let label = UILabel()
        label.text = text
        label.textColor = .white
        label.textAlignment = .center
        
        addSubview(label)
        label.anchor(top: imageView.bottomAnchor,
                     left: leftAnchor,
                     right: rightAnchor,
                     paddingTop: 6,
                     paddingLeft: 3,
                     paddingRight: 3,
                     height: 30)
        
        switch weight {
            
            case .bold:
            label.font = UIFont(name: .bold , size: fontSize)
            case .medium:
            label.font = UIFont(name: .medium , size: fontSize)
            case .regular:
            label.font = UIFont(name: .regular , size: fontSize)
        }
        
        layer.cornerRadius = 21
        clipsToBounds = true
        
        layer.shadowRadius = 9
        layer.shadowOpacity = 0.6
        layer.shadowColor = UIColor.lightGray.cgColor 
        
        
    }
    convenience init(image: String, imageSize: CGFloat, text: String,
                     textColor: UIColor, weight: SelectFont = .regular,
                     fontSize: CGFloat = 18) {
        
        self.init()
       
        backgroundColor = .accentColor
        layer.shadowRadius = 9
        layer.shadowOpacity = 0.6
        layer.shadowColor = UIColor.lightGray.cgColor
        
        let image = UIImage(named: image)?.withTintColor(.accentColor).withRenderingMode(.alwaysOriginal)
        let imageView = UIImageView(image: image)
        imageView.clipsToBounds = true
        
        addSubview(imageView)
        imageView.setDemensions(height: imageSize, width: imageSize)
        imageView.centerY(inView: self,leftAnchor: leftAnchor, paddingLeft: 9)
     
        let label = UILabel()
        label.text = text
        label.textColor = .accentColor
      //  label.font = UIFont(name: .regular, size: 18)
        label.textAlignment = .left

        addSubview(label)
        label.anchor(left: leftAnchor,
                     right: rightAnchor,
                     paddingLeft: 51,
                     height: 30)
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        switch weight {
            
            case .bold:
            label.font = UIFont(name: .bold , size: fontSize)
            case .medium:
            label.font = UIFont(name: .medium , size: fontSize)
            case .regular:
            label.font = UIFont(name: .regular , size: fontSize)
        }
    }
    convenience init(image: String,placeholder: String, isSecured: Bool? = false, imageSize: CGFloat, text: String? = nil, textColor: UIColor? = .accentColor, addLine: AddLine = .addLine){
        self.init()
        
        backgroundColor = .accentColor
        layer.shadowRadius = 9
        layer.shadowOpacity = 0.6
        layer.shadowColor = UIColor.lightGray.cgColor
        
        let image = UIImage(named: image)?.withTintColor(.accentColor).withRenderingMode(.alwaysOriginal)
        let imageView = UIImageView(image: image)
        imageView.clipsToBounds = true
        addSubview(imageView)
        imageView.anchor(left: leftAnchor, paddingTop: 0, paddingLeft: 9, paddingBottom: 0, paddingRight: 0, width: imageSize, height: imageSize)
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
     
        textField.placeholder = placeholder
        textField.isSecureTextEntry = isSecured!
        addSubview(textField)
        textField.anchor(top: topAnchor , left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 51, paddingBottom: 0, paddingRight: 0)
      //  textField.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
 
        switch addLine {
        case .addLine:
            let lineView = UIView()
            lineView.backgroundColor = .accentColor
            addSubview(lineView)
            lineView.anchor(top: imageView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 9, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.4)
        case .noLine:
            print("DEBUG: no line")
        }
        
    }
 
}
class viweTemplates: UIView {
    
    let textField = CustomTextField(placeholder: "", isSecureField: false)
   
    convenience init(image: String,placeholder: String, isSecured: Bool? = false, imageSize: CGFloat, text: String? = nil, textColor: UIColor? = .accentColor, addLine: AddLine = .addLine, textFeildColor: UIColor? = .accentColor){
        self.init()
        
        layer.shadowRadius = 9
        layer.shadowOpacity = 0.6
        layer.shadowColor = UIColor.lightGray.cgColor
        let image = UIImage(named: image)?.withTintColor(.accentColor).withRenderingMode(.alwaysOriginal)
        let imageView = UIImageView(image: image)
        imageView.clipsToBounds = true
     
        addSubview(imageView)
        imageView.anchor(left: leftAnchor,
                         paddingLeft: 9,
                         width: imageSize,
                         height: imageSize)
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        textField.placeholder = placeholder
        textField.isSecureTextEntry = isSecured!
        textField.textColor = textFeildColor
        addSubview(textField)
        textField.anchor(top: topAnchor ,
                         left: leftAnchor,
                         bottom: bottomAnchor,
                         right: rightAnchor,
                         paddingTop: 0,
                         paddingLeft: 51,
                         paddingBottom: 0,
                         paddingRight: 0)
 
        switch addLine {
        case .addLine:
            let lineView = UIView()
            lineView.backgroundColor = .accentColor
            addSubview(lineView)
            lineView.anchor(top: imageView.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 9, paddingLeft: 0,paddingRight: 0, height: 0.4)
        case .noLine:
            print("DEBUG: no line")
        }
        
    }
}

