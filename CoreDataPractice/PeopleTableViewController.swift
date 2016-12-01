//
//  PeopleTableViewController.swift
//  CoreDataPractice
//
//  Created by Hungju Lu on 01/12/2016.
//  Copyright © 2016 Hungju. All rights reserved.
//

import UIKit

fileprivate struct SegueIdentifiers {
    static let addPerson = "addPerson"
}

fileprivate struct CellIdentifiers {
    static let basicCell = "Cell"
}

class PeopleTableViewController: UITableViewController {

    fileprivate var dataConnector: CoreDataConnection!
    fileprivate var people: [Person]? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = NSLocalizedString("Names", comment: "")
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPerson(_:)))
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        self.dataConnector = CoreDataConnection(context: context)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.fetchPeople()
    }
    
    fileprivate func fetchPeople() {
        let people = self.dataConnector.reterivePeople(sortedByName: true)
        self.people = people?.filter({ (element) -> Bool in
            if let name = element.name {
                return name.capitalized == name
            }
            return false
        })
        self.tableView.reloadData()
    }
    
    // MARK: - Actions
    
    func addPerson(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: SegueIdentifiers.addPerson, sender: self)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        guard let _ = self.people else {
            return 0
        }
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let people = self.people else {
            return 0
        }
        return people.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.basicCell, for: indexPath)

        guard let people = self.people else {
            return cell
        }
        
        let person = people[indexPath.row]
        cell.textLabel?.text = person.name

        return cell
    }
}
