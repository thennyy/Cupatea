//
//  AddStarSignController.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 11/1/22.
//

import UIKit
protocol AddStarSignControllerDelegate: AnyObject {
    func addStarSignController(_ controllerWantsToUpdateEduction: AddStarSignController, user: User)
}
class AddStarSignController: UICollectionViewController {
    
    // MARK: - Properties
    
    var lastIndex: IndexPath?
    var user: User!
    weak var delegate: AddStarSignControllerDelegate?
   
    private var selectedAnswer: String? = nil
    
    private let zodiacArray = ["Aries","Taurus","Gemini","Cancer","Leo","Virgo","Libra","Scorpio", "Sagittarius","Capricorn","Aquarius","Pisces", "N/A"]
    
    private lazy var navigationView = AddSettingNavigationView(title: "Zodiac signs",
                                                               leftButton: .xmarkCircleImage!,
                                                               rightButton: "Save",
                                                               delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    func configureUI() {
        
        view.backgroundColor = .white
        view.addSubview(navigationView)
        navigationView.anchor(top: view.topAnchor,
                              left: view.leftAnchor,
                              right: view.rightAnchor,
                              height: 60)

        collectionView.register(AddStarSignCell.self,
                    forCellWithReuseIdentifier: AddStarSignCell.identifier)
        
        collectionView.contentInset = UIEdgeInsets(top: 90, left: 0, bottom: 30, right: 0)
        
    }
    

}
extension AddStarSignController: AddSettingNavigationViewDelegate {
    func addSettingNavigationView(_ view: AddSettingNavigationView, leftButton: UIButton) {
        self.dismiss(animated: true)
    }
    
    func addSettingNavigationView(_ view: AddSettingNavigationView, rightButton: UIButton) {
        
        
        let data: [String:Any] = ["starSign": selectedAnswer ?? "" ]
        guard let user = self.user else {return}
        
        Service.updateUserPreference(userId: user.uid, data: data) { user in
            self.delegate?.addStarSignController(self, user: user)
            
            self.dismiss(animated: true)
            
        }
    }
 
}

extension AddStarSignController {
   
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return zodiacArray.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddStarSignCell.identifier , for: indexPath) as! AddStarSignCell
        
        cell.starSignLabel.text = zodiacArray[indexPath.row]
        cell.starSignImageView.image = UIImage(named: zodiacArray[indexPath.row])
        
        if zodiacArray[indexPath.row] == user.starSign {
            
            cell.configureSelectAnswer(color: .accentColor, height: 3)
            self.lastIndex = indexPath
            
        }else {
            
            cell.configureSelectAnswer(color: .lightGray, height: 1)
                  
        }
        
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        let index = indexPath
        navigationView.enableRightButton() 
        selectedAnswer = self.zodiacArray[index.row]
        
        if self.lastIndex == nil {
            
            self.collectionView.cellForItem(at: indexPath)?.layer.borderColor = UIColor.accentColor.cgColor
            self.collectionView.cellForItem(at: indexPath)?.layer.borderWidth = 3
            
            self.lastIndex = index
            
        }else {
            
            self.collectionView.cellForItem(at: self.lastIndex!)?.layer.borderColor = UIColor.lightGray.cgColor
            self.collectionView.cellForItem(at: self.lastIndex!)?.layer.borderWidth = 1
            
            self.collectionView.cellForItem(at: index)?.layer.borderColor = UIColor.accentColor.cgColor
            self.collectionView.cellForItem(at: index)?.layer.borderWidth = 3

            self.lastIndex = index
            
        }
        
    }
    
}

extension AddStarSignController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 60, height: 54)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 9
        
    }
}
