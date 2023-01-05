//
//  MyProfileController.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 6/21/22.
//

import UIKit

protocol MyProfileControllerDelegate: AnyObject {
    func myProfileSettingController(_ controller: MyProfileController, wantsToUpdate user: User)
    func myProfileSettingController(_ controller: MyProfileController)
    func myProfileControllerWantsToLogout(_ controller: MyProfileController)

}

class MyProfileController: UITableViewController {

    // MARK: - Properties
    
    private var user: User
    private lazy var headerView = SettingHeader(user: user)
    private let imagePicker = UIImagePickerController()
    var imageIndex = 0
    
    var homeHandler: HomeViewController?
    
    weak var delegate: MyProfileControllerDelegate?

    
    // MARK: - Lifecycle
    
    init(user: User) {
        self.user = user
        super.init(style: .plain)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
        homeHandler?.myProfileHandler = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false 
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        view.backgroundColor = .white
        
        navigationItem.title = self.user.name
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: .xmarkImage, style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: .settingImage, style: .plain, target: self, action: #selector(handleDone))
        navigationController?.navigationBar.tintColor = .black 

        tableView.tableHeaderView = headerView
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 60, right: 0)
       
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 530)
        headerView.delegate = self
        imagePicker.delegate = self
        
        tableView.separatorStyle = .none
        
        tableView.register(AddIdealDateTableCell.self, forCellReuseIdentifier: AddIdealDateTableCell.identifier)
        tableView.register(SubscriptionTableCell.self,
                           forCellReuseIdentifier: SubscriptionTableCell.identifier)
        
        tableView.register(AddAboutMeTableCell.self,
                           forCellReuseIdentifier: AddAboutMeTableCell.identifier)
        
        tableView.register(AddBasicFactTableCell.self,
                           forCellReuseIdentifier: AddBasicFactTableCell.identifier)
        
        tableView.register(AddInterestTableCell.self,
                           forCellReuseIdentifier: AddInterestTableCell.identifier)
        
        
       
    }
    // MARK: - Helpers
    func updateUserInfo(user: User) {
        
        self.delegate?.myProfileSettingController(self, wantsToUpdate: user)
        self.user = user
        
        self.tableView.reloadData()
        self.tableView.layoutIfNeeded()
    }
    // MARK: - API
    
    func uploadImage(image: UIImage) {

        showLoader(true, withText: "Saving image")
        Service.uploadImage(image: image) { imageURL in
            self.user.imageURLs.append(imageURL)
            self.showLoader(false)
        }
        
    }
    func deleteImage(image: String, index: Int) {
        Service.deleteImage(user: user, imageString: image, index: index)
    }
    func setHeaderImage(_ image: UIImage?) {
        headerView.buttons[imageIndex].setImage(image?.withRenderingMode(.alwaysOriginal),
                                                for: .normal)
    }
    
    // MARK: - Selectors
    
    @objc
    private func handleCancel() {
        dismiss(animated: true)
    }
    @objc
    private func handleDone() {
        print("DEBUG: PRESENT ====")
        let alert = UIAlertController(title: "", message: "Do you want to log out?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Log out", style: .default) { _ in
            self.delegate?.myProfileControllerWantsToLogout(self)
            
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        self.present(alert, animated: true)
        
    }
}
// MARK: - UITableViewDataSauce


extension MyProfileController {
 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let section = SettingsSections(rawValue: indexPath.row) else {return UITableViewCell()}
        let viewModel = SettingsViewModel(user: self.user, section: section)
        
        if indexPath.row == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: SubscriptionTableCell.identifier, for: indexPath) as! SubscriptionTableCell
            cell.viewModel = viewModel
           
            cell.selectionStyle = .none
            
            return cell
        } else if indexPath.row == 1 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: AddAboutMeTableCell.identifier, for: indexPath) as! AddAboutMeTableCell
            
            cell.selectionStyle = .none
            cell.delegate = self
            cell.viewModel = viewModel 
            
            return cell
            
        }else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: AddBasicFactTableCell.identifier, for: indexPath) as! AddBasicFactTableCell
            
            cell.viewModel = viewModel
            
            cell.delegate = self
            cell.selectionStyle = .none
            
            return cell
        }else if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: AddInterestTableCell.identifier, for: indexPath) as! AddInterestTableCell
            cell.delegate = self
            cell.selectionStyle = .none
            cell.viewModel = viewModel
            
            return cell
            
        }else if indexPath.row == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: AddIdealDateTableCell.identifier, for: indexPath) as! AddIdealDateTableCell
            
            cell.delegate = self
            cell.selectionStyle = .none
            cell.viewModel = viewModel
            return cell
            
        }
        return UITableViewCell()

        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let section = SettingsSections(rawValue: indexPath.row) else {return 0 }
     
        let viewModel = SettingsViewModel(user: self.user, section: section)
        
        if indexPath.row == 0 {
            return 320
        }else if indexPath.row == 1 {
            let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
            let estimateSizeCell = AddAboutMeTableCell(frame: frame)
            estimateSizeCell.viewModel = viewModel
            estimateSizeCell.contentView.layoutIfNeeded()
            
            let targetSize = CGSize(width: view.frame.width, height: 700)
            let estimatedSize = estimateSizeCell.systemLayoutSizeFitting(targetSize)
           
            if viewModel.bio.isEmpty {
                print("DEBUG: THE SIZE OF ITEM IS 0")
                return 492
               
            }else {
                print("DEBUG: ADJUSTING TO FIT",estimatedSize.height)
                return estimatedSize.height
                
            }
        }else if indexPath.row == 2 {
            return 340
        }else if indexPath.row == 3 {
            
            return 330
            
        }else if indexPath.row == 4 {
            return 330
        }
        else {
            return 100
        }
    }

    
}
    // MARK: - SettingHeaderDelegate

extension MyProfileController: SettingHeaderDelegate  {
  
    func myProfileHeader(_ header: SettingHeader, user userInfo: User,
                         dimissButton: UIButton) {

        
    }
   
    func myProfileHeader(_ header: SettingHeader, user userInfo: User) {
        let controller = AllMyPhotosController()
        controller.passUser = self.user
        navigationController?.pushViewController(controller, animated: true)
    }
    
    
    func myProfileHeader(_ header: SettingHeader, select index: Int) {
        let image =   user.imageURLs[index]
        print("DEBUG: DELETED PHOTO IN INDEX \(String(describing: image))")
        deleteImage(image: image, index: index)
        
    }
    
    func settingHeader(_ header: SettingHeader, select index: Int) {
        self.imageIndex = index
        present(imagePicker, animated: true, completion: nil)
    }
    
}
// MARK: - UIImagePickerControllerDelegate

extension MyProfileController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let selectedImage = info[.originalImage] as? UIImage else {return}
        uploadImage(image: selectedImage)
        setHeaderImage(selectedImage)
        dismiss(animated: true, completion: nil)
    }
    
}
// MARK: - AddAboutMeTableCellDelegate

extension MyProfileController: AddAboutMeTableCellDelegate {
   
    func addAboutMeTableCell(_ cell: AddAboutMeTableCell, editOccupationBtn: UIButton) {
        let vc = AddJobController()
        vc.user = self.user
        vc.delegate = self
        present(vc, animated: true)
    }
    
    func addAboutMeTableCell(_ cell: AddAboutMeTableCell, editEducationBtn: UIButton) {
        let layout = UICollectionViewFlowLayout()
        let vc = AddEducationController(collectionViewLayout: layout)
        vc.user = self.user
        vc.delegate = self
        present(vc, animated: true)
    }
    
    func addAboutMeTableCell(_ cell: AddAboutMeTableCell, editBioBtn: UIButton) {
        let vc = AddBioController()
        vc.delegate = self
        vc.user = self.user
        vc.section = InterestSection.bio
        present(vc, animated: true)
        
    }
    
}
// MARK: - AddBasicFactTableCellDelegate

extension MyProfileController: AddBasicFactTableCellDelegate {
    
    func addBasicFactTableCell(_ cell: AddBasicFactTableCell, starSignBtn: UIButton) {
        let layout = UICollectionViewFlowLayout()
        let vc = AddStarSignController(collectionViewLayout: layout)
        vc.user = self.user
        vc.delegate = self
        present(vc, animated: true)
    }
    
    func addBasicFactTableCell(_ cell: AddBasicFactTableCell, heightBtn: UIButton) {
        let vc = AddHeightController()
        vc.delegate = self
        vc.user = self.user
        present(vc, animated: true)
    }
    
    func addBasicFactTableCell(_ cell: AddBasicFactTableCell, seekingBtn: UIButton) {
        let layout = UICollectionViewFlowLayout()
        let vc = AddSeekingStatusController(collectionViewLayout: layout)
        vc.user = self.user
        vc.delegate = self
        present(vc, animated: true)
    }
    
    func addBasicFactTableCell(_ cell: AddBasicFactTableCell, religionBtn: UIButton) {
        let layout = UICollectionViewFlowLayout()
        let vc = AddReligionController(collectionViewLayout: layout)
        vc.user = self.user
        vc.delegate = self
        present(vc, animated: true)
        
    }
    
    func addBasicFactTableCell(_ cell: AddBasicFactTableCell, genderButton: UIButton) {
        let layout = UICollectionViewFlowLayout()
        let vc = AddEthnicityController(collectionViewLayout: layout)
        vc.delegate = self
        vc.user = self.user
        present(vc, animated: true)
    }
    
    func addBasicFactTableCell(_ cell: AddBasicFactTableCell, lifeStyle: UIButton) {
        let layout = UICollectionViewFlowLayout()
        let vc = AddExcerciseHabitController(collectionViewLayout: layout)
        vc.user = self.user
        vc.delegate = self
        present(vc, animated: true)
    }
    
    
}
// MARK: - AddInterestTableCellDelegate

extension MyProfileController: AddInterestTableCellDelegate {
    func addInterestTableCell(_ cell: AddInterestTableCell, addMyFreeTimeEditBtn: UIButton) {
        let vc = AddBioController()
        vc.delegate = self
        vc.user = self.user
        vc.section = InterestSection.extraTime
        present(vc, animated: true)

    }
    
    func addInterestTableCell(_ cell: AddInterestTableCell, addMyBucketListEditBtn: UIButton) {
        let vc = AddBioController()
        vc.delegate = self
        vc.user = self.user
        vc.section = InterestSection.bucketList
        present(vc, animated: true)

    }
    
}


// MARK: - AddIdealDateTableCellDelegate

extension MyProfileController: AddIdealDateTableCellDelegate {
    func addIdealDateTableCell(_ cell: AddIdealDateTableCell, editIdealTypeButton: UIButton) {
        let vc = AddBioController()
        vc.delegate = self
        vc.user = self.user
        vc.section = InterestSection.idealType
        present(vc, animated: true)

       
    }
    
    func addIdealDateTableCell(_ cell: AddIdealDateTableCell, editIdealDateButton: UIButton) {
        let vc = AddBioController()
        vc.delegate = self
        vc.user = self.user
        vc.section = InterestSection.idealDate
        present(vc, animated: true)

       
    }
    

}
// MARK: - AddJobControllerDelegate

extension MyProfileController: AddJobControllerDelegate {
    func addJobController(_ controllerWantsToUpdate: AddJobController, user: User) {
        updateUserInfo(user: user)
    }
    
    
}
// MARK: - AddBioControllerDelegate
extension MyProfileController: AddBioControllerDelegate {
    func addBioController(_ controllerWantsToUpdate: AddBioController, user: User) {
        
        updateUserInfo(user: user)
        
    }
    
    
}

// MARK: - AddEducationControllerDelegate

extension MyProfileController: AddEducationControllerDelegate {
   
    func addEducationController(_ controllerWantsToUpdateEduction: AddEducationController, user: User) {
        
        updateUserInfo(user: user)
    }

    
}
// MARK: - AddEthnicityControllerDelegate

extension MyProfileController: AddEthnicityControllerDelegate {
    func addEthnicityController(_ controllerWantsToUpdateEduction: AddEthnicityController, user: User) {
        
        updateUserInfo(user: user)
        
    }
    
    
}
// MARK: - AddHeightControllerDelegate
extension MyProfileController: AddHeightControllerDelegate {
    func addHeightController(_ controllerWantsToUpdateEduction: AddHeightController, user: User) {
        
        updateUserInfo(user: user)
        
    }
    
}
// MARK: - AddStarSignControllerDelegate
extension MyProfileController: AddStarSignControllerDelegate {
    func addStarSignController(_ controllerWantsToUpdateEduction: AddStarSignController, user: User) {
        updateUserInfo(user: user)
    }
    
}
// MARK: - AddSeekingStatusControllerDelegate
extension MyProfileController: AddSeekingStatusControllerDelegate {
    func addSeekingStatusController(_ controllerWantsToUpdateEduction: AddSeekingStatusController, user: User) {
        updateUserInfo(user: user)
    }
    
    
}
// MARK: - AddReligionControllerDelegate
extension MyProfileController: AddReligionControllerDelegate {
    func addReligionController(_ controllerWantsToUpdateEduction: AddReligionController, user: User) {
        updateUserInfo(user: user)
    }
    
    
}
// MARK: - AddExcerciseHabitControllerDelegate
extension MyProfileController: AddExcerciseHabitControllerDelegate {
  
    func addExcerciseHabitController(_ controllerWantsToUpdateEduction: AddExcerciseHabitController, user: User) {
        updateUserInfo(user: user)
    }
    
}
