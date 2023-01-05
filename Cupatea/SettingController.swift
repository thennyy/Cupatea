//
//  SettingController.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 11/25/21.
//

import UIKit
import JGProgressHUD

protocol SettingsControllerDelegate: AnyObject {
    func settingsController(_ controller: SettingController, wantsToUpdate user: User)
    func settingsControllerWantsToLogout(_ controller: SettingController)
}
class SettingController: UITableViewController {
    
    //MARK: - Properties
    
    private var user: User
 //   private lazy var headerView = SettingHeader(user: user)
  //  private let footerView = SettingsFooter()
    private let imagePicker = UIImagePickerController()

    var imageIndex = 0
    
    weak var delegate: SettingsControllerDelegate?
    
    //MARK: - Lifecycle
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
        configureNotificationObserver()

    }
    //MARK: - Selectors
    
    @objc func keyboardWillShow(){
        if view.frame.origin.y == 0 {
            view.frame.origin.y -= 88
        }
    }
    @objc func keyboardWillHide() {
        if view.frame.origin.y != 0 {
            view.frame.origin.y = 0
        }
    }
    @objc
    private func handleCancel() {
        self.navigationController?.popViewController(animated: true)
      //  dismiss(animated: true)
    }
  
    @objc
    private func handleDone(){
        showLoader(true, withText: "Saving data")
        Service.saveUserData(fetchedUser: user) { error in
            self.showLoader(false)
            self.delegate?.settingsController(self, wantsToUpdate: self.user)
        }
       
    }
    
    // MARK: -  API
    
    func uploadImage(image: UIImage) {
        showLoader(true, withText: "Saving image")
        Service.uploadImage(image: image) { imageURL in
            self.user.imageURLs.append(imageURL)
            self.showLoader(false)
        }
    }
    //MARK: - Helpers
    func configureNotificationObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    func setHeaderImage(_ image: UIImage?){
    //    headerView.buttons[imageIndex].setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
    }
    func configureUI(){
        
        tableView.backgroundColor = .systemGroupedBackground
      //  footerView.delegate = self
        tableView.separatorStyle = .none 
        imagePicker.delegate = self
        navigationItem.title = "Settings"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(handleCancel))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleDone))

        tableView.register(SettingsCell.self, forCellReuseIdentifier: SettingsCell.identifier)
        tableView.estimatedRowHeight = 120

        
    }
}
//MARK: - UITableViewDataSource

extension SettingController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return SettingsSections.allCases.count 
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCell.identifier, for: indexPath) as! SettingsCell
        
        guard let section = SettingsSections(rawValue: indexPath.section) else {return cell}
        let viewModel = SettingsViewModel(user: user, section: section)
        cell.viewModel = viewModel
        cell.delegate = self
        
        return cell
    
    }
    
}
//MARK: - UITableViewDelegate

extension SettingController {
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 33
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       // guard let section = SettingsSections(rawValue: section) else { return nil }
        return ""
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let section = SettingsSections(rawValue: indexPath.section) else {return 0}
        return section == .ageRange ? 96 : 42
        
    }
    
}

// MARK: - UIImagePickerControllerDelegate

extension SettingController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let selectedImage = info[.originalImage] as? UIImage else {return}
        uploadImage(image: selectedImage)
        setHeaderImage(selectedImage)
        dismiss(animated: true, completion: nil)
    }
}
extension SettingController: SettingCellDelegate {
    
    func settingsCell(_ cell: SettingsCell, wantsToUpdateUserWith value: String, for section: SettingsSections) {
       /*
        switch section {
        case .name:
            user.name = value
        case .profession:
            user.profession = value
        case .company:
            user.company = value
        case .age:
            user.age = Int(value) ?? user.age
        case .bio:
            user.bio = value
        case .datePreference:
            user.datePreference = value
        case .education:
            user.eduction = value
        case .ageRange:
            break
        }*/
    }
    

}
