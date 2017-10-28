//
//  RobotListTableViewController.swift
//  AppBundleReader
//
//  Created by Erik Perez on 10/27/17.
//  Copyright © 2017 Eliel Gordon. All rights reserved.
//

import UIKit

class RobotListTableViewController: UITableViewController {
    
    var robots = [Robot]() {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsSelection = false
        
        let filePathURL = Bundle.main.url(forResource: "robo-profiles", withExtension: ".json")
        if let path = filePathURL {
            do {
                let data = try Data(contentsOf: path)
                let decodedRobots = try JSONDecoder().decode([Robot].self, from: data)
                self.robots = decodedRobots
            }catch {
                print(error)
            }
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return robots.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let robot = robots[indexPath.row]
        let robotImageURL = URL(string: robots[indexPath.row].image)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "robotCell", for: indexPath) as! RobotTableViewCell
        cell.nameLabel.text = robot.name
        cell.personalityLabel.text = robot.personality
        cell.phraseLabel.text = robot.phrase
        
        if let robotImageURL = robotImageURL{
            cell.photoImageView.downloadedFrom(url: robotImageURL, contentMode: .scaleAspectFit)
        }
        return cell
    }


    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
}







