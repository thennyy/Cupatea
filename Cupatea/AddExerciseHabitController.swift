//
//  AddExerciseHabitController.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 11/2/22.
//

import UIKit
protocol AddExcerciseHabitControllerDelegate: AnyObject {
    func addExcerciseHabitController(_ controllerWantsToUpdateEduction: AddExcerciseHabitController, user: User)
}

class AddExcerciseHabitController: UICollectionViewController {
    
    // MARK: - Properties
 
    var lastIndex: IndexPath?
    var user: User!
    private var selectedAnswer: String? = nil
    weak var delegate: AddExcerciseHabitControllerDelegate?
    
    private let exerciseArray = ["Active", "Sometimes","Almost never"]
    
    private lazy var navigationView = AddSettingNavigationView(title: "Exercise",
                                                               leftButton: .xmarkCircleImage!,
                                                               rightButton: "Save",
                                                               delegate: self)
    
 
        
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
      //  configureButtons()
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

// MARK: - AddSettingNavigationViewDelegate

extension AddExcerciseHabitController: AddSettingNavigationViewDelegate {
    func addSettingNavigationView(_ view: AddSettingNavigationView, leftButton: UIButton) {
        self.dismiss(animated: true)
    }
    
    func addSettingNavigationView(_ view: AddSettingNavigationView, rightButton: UIButton) {
      
        let data: [String:Any] = ["exercise": selectedAnswer ?? "" ]
        
        Service.updateUserPreference(userId: user.uid, data: data) { user in
            self.delegate?.addExcerciseHabitController(self, user: user)
            
            self.dismiss(animated: true)
            
        }
    }
    
    
}
extension AddExcerciseHabitController {
   
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return exerciseArray.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddEductionCell.identifier , for: indexPath) as! AddEductionCell
        
        cell.titleTextLabel.text = exerciseArray[indexPath.row]
        
        if exerciseArray[indexPath.row] == user.exercise {
           
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
        
        selectedAnswer =  self.exerciseArray[index.row]
        
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

extension AddExcerciseHabitController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 60, height: 54)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 9
        
    }
}
