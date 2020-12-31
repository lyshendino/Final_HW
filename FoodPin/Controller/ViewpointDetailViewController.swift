//
//  ViewpointDetailViewController.swift
//  FoodPin
//
//  Created by NDHU_CSIE on 2020/11/5.
//  Copyright © 2020 NDHU_CSIE. All rights reserved.
//

import UIKit

class ViewpointDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var headerView: ViewpointDetailHeaderView!
    
    var viewpoint: RestaurantMO!
    
    // MARK: - Table view lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        
        // Configure header view
        headerView.nameLabel.text = viewpoint.name
        headerView.typeLabel.text = viewpoint.type
        if let viewpointImage = viewpoint.image {
            headerView.headerImageView.image = UIImage(data: viewpointImage as Data)
        }
        headerView.heartImageView.isHidden = (viewpoint.isVisited) ? false : true
        if let rating =  viewpoint.rating {
            headerView.ratingImageView.image = UIImage(named: rating)
        }
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ViewpointDetailIconTextCell.self), for: indexPath) as! ViewpointDetailIconTextCell
            //        cell.iconImageView.image = UIImage(systemName: "phone")?.withTintColor(.black, renderingMode: .alwaysOriginal)
            cell.iconImageView.image = UIImage(named: "phone")
            cell.shortTextLabel.text = viewpoint.phone
            cell.selectionStyle = .none
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ViewpointDetailIconTextCell.self), for: indexPath) as! ViewpointDetailIconTextCell
            //        cell.iconImageView.image = UIImage(systemName: "map")?.withTintColor(.black, renderingMode: .alwaysOriginal)
            cell.iconImageView.image = UIImage(named: "map")
            cell.shortTextLabel.text = viewpoint.location
            cell.selectionStyle = .none
            
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ViewpointDetailTextCell.self), for: indexPath) as! ViewpointDetailTextCell
            cell.descriptionLabel.text = viewpoint.summary
            cell.selectionStyle = .none
            
            return cell
            
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ViewpointDetailSeparatorCell.self), for: indexPath) as! ViewpointDetailSeparatorCell
            cell.titleLabel.text = "HOW TO GET HERE"
            cell.selectionStyle = .none
            
            return cell
            
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ViewpointDetailMapCell.self), for: indexPath) as! ViewpointDetailMapCell
            cell.selectionStyle = .none
            if let viewpointLocation = viewpoint.location {
                cell.configure(location: viewpointLocation)
            }
            
            return cell
            
        default:
            fatalError("Failed to instantiate the table view cell for detail view controller")
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMap" {
            let destinationController = segue.destination as! MapViewController
            destinationController.viewpoint = viewpoint
        }
        else if segue.identifier == "showReview" {
            let destinationController = segue.destination as! ReviewViewController
            destinationController.viewpoint = viewpoint
        }
    }
    
    @IBAction func close(segue: UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func rateViewpoint(segue: UIStoryboardSegue) {
        if let rating = segue.identifier {
            self.viewpoint.rating = rating
            self.headerView.ratingImageView.image = UIImage(named: rating)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    
    
}
