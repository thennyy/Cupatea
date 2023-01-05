//
//  UIImageExtension.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 10/12/22.
//

import UIKit

extension UIImage {
    
    static let filterImage = UIImage(systemName: "slider.horizontal.3")
    static let userImage = UIImage(systemName: "person")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 21))
    static let chatImage = UIImage(systemName: "ellipsis.message")
    static let heartImage = UIImage(systemName: "heart")
    static let heartFillImage = UIImage(systemName: "heart.fill")?.withTintColor(.pinkColor)
    static let exploreImage = UIImage(systemName: "sparkle.magnifyingglass")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 21))
    static let notificationImage = UIImage(systemName: "bell")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 18))
    static let matchingImage = UIImage(named: "cup")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 21))
    static let cupImage = UIImage(systemName: "cup.and.saucer")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 21))
    static let giftImage = UIImage(named: "giftLogo")
    static let pinImage = UIImage(named: "pin")
    static let likeImage = UIImage(named: "like")
    static let pinFillImage = UIImage(systemName: "pin.fill")?.withTintColor(.accentColor)
    static let pinOutLinedImage = UIImage(systemName: "pin")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 21))
    static let xmarkImage = UIImage(systemName: "xmark")?.withTintColor(.systemRed).withConfiguration(UIImage.SymbolConfiguration(pointSize: 15, weight: .bold))
    static let xmarkCircleImage = UIImage(systemName: "xmark.circle")
    static let crossImage = UIImage(named: "cross")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 21))
    static let cup_tabBarImage = UIImage(named: "cupp")
    static let backImage = UIImage(systemName: "chevron.left")
    static let forwardImage = UIImage(systemName: "chevron.right")
    static let sendButtonImage = UIImage(systemName: "arrow.up.circle.fill")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 24, weight: .bold))
    static let moreImage = UIImage(systemName: "ellipsis")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 24))
    static let dotsImage = UIImage(named: "dotsReport")?.withTintColor(.gray)
    static let locationImage = UIImage(systemName: "mappin.and.ellipse")
    static let professionImage = UIImage(systemName: "briefcase.fill")
    static let trashImage = UIImage(systemName: "trash")
    static let editImage = UIImage(systemName: "pencil.tip.crop.circle")
    
    static let textEditImage = UIImage(systemName: "highlighter")
    static let checkImage = UIImage(systemName: "checkmark")
    static let dismissImage = UIImage(systemName: "chevron.down.circle")
    static let ethnicity = UIImage(systemName: "people")
    static let settingImage = UIImage(systemName: "gearshape")
    static let verifyImage = UIImage(systemName: "checkmark.shield")
    static let schoolImage = UIImage(systemName: "building.columns.fill")
    static let checkMarkImage = UIImage(systemName: "checkmark.circle")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 21))
    static let unCheckMarkImage = UIImage(systemName: "circle")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 21))
    
}
