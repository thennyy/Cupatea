//
//  AllMatchesController.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 11/8/22.
//

import UIKit

class AllMatchesController: UICollectionViewController {


    private let user: User
    private let toUser: User
    private var matches = [Match]()
    
    private lazy var navigationView = AddSettingNavigationView(title: "All Matches",
                                                               leftButton: .xmarkCircleImage!,
                                                               delegate: self)
    
    
    init(user: User, toUser: User) {
        self.user = user
        self.toUser = toUser 
        super.init(collectionViewLayout: UICollectionViewFlowLayout())

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        fetchMatches()
        
    }
    
  
    func fetchMatches() {
        Service.fetchMatches { matches in
            self.matches = matches
            self.collectionView.reloadData()
           // self.headerView.matches = matches
        }
    }
    func configureUI() {
        
       // configureCollectionGradientLayer()
        
        view.backgroundColor = .white
        view.addSubview(navigationView)
        navigationView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                              left: view.leftAnchor,
                              right: view.rightAnchor,
                              height: 90)
        
        
        collectionView.contentInset = UIEdgeInsets(top: 90, left: 0, bottom: 0, right: 0)
        collectionView.register(AllMatchesCollectionCell.self,
                                forCellWithReuseIdentifier: AllMatchesCollectionCell.identifier)
        
        
    }
    func configureCollectionGradientLayer(){
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.accentColor.cgColor, UIColor.white.cgColor]
        gradient.locations = [0,1]
        collectionView.layer.addSublayer(gradient)
        gradient.frame = view.frame
        
    }
    
}

extension AllMatchesController: AddSettingNavigationViewDelegate {
   
    func addSettingNavigationView(_ view: AddSettingNavigationView, leftButton: UIButton) {
        self.dismiss(animated: true)
    }
    
    func addSettingNavigationView(_ view: AddSettingNavigationView, rightButton: UIButton) {
        
    }
    
    
}
extension AllMatchesController {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AllMatchesCollectionCell.identifier, for: indexPath) as! AllMatchesCollectionCell
       
        cell.viewModel = MatchCellViewModel(match: matches[indexPath.row])
        
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return matches.count
        
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let uid = matches[indexPath.row].uid
        Service.fetchUser(withUid: uid) { user in
            let controller = ProfileController(user: user)
            controller.modalPresentationStyle = .fullScreen
            self.present(controller, animated: true, completion: nil)
        }

       // navigationController?.pushViewController(vc, animated: true)
    }
   
}
extension AllMatchesController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        let padding: CGFloat = 50
        let collectionViewSize = collectionView.frame.width - padding
        return CGSize(width:  collectionViewSize/2 , height: collectionViewSize/2)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
    }
}
