//
//  ProfileViewController.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 11/29/21.
//

import UIKit
import SDWebImage

protocol ProfileControllerDelegate: AnyObject {
    func profileController(_ controller: ProfileController, didLikeUser user: User)
    func profileController(_ controller: ProfileController, didDislikeUser user: User)
}

class ProfileController: UITableViewController {
    
    // MARK: - Properties
    
    private var numberOfCell = 0
    
    private let user: User
    weak var delegate: ProfileControllerDelegate?
    
    private var index = 0
    
    private lazy var viewModel = ProfileViewModel(user: user)
    private lazy var headerView = UserTableHeaderView(viewModel: viewModel)
    private let bottomControllerView = BottomControlView()
    

    // MARK: - Lifecycle
    
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureNumberofCell()
    }

    // MARK: - Helpers

    func configureNumberofCell() {
 
        if user.extraTime.isEmpty == false {
            self.numberOfCell += 1
            
        }
        if user.bucketList.isEmpty == false {
            self.numberOfCell += 1
        }
        if user.idealDate.isEmpty == false {
            self.numberOfCell += 1
        }
        if user.idealType.isEmpty == false {
            self.numberOfCell += 1
        }
        self.numberOfCell += 3
    }
    func createPageController() -> UIPageControl {
        
        let pageController = UIPageControl()
        pageController.numberOfPages = user.imageURLs.count
        pageController.currentPageIndicatorTintColor = .accentColor
        pageController.pageIndicatorTintColor = .white
        pageController.isEnabled = false 
        return pageController
        
    }

    func configureUI() {
        
        view.backgroundColor = .white

        tableView.contentInset = UIEdgeInsets(top: 0, left: 0,
                                              bottom: 30, right: 0)

        tableView.tableHeaderView = headerView
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width,
                                  height: 580)
        headerView.user = self.user
        headerView.delegate = self
        
        let footerView = ProfileTableFooterView()
        footerView.delegate = self
        footerView.frame = CGRect(x: 0, y: 0,
                                  width: view.frame.width,
                                  height: 120)
        
        tableView.tableFooterView = footerView
        
        tableView.register(AboutMeProfileTableCell.self, forCellReuseIdentifier: AboutMeProfileTableCell.identifier)
        tableView.register(BioTableCell.self, forCellReuseIdentifier: BioTableCell.identifier)
        tableView.register(FunFactTableView.self, forCellReuseIdentifier: FunFactTableView.identifier)
        tableView.register(SpendExtraTimeTableView.self, forCellReuseIdentifier: SpendExtraTimeTableView.identifier)
        tableView.register(BucketListTableCell.self, forCellReuseIdentifier: BucketListTableCell.identifier)
        tableView.register(IdealTypeCell.self, forCellReuseIdentifier: IdealTypeCell.identifier)
        tableView.register(IdealDateCell.self, forCellReuseIdentifier: IdealDateCell.identifier)
        
    
    }
 
}
// MARK: - UICollectionViewDataSource

extension ProfileController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfCell

    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        tableView.separatorStyle = .none
       
        guard let section = SettingsSections(rawValue: indexPath.row) else {return UITableViewCell()}
        let viewModel = SettingsViewModel(user: user, section: section)
        
        switch indexPath.row {
            
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: AboutMeProfileTableCell.identifier, for: indexPath) as! AboutMeProfileTableCell
            cell.viewModel = self.viewModel
          
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: BioTableCell.identifier,
                                                     for: indexPath) as! BioTableCell
            cell.viewModel = viewModel
            cell.selectionStyle = .none
          
            return cell
            
        case 2:
           
            let cell = tableView.dequeueReusableCell(withIdentifier: FunFactTableView.identifier,for: indexPath) as! FunFactTableView
            cell.viewModel = viewModel
            cell.selectionStyle = .none
         
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: SpendExtraTimeTableView.identifier,for: indexPath) as! SpendExtraTimeTableView
            
            cell.selectionStyle = .none
            cell.viewModel = viewModel
         
            return cell
        case  4:
            let cell = tableView.dequeueReusableCell(withIdentifier: BucketListTableCell.identifier,for: indexPath) as! BucketListTableCell
            
            cell.selectionStyle = .none
            cell.viewModel = viewModel
    
            return cell
        case  5:
            let cell = tableView.dequeueReusableCell(withIdentifier: IdealTypeCell.identifier,for: indexPath) as! IdealTypeCell
            
            cell.selectionStyle = .none
            cell.viewModel = viewModel
            self.numberOfCell += 1
            return cell
        case 6:
            let cell = tableView.dequeueReusableCell(withIdentifier: IdealDateCell.identifier, for: indexPath) as! IdealDateCell
            cell.viewModel = viewModel
        
            return cell
        default:
            
            return UITableViewCell()
        }
    
        
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
        guard let section = SettingsSections(rawValue: indexPath.row) else {return 0}
        let viewModel = SettingsViewModel(user: user, section: section)
      
        switch indexPath.row {
      
        case 0:
            
            return 66
        case 1:
            
            let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
            let estimateSizeCell = BioTableCell(frame: frame)
            estimateSizeCell.viewModel = viewModel
            estimateSizeCell.contentView.layoutIfNeeded()
            
            let targetSize = CGSize(width: view.frame.width, height: 500)
            let estimatedSize = estimateSizeCell.systemLayoutSizeFitting(targetSize)
           
            if viewModel.bio.isEmpty {
                print("DEBUG: THE SIZE OF ITEM IS 0")
                estimateSizeCell.titleLabel.isHidden = true
                return 0
               
            }else {
                print("DEBUG: ADJUSTING TO FIT",estimatedSize.height)
                estimateSizeCell.titleLabel.isHidden = false
                return estimatedSize.height
            }

        case 2:
            return 340
        case 3:
            let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
            let estimateSizeCell = SpendExtraTimeTableView(frame: frame)
            estimateSizeCell.viewModel = viewModel
            estimateSizeCell.contentView.layoutIfNeeded()
            
            let targetSize = CGSize(width: view.frame.width, height: 500)
            let estimatedSize = estimateSizeCell.systemLayoutSizeFitting(targetSize)
           
            if viewModel.extraTime.isEmpty {
                print("DEBUG: THE SIZE OF ITEM IS 0")
                return 0
               
            }else {
                print("DEBUG: ADJUSTING TO FIT",estimatedSize.height)
                return estimatedSize.height
            }
        case 4:
            let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
            let estimateSizeCell = BucketListTableCell(frame: frame)
            estimateSizeCell.viewModel = viewModel
            estimateSizeCell.contentView.layoutIfNeeded()
            
            let targetSize = CGSize(width: view.frame.width, height: 500)
            let estimatedSize = estimateSizeCell.systemLayoutSizeFitting(targetSize)
           
            if viewModel.bucketList.isEmpty {
                print("DEBUG: THE SIZE OF ITEM IS 0")
                return 0
               
            }else {
                print("DEBUG: ADJUSTING TO FIT",estimatedSize.height)
                return estimatedSize.height
            }
        case 5:
            let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
            let estimateSizeCell = IdealTypeCell(frame: frame)
            estimateSizeCell.viewModel = viewModel
            estimateSizeCell.contentView.layoutIfNeeded()
            
            let targetSize = CGSize(width: view.frame.width, height: 500)
            let estimatedSize = estimateSizeCell.systemLayoutSizeFitting(targetSize)
           
            if viewModel.idealType.isEmpty {
                print("DEBUG: THE SIZE OF ITEM IS 0")
                return 0
               
            }else {
                print("DEBUG: ADJUSTING TO FIT",estimatedSize.height)
                return estimatedSize.height
            }
        case 6:
            
            let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 0)
            let estimateSizeCell = IdealDateCell(frame: frame)
            estimateSizeCell.viewModel = viewModel
            estimateSizeCell.contentView.layoutIfNeeded()
            
            let targetSize = CGSize(width: view.frame.width, height: 500)
            let estimatedSize = estimateSizeCell.systemLayoutSizeFitting(targetSize)
           
            if viewModel.idealDate.isEmpty {
                print("DEBUG: THE SIZE OF ITEM IS 0")
                estimateSizeCell.isHidden = true
                return 0
               
            }else {
                print("DEBUG: ADJUSTING TO FIT",estimatedSize.height)
                estimateSizeCell.isHidden = false
                return estimatedSize.height
            }
        default:
            return 100
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                
    }

}
// MARK: - UserHeaderViewDelegate
extension ProfileController: UserHeaderViewDelegate {
    
    func userHeaderView(_ headerView: UserTableHeaderView, dismissButton: UIButton) {
        self.dismiss(animated: true)
    }
    func userHeaderView(_ headerView: UserTableHeaderView, likeButton: UIButton, user: User) {
        delegate?.profileController(self, didLikeUser: user)
    }
    
    func userHeaderView(_ headerView: UserTableHeaderView, cancelButton: UIButton, user: User) {
        
        delegate?.profileController(self, didDislikeUser: user)
        
    }


    func userHeaderView(_ headerView: UserTableHeaderView, pinButton: UIButton) {
        alertUserErrorMessage(message: "You are able to Pin once you become Our Premium Member")
    }

    
//    func userHeaderView(_ headerView: UserTableHeaderView, dismissButton: UIButton) {
//      print("DEBUG: HITTING DISMISSING BUTTON")
//        self.dismiss(animated: true)
//
//    }
    
}

extension ProfileController: ProfileTableFooterViewDelegate {
    func profileTableFooterView(_ footerView: ProfileTableFooterView, reportButton: UIButton) {
            print("DEBUG: REPORT THIS USER")
    }
    
}
