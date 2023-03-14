//
//  ListOrderViewController.swift
//  Yummy
//
//  Created by hamdi on 25/02/2023.
//

import UIKit
import ProgressHUD
class ListOrderViewController: UIViewController {
var orders = [Order]()
   
    @IBOutlet weak var listOrderTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        title = "Orders"
        if orders.count == 0 {
            listOrderTableView.isHidden = true

        }
       
    }
    
    @IBAction func btnGoHomePressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "HomeUI", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "HomeNC")as!UINavigationController
        present(vc, animated: true,completion: nil)
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
