//
//  PersonListViewController.swift
//  CoreDataModelExample
//
//  Created by Clay Tinnell on 2/26/15.
//  Copyright (c) 2015 Clay Tinnell. All rights reserved.
//

import UIKit
import CoreDataModel

class PersonListViewController: UITableViewController {

    var people: [Person] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "People"
        people = retrievePeople()        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countElements(people)
    }

    private func retrievePeople() -> [Person] {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        var (queryResult, personQueryError) = Person.allObjects(appDelegate.coreDataManager!.managedObjectContext!)
        if let error = personQueryError {
            println("Error retrieving Person: \(error.description)")
            queryResult = []
        }
        return queryResult
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        let person = people[indexPath.row]
        cell.textLabel?.text = person.name
        cell.detailTextLabel?.text = person.email
        return cell
    }

}
