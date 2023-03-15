//
//  ListOrderViewController.swift
//  Yummy
//
//  Created by hamdi on 25/02/2023.
//

import UIKit
import ProgressHUD
class ListOrderViewController: UIViewController {
    @IBOutlet weak var noOrdersView: CardView!
    var orders = [Order](){
        didSet {
            
            listOrderTableView.isHidden = orders.isEmpty
            noOrdersView.isHidden  = !listOrderTableView.isHidden
            listOrderTableView.reloadData()
        }
        
    }
   
    @IBOutlet weak var listOrderTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        title = "Orders"
        
       
    }
    
    @IBAction func btnGoHomePressed(_ sender: Any) {
        // Assuming you have a reference to the app's tab bar controller
        let tabBarController = self.tabBarController!

        // Determine which tab you want to switch to (e.g. the second tab)
        let desiredTabIndex = 0

        // Get a reference to the view controller that represents the desired tab
//        let desiredViewController = tabBarController.viewControllers![desiredTabIndex]

        // Set the selected index of the tab bar controller to the desired index
        tabBarController.selectedIndex = desiredTabIndex

        // Set the new set of view controllers for the tab bar controller
//        tabBarController.setViewControllers([desiredViewController], animated: true)
//        let storyboard = UIStoryboard(name: "HomeUI", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "HomeNC")as!UINavigationController
//        present(vc, animated: true,completion: nil)
    }
    override func viewDidAppear(_ animated: Bool) {
        ProgressHUD.show()
        NetworkService.shared.fetchOrders { [weak self] (result) in
            switch result {
                
            case .success(let orders):
                ProgressHUD.dismiss()
                self?.orders =  orders
                self?.listOrderTableView.reloadData()
            case .failure(let error):
                ProgressHUD.showError(error.localizedDescription)
            }
        }
       
    }
    
    func registerCell(){
        listOrderTableView.register(UINib(nibName: "DishListTableViewCell", bundle: nil), forCellReuseIdentifier: "DishListTableViewCell")
    }
   

}
extension ListOrderViewController :UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DishListTableViewCell", for: indexPath)as!DishListTableViewCell
        cell.setup(order: orders[indexPath.row])
        return cell 
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = DishDetailViewController.instantiate(storyBord: "HomeUI")
        controller.dish = orders[indexPath.row].dish
        navigationController?.pushViewController(controller, animated: true)
    }
    
    
}
