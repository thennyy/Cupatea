//
//  SelectMatchGenderController.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 11/2/22.
//

import UIKit
protocol AddEthnicityControllerDelegate: AnyObject {
    func addEthnicityController(_ controllerWantsToUpdateEduction: AddEthnicityController, user: User)
}
class AddEthnicityController: UICollectionViewController {
    
    var lastIndex: IndexPath?
    var user: User!
    
    private var selectedAnswer: String? = nil
    
    weak var delegate: AddEthnicityControllerDelegate?
    
    private lazy var navigationView = AddSettingNavigationView(title: "Ethnicity",
                                                               leftButton: .xmarkCircleImage!,
                                                               rightButton: "Save", delegate: self)
    
    
    private let ethnicityArray = ["American Indian","Alaska Native","Asian","Black/African American","Hawaiia Native","White/Caucasian","Hispanic/Latino","Not Hispanic or Latino","Mixed", "Other"]
  
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


        collectionView.register(AddEductionCell.self,
                    forCellWithReuseIdentifier: AddEductionCell.identifier)
        
        collectionView.contentInset = UIEdgeInsets(top: 90, left: 0, bottom: 30, right: 0)
        
    }
    


}
extension AddEthnicityController: AddSettingNavigationViewDelegate {
 
    func addSettingNavigationView(_ view: AddSettingNavigationView, leftButton: UIButton) {
        self.dismiss(animated: true)
    }
    
    func addSettingNavigationView(_ view: AddSettingNavigationView, rightButton: UIButton) {
        
        let data: [String:Any] = ["ethnicity": selectedAnswer ?? "" ]
        guard let user = self.user else {return}
        
        Service.updateUserPreference(userId: user.uid, data: data) { user in
            self.delegate?.addEthnicityController(self, user: user)
            self.dismiss(animated: true)
            
        }
    }
    
    
}
extension AddEthnicityController {
   
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ethnicityArray.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddEductionCell.identifier , for: indexPath) as! AddEductionCell
        
        cell.titleTextLabel.text = ethnicityArray[indexPath.row]
       
        if ethnicityArray[indexPath.row] == user.ethnicity {
            
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
        selectedAnswer = self.ethnicityArray[index.row]
        
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

extension AddEthnicityController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 60, height: 54)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 9
        
    }
}
