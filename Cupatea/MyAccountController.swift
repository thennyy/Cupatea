//
//  MyAccountController.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 6/23/22.
//

import UIKit
/*
protocol MyAccountControllerDelegate: AnyObject {
    func myAccountControllerWantsToLogout(_ controller: MyAccountController)
}

class MyAccountController: UITableViewController {

    // MARK: - Properties
    
    private let user: User
     var delegate: MyAccountControllerDelegate?
  //  private let footerView = SettingsFooter()
    
    init(user: User){
       
        self.user = user
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        navigationItem.title = "Account"
        tableView.register(MyAccountCell.self, forCellReuseIdentifier: MyAccountCell.identifier)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(handleSaveButton))
     //   tableView.tableFooterView = footerView
       // footerView.delegate = self
       // footerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 80)
    }
    
    // MARK: - Selectors
    
    @objc func handleSaveButton() {
        
    }
}
extension MyAccountController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyAccountCell.identifier, for: indexPath) as! MyAccountCell
        guard let sections = MyAccountSections(rawValue: indexPath.section) else {return cell}
        let viewModel = MyAccountViewModel(user: user, sections: sections)
        cell.viewModel = viewModel
        cell.selectionStyle = .none 
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return MyAccountSections.allCases.count
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let sections = MyAccountSections(rawValue: section) else {return nil}
        return sections.description
    }
}

extension MyAccountController: SettingsFooterDelegate {
    func handleLogout() {
        print("DEBUG: LOGING OUT")
        delegate?.myAccountControllerWantsToLogout(self)
    }
    
    
}

*/ 
