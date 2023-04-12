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
    
    @IBOutlet weak var ordersViews: CardView!
    
    
    var orders = [Order](){
        didSet {
            ordersViews.isHidden = orders.isEmpty
            listOrderTableView.isHidden = ordersViews.isHidden
            noOrdersView.isHidden = !ordersViews.isHidden
            listOrderTableView.reloadData()
        }
        
    }
   
    @IBOutlet weak var listOrderTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        title = "Orders"
        orders.removeAll()
       
    }
    override func viewWillAppear(_ animated: Bool) {
        if orders.isEmpty == true {
            noOrdersView.isHidden = false
            ordersViews.isHidden = true
            listOrderTableView.isHidden = true
        }
        else{
            ordersViews.isHidden = false
            listOrderTableView.isHidden = false
            noOrdersView.isHidden = true
        }
    }
    
    
    @IBAction func goHomeTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        tabBarController?.tabBar.isHidden = false
        
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
