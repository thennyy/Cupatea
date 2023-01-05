//
//  AddReligionController.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 11/1/22.
//

import UIKit
protocol AddReligionControllerDelegate: AnyObject {
    func addReligionController(_ controllerWantsToUpdateEduction: AddReligionController, user: User)
}
class AddReligionController: UICollectionViewController {
    
    var lastIndex: IndexPath?
    var user: User!
    private var selectedAnswer: String? = nil
    weak var delegate: AddReligionControllerDelegate?
    
    private let religionArray = ["Agnostic","Atheist","Buddist","Catholic","Christain", "Hindu","Jewish","Muslim","Sikh","Spiritual","Other"]
    
    private lazy var navigationView = AddSettingNavigationView(title: "Select religion",
                                                               leftButton: .xmarkCircleImage!,
                                                               rightButton: "Save", delegate: self)

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

extension AddReligionController: AddSettingNavigationViewDelegate {
    func addSettingNavigationView(_ view: AddSettingNavigationView, leftButton: UIButton) {
        self.dismiss(animated: true)
    }
    
    func addSettingNavigationView(_ view: AddSettingNavigationView, rightButton: UIButton) {
       
        let data: [String:Any] = ["religion": selectedAnswer ?? "" ]
        guard let user = self.user else {return}
        
        Service.updateUserPreference(userId: user.uid, data: data) { user in
            self.delegate?.addReligionController(self, user: user)
            
            self.dismiss(animated: true)
            
        }
    }
 
}
extension AddReligionController {
   
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return religionArray.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddEductionCell.identifier , for: indexPath) as! AddEductionCell
        
        cell.titleTextLabel.text = religionArray[indexPath.row]
      
        if religionArray[indexPath.row] == user.religion {
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
        
        selectedAnswer =  self.religionArray[index.row]
        
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

extension AddReligionController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 60, height: 54)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 9
        
    }
}
