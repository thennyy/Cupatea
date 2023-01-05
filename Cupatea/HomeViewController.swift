//
//  ProfileViewController.swift
//  EnterAct-Dating
//
//  Created by Thenny Chhorn on 10/17/21.
//

import UIKit
import Firebase
import SDWebImage

class HomeViewController: UIViewController {

    // MARK: - properties
    
    private var user: User?
    private let bottomControllerView = BottomControlView()
    
    private lazy var navigationView = HomeNavigationView()

    private let tabBarControlView = TabBarControllerView()
    
    private var topCardView: CardView?
    private var cardViews = [CardView]()
    
    var myProfileHandler: MyProfileController?

    private var viewModels = [CardViewModel]() {
        didSet{ configureCards()}
    }

    private let deckView: UIView = {
        let view = UIView()
        return view
    }()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkIfUserLoggedIn()
        configureUI()
        fetchCurrentUserAndCards()
        
       // myProfileHandler?.homeHandler = self
        
        tabBarControlView.delegate = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true 
    }
    //MARK: - API
   
    func fetchUsers(forCurrentUser user: User){
        self.user = user
        Service.fetchUsers(forCurrentuser: user) { users in
            self.viewModels = users.map({CardViewModel(user: $0)})
        }
    }

    func fetchCurrentUserAndCards() {
        
        guard let uid = Auth.auth().currentUser?.uid else {return}

        COLLECTION_USERS.document(uid).getDocument { snapshot, error in
            guard let dictionary = snapshot?.data() else {return}
            let user = User(dictionary: dictionary)
            
            guard let url = URL(string: user.imageURLs.first!) else {return}
            
            Service.loadImage(with: url) { image in
                self.navigationView.userButton.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
            }
            
            SDWebImageManager.shared.loadImage(with: url, options: .continueInBackground, progress: nil) { image, _, _, _, _, _ in
               
            }
   
            Service.fetchUser(withUid: uid) { user in
                self.fetchUsers(forCurrentUser: user)
            }
        }
    }
    func checkIfUserLoggedIn() {
        if Auth.auth().currentUser == nil {
            presentLoginController()
        }else {
            print("DEBUG: USER is logged in")
        }
    }
    func logout() {
        
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Log out", style: .default, handler: { _ in
            do {
            try Auth.auth().signOut()
                self.presentLoginController()
            } catch{
                print("DEBUG: failed to log out ..")
            }
        }))
        present(alert, animated: true, completion: nil)
      
    }
    func saveSwipesAndCheckForMatch(forUser user: User, didLike: Bool) {
        
        Service.saveSwipe(forUser: user, isLike: didLike) { error in
            self.topCardView = self.cardViews.last
            Service.checkIfMatchExists(forUser: user) { didMatch in
                self.presentMatchView(forUser: user)
                
                guard let currentUser = self.user else {return}
                Service.uploadMatch(currentUser: currentUser, matchedUser: user)
                
            }
        }
        
    }
    
    //MARK: - Helpers
    
    func performSwipeAnimation(shouldLike: Bool) {
        
        let translation: CGFloat = shouldLike ? 700 : -700
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut) {
            
            self.topCardView?.frame = CGRect(x: translation, y: 0,
                                             width: (self.topCardView?.frame.width)!,
                                             height: (self.topCardView?.frame.height)!)
            
        } completion: { _ in
            
            self.topCardView?.removeFromSuperview()
            guard !self.cardViews.isEmpty else {return}
            self.cardViews.remove(at: self.cardViews.count - 1)
            self.topCardView = self.cardViews.last
        }

    }
    
    func configureCards() {
        viewModels.forEach { viewModel in
            let cardView = CardView(viewModel: viewModel)
            cardView.delegate = self 
            deckView.addSubview(cardView)
            cardView.fillSuperview()
        }
        
        cardViews = deckView.subviews.map({ ($0 as? CardView)!})
        topCardView = cardViews.last
        
    }
    
    func configureUI(){
       
        view.backgroundColor = .white
        
        navigationView.delegate = self
        
        navigationController?.navigationBar.isHidden = true
       
        view.addSubview(navigationView)
        navigationView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                              left: view.leftAnchor,
                              right: view.rightAnchor,
                              height: 60)

        view.addSubview(tabBarControlView)
        tabBarControlView.anchor(left: view.leftAnchor,
                                 bottom: view.bottomAnchor,
                                 right: view.rightAnchor,
                                 paddingLeft: 20,
                                 paddingRight: 20,
                                 height: 90)
        
        let cardBackGroundView = UIView()
        cardBackGroundView.backgroundColor = .white
        cardBackGroundView.layer.cornerRadius = 30
        cardBackGroundView.layer.shadowRadius = 6
        cardBackGroundView.layer.shadowOpacity = 0.3
        
        view.addSubview(cardBackGroundView)
        cardBackGroundView.anchor(top: navigationView.bottomAnchor,
                                  left: view.leftAnchor,
                                  bottom: tabBarControlView.topAnchor ,
                                  right: view.rightAnchor,
                                  paddingTop: 20,
                                  paddingLeft: 20,
                                  paddingBottom: 0,
                                  paddingRight: 20)
        
        bottomControllerView.delegate = self
        view.addSubview(bottomControllerView)
        bottomControllerView.anchor(left: cardBackGroundView.leftAnchor,
                                    bottom: cardBackGroundView.bottomAnchor,
                                    right: cardBackGroundView.rightAnchor,
                                    paddingBottom: 20,
                                    height: 60)
        
        view.addSubview(deckView)
        deckView.anchor(top: cardBackGroundView.topAnchor,
                        left: cardBackGroundView.leftAnchor,
                        bottom: bottomControllerView.topAnchor ,
                        right: cardBackGroundView.rightAnchor,
                        paddingTop: 0,
                        paddingLeft: 0,
                        paddingBottom: 20,
                        paddingRight: 0)
        
    
    }
    
    func presentLoginController() {
        
        DispatchQueue.main.async {
            
            let controller = WelcomeController()
            controller.delegate = self
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        }
    }
    func presentMatchView(forUser user: User){
        guard let currentUser = self.user else {return}
        let viewModel = MatchViewViewModel(currentUser: currentUser, matchedUser: user)
        let matchView = MatchView() 
        matchView.viewModel = viewModel 
        view.addSubview(matchView)
        matchView.fillSuperview()
        
    }
}

//MARK: - HomeNavigationViewDelegate

extension HomeViewController: HomeNavigationViewDelegate {
    
    func showSettings() {
        guard let user = self.user else {return}
        let controller = MyProfileController(user: user)
        controller.delegate = self
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
        
    }
    
    func showMatchingController() {
        print("DEBUG: show matching controller")
        
        guard let uid = self.user?.uid else {return}
        Service.fetchUser(withUid: uid) { user in
            guard let fromUser = self.user else {return}
            let vc = AllMatchesController(user: fromUser, toUser: user)
            self.present(vc, animated: true)
        }
        
    }
    
    // MARK: - Actions
    

    @objc func handlePin() {
        print("DEBUG: pin")
        alertUserErrorMessage(message: "You are able to Pin once you become Our Premium Member")
    }
}


// MARK: - CardViewDelegate

extension HomeViewController: CardViewDelegate {
  
    
    func cardView(_ view: CardView, wantsToSendGiftToUser user: User) {
        let layout = UICollectionViewFlowLayout()
        let vc = GiftController(collectionViewLayout: layout)
        self.present(vc, animated: true)
    }
   
    func cardView(_ view: CardView, didLikeUser: Bool) {
        view.removeFromSuperview()
        cardViews.removeAll(where: { view == $0})
        guard let user = topCardView?.viewModel.user else {return}
        saveSwipesAndCheckForMatch(forUser: user, didLike: didLikeUser)
        self.topCardView = cardViews.last

    }

    func cardView(_ view: CardView, wantsToShowProfileFor user: User) {
        let controller = ProfileController(user: user)
        controller.delegate = self
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true, completion: nil)

    }
    
}
// MARK: - ProfileControllerDelegate

extension HomeViewController: ProfileControllerDelegate {
    
    func profileController(_ controller: ProfileController, didLikeUser user: User) {
        controller.dismiss(animated: true) {
            
            self.performSwipeAnimation(shouldLike: true)
            self.saveSwipesAndCheckForMatch(forUser: user, didLike: true)
            controller.dismiss(animated: true)
        }
   
    }
    
    func profileController(_ controller: ProfileController, didDislikeUser user: User) {
        controller.dismiss(animated: true) {
            self.performSwipeAnimation(shouldLike: false)
            self.saveSwipesAndCheckForMatch(forUser: user, didLike: false)
            controller.dismiss(animated: true)
        }
       
    }
}

// MARK: - AuthenticationDelegate

extension HomeViewController: AuthenticationDelegate {
    
    func authenticationComplete() {
        dismiss(animated: true, completion: nil)
        fetchCurrentUserAndCards()
        
    }

}


// MARK: - TabBarControllerViewDelegate

extension HomeViewController: TabBarControllerViewDelegate {
  
    func tabBarControllerView(_ view: TabBarControllerView, messageButton: UIButton) {
     
        guard let user = user else {return}
       
        let vc = MessagesController(collectionViewLayout: UICollectionViewFlowLayout())
        vc.user = user
        navigationController?.pushViewController(vc, animated: true)
 
    }
    
    func tabBarControllerView(_ view: TabBarControllerView, userButton: UIButton) {
        guard let user = self.user else {return}
        let controller = MyProfileController(user: user)
        controller.delegate = self
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        
        present(nav, animated: true, completion: nil)
        
    }
}
// MARK: - MyProfileControllerDelegate
extension HomeViewController: MyProfileControllerDelegate {
    
    func myProfileControllerWantsToLogout(_ controller: MyProfileController) {
      //  logout()
        print("Login out")
        
        do {
        try Auth.auth().signOut()
            print("DEBUG: User not logged in...")
            self.presentLoginController()
        } catch{
            print("DEBUG: failed to log out ..")
        }
        controller.dismiss(animated: true)
    }
    
  
    func myProfileSettingController(_ controller: MyProfileController, wantsToUpdate user: User) {
        print("DEBUG: USER DEBUG ====> ", user.bio)
        Service.fetchUser(withUid: user.uid) { user in
            self.user = user
        }
    }
    
    func myProfileSettingController(_ controller: MyProfileController) {
        
    }
    
}
// MARK: - BottomViewDelegate

extension HomeViewController: BottomViewDelegate {
    
    func handleLike() {
        guard let topView = topCardView else {return}
        performSwipeAnimation(shouldLike: true)
        Service.saveSwipe(forUser: topView.viewModel.user, isLike: true, completion: nil)
        
    }
    
    func handleDislike() {
        
        guard let topView = topCardView else {return}
        performSwipeAnimation(shouldLike: false)
        Service.saveSwipe(forUser: topView.viewModel.user, isLike: false, completion: nil)
    }
}
/*view.removeFromSuperview()
 cardViews.removeAll(where: { view == $0})
 guard let user = topCardView?.viewModel.user else {return}
 saveSwipesAndCheckForMatch(forUser: user, didLike: didLikeUser)
 self.topCardView = cardViews.last
 */
