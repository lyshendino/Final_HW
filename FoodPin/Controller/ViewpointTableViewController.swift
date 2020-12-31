//
//  ViewpointTableViewController.swift
//  PPPPPoint
//
//  Created by NDHU_CSIE on 2020/10/22.
//  Copyright © 2020 NDHU_CSIE. All rights reserved.
//

import UIKit
import CoreData

class ViewpointTableViewController: UITableViewController, UISearchResultsUpdating, NSFetchedResultsControllerDelegate {
    
    var viewpoints: [RestaurantMO] = []
    var fetchResultController: NSFetchedResultsController<RestaurantMO>!
    var viewpointToUpdate: RestaurantMO?
    var searchController: UISearchController!
    var searchResults: [RestaurantMO] = []
    
    
    // MARK: - Table view lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        loadViewpointFromDatabase()
        if viewpoints.isEmpty {
            //print("generate data from begining")
            Viewpoint.writeViewpointFromBegin()
        }
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        searchController = UISearchController(searchResultsController: nil)
        self.navigationItem.searchController = searchController
        
        searchController.searchResultsUpdater = self
        //not change the color of the search contents
        searchController.obscuresBackgroundDuringPresentation = false
        
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if searchController.isActive {
            return searchResults.count
        } else {
            return viewpoints.count
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "datacell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ViewpointTableViewCell
        
        // Configure the cell...
        // Determine if we get the viewpoint from search result or the original array
        let viewpoint = (searchController.isActive) ? searchResults[indexPath.row] : viewpoints[indexPath.row]
        
        
        cell.nameLabel.text = viewpoint.name
        cell.locationLabel.text = viewpoint.location
        cell.typeLabel.text = viewpoint.type
        if let viewpointImage = self.viewpoints[indexPath.row].image {
            cell.thumbnailImageView.image = UIImage(data: viewpointImage as Data)
        }
        
        if viewpoint.isVisited {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        //cell.accessoryType = restaurantIsVisited[indexPath.row] ? .checkmark : .none
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if searchController.isActive {
            return false
        } else {
            return true
        }
    }
    
    
    //   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    //        // Create an option menu as an action sheet
    //        let optionMenu = UIAlertController(title: nil, message: "What do you want to do?", preferredStyle: .actionSheet)
    //
    //        if let popoverController = optionMenu.popoverPresentationController {
    //            if let cell = tableView.cellForRow(at: indexPath) {
    //                popoverController.sourceView = cell
    //                popoverController.sourceRect = cell.bounds
    //            }
    //        }
    //
    //        // Add Call action
    //        let callActionHandler = { (action:UIAlertAction!) -> Void in
    //            let alertMessage = UIAlertController(title: "Service Unavailable", message: "Sorry, the call feature is not available yet. Please retry later.", preferredStyle: .alert)
    //            alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    //            self.present(alertMessage, animated: true, completion: nil)
    //        }
    //
    //        let callAction = UIAlertAction(title: "Call " + "123-000-\(indexPath.row)", style: .default, handler: callActionHandler)
    //        optionMenu.addAction(callAction)
    //
    //        // Check-in action
    //        let checkInAction = UIAlertAction(title: "Check in", style: .default, handler: {
    //            (action:UIAlertAction!) -> Void in
    //
    //            let cell = tableView.cellForRow(at: indexPath)
    //            cell?.accessoryType = .checkmark
    //            self.restaurantIsVisited[indexPath.row] = true
    //        })
    //        optionMenu.addAction(checkInAction)
    //
    //        //add undo check-in action
    //        let uncheckInAction = UIAlertAction(title: "Undo Check in", style: .default, handler: {
    //            (action:UIAlertAction!) -> Void in
    //
    //            let cell = tableView.cellForRow(at: indexPath)
    //            if self.restaurantIsVisited[indexPath.row] {  //if ckecked
    //                cell?.accessoryType = .none
    //                self.restaurantIsVisited[indexPath.row] = false
    //            }
    //        })
    //        optionMenu.addAction(uncheckInAction)
    //
    //
    //
    //        // Add actions to the menu
    //        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    //        optionMenu.addAction(cancelAction)
    //
    //        // Display the menu
    //        present(optionMenu, animated: true, completion: nil)
    //
    //        // Deselect a row
    //        tableView.deselectRow(at: indexPath, animated: false)
    
    
    //   }
    
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, sourceView, completionHandler) in
            // Delete the row from the data store
            if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
                let context = appDelegate.persistentContainer.viewContext
                let viewpointToDelete = self.fetchResultController.object(at: indexPath)
                context.delete(viewpointToDelete)
                
                appDelegate.saveContext()
            }
            
            // Call completion handler with true to indicate
            completionHandler(true)
        }
        
        let shareAction = UIContextualAction(style: .normal, title: "Share") { (action, sourceView, completionHandler) in
            let defaultText = "Just checking in at " + self.viewpoints[indexPath.row].name!
            
            let activityController = UIActivityViewController(activityItems: [defaultText], applicationActivities: nil)
            self.present(activityController, animated: true, completion: nil)
            completionHandler(true)
        }
        
        let editAction = UIContextualAction(style: .normal, title: "Edit") { (action, sourceView, completionHandler) in
            //get the cooresponding managed object
            self.viewpointToUpdate = self.fetchResultController.object(at: indexPath)
            self.performSegue(withIdentifier: "updateViewpoint", sender: nil)
            print("editing")
            
            completionHandler(true)
        }
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction, shareAction, editAction])
        
        // Set the icon and background color for the actions
        deleteAction.backgroundColor = UIColor(red: 231.0/255.0, green: 76.0/255.0, blue: 60.0/255.0, alpha: 1.0)
        //deleteAction.image = UIImage(systemName: "trash") //iOS 13
        deleteAction.image = UIImage(named: "delete")  //iOS 12
        
        
        shareAction.backgroundColor = UIColor(red: 254.0/255.0, green: 149.0/255.0, blue: 38.0/255.0, alpha: 1.0)
        //shareAction.image = UIImage(systemName: "square.and.arrow.up")
        shareAction.image = UIImage(named: "share") //iOS 12
        
        return swipeConfiguration
    }
    
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let checkInAction = UIContextualAction(style: .normal, title: "Check-in") { (action, sourceView, completionHandler) in
            
            let cell = tableView.cellForRow(at: indexPath) as! ViewpointTableViewCell
            self.viewpoints[indexPath.row].isVisited = (self.viewpoints[indexPath.row].isVisited) ? false : true
            cell.accessoryType = self.viewpoints[indexPath.row].isVisited ? .checkmark : .none
            
            completionHandler(true)
        }
        
        // let checkInIcon = viewpoints[indexPath.row].isVisited ? "arrow.uturn.left" : "checkmark"
        let checkInIcon = viewpoints[indexPath.row].isVisited ? "undo" : "tick"
        checkInAction.backgroundColor = UIColor(red: 38.0/255.0, green: 162.0/255.0, blue: 78.0/255.0, alpha: 1.0)
        //checkInAction.image = UIImage(systemName: checkInIcon)
        checkInAction.image = UIImage(named: checkInIcon)  //iOS 12
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [checkInAction])
        
        
        return swipeConfiguration
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showViewpointDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! ViewpointDetailViewController
                destinationController.viewpoint = (searchController.isActive) ? searchResults[indexPath.row] : viewpoints[indexPath.row]
            }
        }
        else if segue.identifier == "updateViewpoint" {
            let destinationController = segue.destination as! UINavigationController
            let topView = destinationController.topViewController as! NewViewpointController
            topView.viewpointToUpdate = viewpointToUpdate
        }
        
    }
    
    
    @IBAction func unwindToHome(segue: UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }
    
    // Fetch data from data store
    private func loadViewpointFromDatabase() {
        let fetchRequest: NSFetchRequest<RestaurantMO> = RestaurantMO.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            let context = appDelegate.persistentContainer.viewContext
            fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultController.delegate = self
            
            do {
                try fetchResultController.performFetch()
                if let fetchedObjects = fetchResultController.fetchedObjects {
                    viewpoints = fetchedObjects
                    //print("load data from database with \(restaurants.count) entries")
                }
            } catch {
                print(error)
            }
        }
    }
    
    // MARK: - NSFetchedResultsControllerDelegate methods
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            if let newIndexPath = newIndexPath {
                tableView.insertRows(at: [newIndexPath], with: .fade)
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        case .update:
            if let indexPath = indexPath {
                tableView.reloadRows(at: [indexPath], with: .fade)
            }
        default:
            tableView.reloadData()
        }
        
        if let fetchedObjects = controller.fetchedObjects {
            viewpoints = fetchedObjects as! [RestaurantMO]
        }
    }
    
    
    
    // MARK: - Search bar none core data version
    
    func filterContent(for searchText: String) {
        
        searchResults = viewpoints.filter({ (viewpoint) -> Bool in
            let name = viewpoint.name
            let isMatch = name!.localizedCaseInsensitiveContains(searchText)
            
            return isMatch
        })
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filterContent(for: searchText)
            tableView.reloadData()
        }
    }
    
    
    
}

