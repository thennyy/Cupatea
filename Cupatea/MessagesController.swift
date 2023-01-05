//
//  MessagesController.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 1/19/22.
//

import UIKit
import Firebase

class MessagesController: UICollectionViewController {
    
    private var conversations = [Conversation]()
    
    var user: User?
    private var matches = [Match]()
    
    private var headerView = MatchHeader()
   
    private var navigationView = NavigationView(title: "Messages",
                                                rightButtonImage: UIImage(named: "cup"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        configureUI()
        fetchMatches()
        fetchConverstations()
        fetchUser()
        
    }
    
    func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        Service.fetchUser(withUid: uid) { user in
            
            self.user = user
        }
    }
    func fetchMatches() {
        Service.fetchMatches { matches in
            self.matches = matches
           // self.headerView.matches = matches
        }
    }
    func fetchConverstations() {
        Service.fetchConverstation { conversations in
            self.conversations = conversations
            self.collectionView.reloadData()
        }
        
    }
    func configureUI() {
        
        view.backgroundColor = .accentColor
        navigationView.delegate = self
        headerView.delegate = self 
        view.addSubview(navigationView)
        navigationView.anchor(top: view.topAnchor,
                              left: view.leftAnchor,
                              right: view.rightAnchor,
                              height: 120)
        
        collectionView.register(MessageCell.self,
                                forCellWithReuseIdentifier: MessageCell.identifier)
        collectionView.register(MatchHeader.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: MatchHeader.identifier)
        collectionView.contentInset = UIEdgeInsets(top: 90, left: 0, bottom: 0, right: 0)
        
    }
}
extension MessagesController: NavigationViewDelegate {
    func navigationView(_ view: NavigationView, leftButton: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    func navigationView(_ view: NavigationView, rightButton: UIButton) {
      
        guard let uid = self.user?.uid else {return}
        Service.fetchUser(withUid: uid) { user in
            guard let fromUser = self.user else {return}
            let vc = AllMatchesController(user: fromUser, toUser: user)
            self.present(vc, animated: true)
            
        }

    }
    
    
}
extension MessagesController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return conversations.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MessageCell.identifier, for: indexPath) as! MessageCell
        cell.conversation = conversations[indexPath.row]
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MatchHeader.identifier, for: indexPath) as! MatchHeader
        header.delegate = self
        header.matches = self.matches
        return header
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width , height: 150)
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let toUser = conversations[indexPath.row].user
        guard let user = self.user else {return}
       let controller = ChatController(toUser: toUser, currentUser: user)
       navigationController?.pushViewController(controller, animated: true)
    }
}
extension MessagesController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 15, height: 120)
    }
    
}
extension MessagesController: MatchHeaderDelegate {
    
    func matchHeader(_ header: MatchHeader, wantsToChatWith uid: String) {
        Service.fetchUser(withUid: uid) { user in
            guard let fromUser = self.user else {return}
            let vc = ChatController(toUser: user, currentUser: fromUser)
            //self.present(vc, animated: true)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
