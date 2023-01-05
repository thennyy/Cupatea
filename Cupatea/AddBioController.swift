//
//  AddBioController.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 11/1/22.
//

import UIKit
protocol AddBioControllerDelegate: AnyObject {
    func addBioController(_ controllerWantsToUpdate: AddBioController, user: User)
}
class AddBioController: UIViewController {
    
    // MARK: - Properties
    
    private var reachWordCount = false
    
    weak var delegate: AddBioControllerDelegate?
    var user: User!
    var titleText: String?
    
    var section: InterestSection! {
        didSet {
            configureSection()
        }
    }

    private let backGroundView = UIView()
    
    private let bioWordCountView = WordCountView(wordCount:"300")
    
    private lazy var navigationView = AddSettingNavigationView(title: titleText,
                                                               leftButton: .xmarkCircleImage!,
                                                               rightButton: "Save",
                                                               delegate: self)

    private lazy var bioTextView = CustomTextView()
    
    private let addTextTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = .gray
        label.text = "Write here..."
        return label
    }()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        bioTextView.delegate = self
        
    }
    
    // MARK: - Helpers
    func configureUI() {
        
        view.backgroundColor = .white
        
        view.addSubview(navigationView)
        navigationView.anchor(top: view.topAnchor,
                              left: view.leftAnchor,
                              right: view.rightAnchor,
                              height: 60)
        
        view.addSubview(bioTextView)
        bioTextView.anchor(top: navigationView.bottomAnchor,
                           left: view.leftAnchor,
                           right: view.rightAnchor,
                           paddingTop: 40) 
                          
        
        view.addSubview(bioWordCountView)
        bioWordCountView.anchor(bottom: bioTextView.topAnchor,
                                right: bioTextView.rightAnchor,
                                paddingRight: 20,
                                height: 30)
        
        view.addSubview(addTextTitle)
        addTextTitle.anchor(top: bioTextView.topAnchor,
                            left: bioTextView.leftAnchor,
                            paddingTop: 20,
                            paddingLeft: 26)

    }
    
    func configureText(text: String) {
        
        self.bioTextView.text = text
        if text.isEmpty == false{
            addTextTitle.isHidden = true
            Service.countingBioTextView(bioTextView) { wordCount in
                self.bioWordCountView.wordCountLabel.text = wordCount
            }
            
        }else {
            addTextTitle.isHidden = false
        }
    }

    func configureSection() {
        
        switch section {
        case .bio:
            titleText = "Write Bio"
            configureText(text: user.bio)
        case .extraTime:
            titleText = "My Free Time"
            configureText(text: user.extraTime)
        case .bucketList:
            titleText = "My Bucket List"
            configureText(text: user.bucketList)
        case .idealType:
            titleText = "My Ideal Type"
            configureText(text: user.idealType)
        case .idealDate:
            titleText = "My Ideal Date"
            configureText(text: user.idealDate)
        case .none:
            break 
       
        }
    }
    

}

// MARK: - UITextViewDelegate

extension AddBioController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
    
        if textView.text.isEmpty == false {
            addTextTitle.isHidden = true
            self.navigationView.enableRightButton()
        }else {
            addTextTitle.isHidden = false
            self.navigationView.disableRightButton()
        }
        
        let count = textView.text?.count ?? 0
        
        if count <= 300 {
            Service.countingBioTextView(textView) { wordCount in
                self.bioWordCountView.wordCountLabel.text = wordCount
                self.bioWordCountView.underMaximumWordCount()
                self.reachWordCount = false
                
            }
        }else {
            self.alertMessage("Maximum words is 300", answerButton: "Dismiss")
            Service.countingBioTextView(textView) { wordCount in
                self.bioWordCountView.wordCountLabel.text = wordCount
                self.bioWordCountView.overMaximumWordCount()
                self.reachWordCount = true
            }
        }
        
    }
}

// MARK: - AddSettingNavigationViewDelegate

extension AddBioController: AddSettingNavigationViewDelegate {
    func addSettingNavigationView(_ view: AddSettingNavigationView, leftButton: UIButton) {
        self.dismiss(animated: true)
    }
    
    func addSettingNavigationView(_ view: AddSettingNavigationView, rightButton: UIButton) {
       
        if reachWordCount == true {
            self.alertMessage("Maximum words is 300", answerButton: "Dismiss")
        }else {
            
            guard let bioText = bioTextView.text else {return}
            
            Service.saveContentToDataBase(bioText, section: section) { data in
                Service.updateUserPreference(userId: self.user.uid, data: data) { user in
                    self.delegate?.addBioController(self, user: user)
                    self.dismiss(animated: true)
                    print("DEBUG: UPDATED INFO ADDED")
                }
            }
          //  let data: [String:Any] = ["bio":  bioText]
            
            
        
            
        }
        
    }

}
