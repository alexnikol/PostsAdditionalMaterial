//
//  ViewController.swift
//  InterestsCollection
//
//  Created by Alexander Nikolaychuk on 09.03.2022.
//

import UIKit

class BooksListTableController: UITableViewController {
        
    var service: BooksService?
    var books: [Book] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(loadList), for: .valueChanged)
        loadList()
    }
    
    @objc
    func loadList() {
        refreshControl?.beginRefreshing()
        books = []
        tableView.reloadData()
        service?.loadList(completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let books):
                self.books = books
                self.tableView.reloadData()
            case .failure(let error):
                self.books = []
                self.showError(error.localizedDescription)
            }
            self.refreshControl?.endRefreshing()
        })
    }
    
    func showError(_ message: String) {
        let alert = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension BooksListTableController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = books[indexPath.row]
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: String(describing: BooksListTableController.self))
        cell.textLabel?.text = model.title
        cell.detailTextLabel?.text = model.author
        return cell
    }
}
