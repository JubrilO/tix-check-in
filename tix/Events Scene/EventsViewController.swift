//
//  HomeViewController.swift
//  tix
//
//  Created by Jubril on 18/11/2018.
//  Copyright © 2018 Tix. All rights reserved.
//

import UIKit

class EventsViewController: UIViewController, Storyboardable {
    var coordinator: EventsCoordinator?
    var events = [GetEventsQuery.Data.CurrentUser.Event.Edge.Node]() {
        didSet{
            if events.isEmpty {
                tableView.isHidden = true
                emptyDataLabel.isHidden = false
            }
            else {
                emptyDataLabel.isHidden = true
                tableView.isHidden = false
                tableView.reloadData()
            }
        }
    }
    @IBOutlet weak var emptyDataLabel: UILabel!
    
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    let loadingVC = LoadingViewController.instantiate()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.contentInset = UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 0)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 65
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
        
    }
    
    func fetchData() {
        showActivityIndicator()
        ApolloManager().apolloClient.fetch(query: GetEventsQuery()) {[weak self]
            result, error in
            print("Fetched events")
            self?.hideActivityIndicator()
            
            guard error == nil else {
                self?.displayErrorModal(error: error?.localizedDescription)
                return
            }
            guard result?.errors == nil else {
                var string = ""
                for graphQLError in result!.errors! {
                    string = string + graphQLError.localizedDescription + ". "
                }
                self?.displayErrorModal(error: string)
                return
            }
            guard let events = result?.data?.currentUser?.events else{
                print("No events")
                return
            }
            let it = events.edges!.map {$0!.node!}
            print("Event count = \(it.count)")
            self?.events = it.sorted(by: { $0.startDate < $1.startDate})
            
        }
    }
    
    func showActivityIndicator() {
        add(loadingVC)
        
    }
    
    func hideActivityIndicator() {
        loadingVC.remove()
    }
    
    @IBAction func onLogoutButtonTap(_ sender: UIButton) {
        coordinator?.logoutUser()
    }
    
}

extension EventsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let event = events[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell") as! EventTableViewCell
        let startDate = Date(timeIntervalSince1970: Double(event.startDate))
        
        cell.titleLabel.text = event.title
        cell.timeLabel.text = startDate.timeAgoSinceNow()
        return cell
        //cell.timeLabel.text = event.
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let event = events[indexPath.row]
        coordinator?.pushCheckOrderScene(event: event)
    }
}
