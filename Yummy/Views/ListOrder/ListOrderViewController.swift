//
//  ListOrderViewController.swift
//  Yummy
//
//  Created by hamdi on 25/02/2023.
//

import UIKit
import ProgressHUD
class ListOrderViewController: UIViewController {
  
    static var price :Int = 0
    @IBOutlet weak var noOrdersView: UIView!
    
    @IBOutlet weak var ordersViews: CardView!
    
    static var ordersCount =  0
     var orders = [Order](){
        didSet {
            ordersViews.isHidden = orders.isEmpty
            noOrdersView.isHidden = !ordersViews.isHidden
            listOrderTableView.reloadData()
            ListOrderViewController.ordersCount = orders.count
        }
        
    }
   
    @IBOutlet weak var listOrderTableView: UITableView!
    override func viewDidLoad() {
        navigationController?.navigationBar.tintColor =   #colorLiteral(red: 0.5803921569, green: 0.09019607843, blue: 0.1843137255, alpha: 1)
        super.viewDidLoad()
        registerCell()
        title = "Orders"
        
       
    }

    
    
 
    
  

    override func viewDidAppear(_ animated: Bool) {
        ProgressHUD.show()
        NetworkService.shared.fetchOrders { [weak self] (result) in
            switch result {
                
            case .success(let orders):
                ProgressHUD.dismiss()
               self?.orders =  orders
                ListOrderViewController.price = 0
                for item in orders {
                    ListOrderViewController.price += (item.dish?.calories)!
                }
                self?.listOrderTableView.reloadData()
            case .failure(let error):
                ProgressHUD.showError(error.localizedDescription)
            }
        }
       
    }
    
    @IBAction func btnCheckOutPreset(_ sender: Any) {
        let controller = MapViewController.instantiate(storyBord: "HomeUI")
        navigationController?.pushViewController(controller, animated: true)
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
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "") { action, view, complitionHandller in
            self.orders.remove(at: indexPath.row)
//            self.listOrderTableView.beginUpdates()
//            self.listOrderTableView.deleteRows(at: [indexPath], with: .fade)
//            self.listOrderTableView.endUpdates()
            complitionHandller(true)
        }
        deleteAction.image = UIImage(systemName: "trash")!
      
       
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
}
