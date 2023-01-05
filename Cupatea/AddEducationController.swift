//
//  AddEducationController.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 11/3/22.
//

import UIKit
protocol AddEducationControllerDelegate: AnyObject {
    func addEducationController(_ controllerWantsToUpdateEduction: AddEducationController, user: User)
}
class AddEducationController: UICollectionViewController {
    
    // MARK: - Properties
    
    var lastIndex: IndexPath?
    
    var user: User!
    
    weak var delegate: AddEducationControllerDelegate?
    
    private var userDetail: UserDetail? = nil
    
    private var selectedAnswer: String? = nil
    
    private lazy var navigationView = AddSettingNavigationView(title: "Education",
                                                               leftButton: .xmarkCircleImage!,
                                                               rightButton: "Save", delegate: self)
    
    
    private let eductionArray = ["High School",
                                 "Trade/Tech School",
                                 "Attending College",
                                 "Bachelor's Degree",
                                 "Attending Grad School",
                                 "Master's Degree",
                                 "Attending PhD",
                                 "PhD Degree","Other" ]

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureData()
        
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
    
   // MARK: - Helpers
    func configureData() {
        
        if user.eduction.isEmpty == false {
            
            for item in eductionArray {
                if item == user.eduction {
                    print("DEBUG: FOUND EDUCTAION")
                  
                }
            }
           
        }
    }

}

// MARK: - AddSettingNavigationViewDelegate

extension AddEducationController: AddSettingNavigationViewDelegate {
    func addSettingNavigationView(_ view: AddSettingNavigationView, leftButton: UIButton) {
        self.dismiss(animated: true)
    }
    
    func addSettingNavigationView(_ view: AddSettingNavigationView, rightButton: UIButton) {
        
        let data: [String:Any] = ["education": selectedAnswer ?? "" ]
        guard let user = self.user else {return}
        
        Service.updateUserPreference(userId: user.uid, data: data) { user in
            self.delegate?.addEducationController(self, user: user)
            self.dismiss(animated: true)
            
        }
    }

}

extension AddEducationController {
   
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return eductionArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddEductionCell.identifier , for: indexPath) as! AddEductionCell
        
        cell.titleTextLabel.text = eductionArray[indexPath.row]
        
        if eductionArray[indexPath.row] == user.eduction {
            cell.configureSelectAnswer(color: .accentColor, height: 3)
            self.lastIndex = indexPath
            
        }else {
            
            cell.configureSelectAnswer(color: .lightGray, height: 1)
                  
        }
        
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddEductionCell.identifier, for: indexPath) as! AddEductionCell
        
        cell.configureSelectAnswer(color: .lightGray, height: 1)
        
        let index = indexPath
        
        print("DEBUG: SELECTED TEXT", self.eductionArray[index.row])
        selectedAnswer = self.eductionArray[indexPath.row]
        navigationView.enableRightButton()
        
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

extension AddEducationController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 60, height: 54)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 9
        
    }
}
