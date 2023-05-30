//
//  MenuController.swift
//  App-like-Uber-Firebase-backend
//
//  Created by Tazo Gigitashvili on 27.05.23.
//

import UIKit

private let reuseIdentifier = "MenuCell"

class MenuController: UITableViewController {
    
    //MARK: - Properties
    
    private let user: User
    
    private lazy var menuHeader: MenuHeader = {
        let frame = CGRect(x: 0, y: 0, width: self.view.frame.width - 80, height: 190)
        let view = MenuHeader(user: user, frame: frame)
        return view
    }()
    
    //MARK: - Lifecycle
    
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("tazo: MenuController frame: \(self.view.frame)")
        print("tazo: TableView frame: \(tableView.frame)")
        view.backgroundColor = .white
        configureTableView()
    }
    
    //MARK: - @objc Selectors
    
    //MARK: - UI
    
    func configureTableView() {
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.rowHeight = 60
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.tableHeaderView = menuHeader
    }
}

extension MenuController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        cell.textLabel?.text = "Menu Option"
        print("tazo: Dequeued cell for row \(indexPath.row)")
        return cell
    }
}
