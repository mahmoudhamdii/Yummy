//
//  HomeViewController.swift
//  Yummy
//
//  Created by hamdi on 23/02/2023.
//

import UIKit
import ProgressHUD
class HomeViewController: UIViewController {
   
    @IBOutlet weak var chefCollectionView: UICollectionView!
    @IBOutlet weak var popularCollectionView: UICollectionView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    var arrpopulars = [Dish]()
    var arrspecials = [Dish]()
    var arrCategory = [DishCategory]()
    override func viewDidLoad() {
       
       
        super.viewDidLoad()
        
        registerNib()
        
        
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        popularCollectionView.delegate = self
        popularCollectionView.dataSource = self
        chefCollectionView.dataSource = self
        chefCollectionView.delegate = self
        
        
      
        ProgressHUD.show()
        NetworkService.shared.fetchAllCategories { [weak self](result) in
            switch result {
                
            case .success(let allDishes):
              
                ProgressHUD.dismiss()
                self?.arrCategory = allDishes.categories ?? []
                self?.arrCategory  = Array((self?.arrCategory.reversed())!)
                self?.categoryCollectionView.reloadData()
                self?.arrpopulars = allDishes.populars ?? []
                self?.arrpopulars  = Array((self?.arrpopulars.reversed())!)
                self?.popularCollectionView.reloadData()
                
                self?.arrspecials = allDishes.specials ?? []
                
                self?.chefCollectionView.reloadData()
               
                
            case .failure(let error):
               
                ProgressHUD.showError(error.localizedDescription)
            }
        }
        if  SignUpViewController.newAcount ==  true  {
            LocalNotifaction.firstCouponNotifaction(userName: SignUpViewController.userAuth)
            SignUpViewController.newAcount = false
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        createBarButtonBadge()
        tabBarController?.tabBar.isHidden = false
    }
    func createBarButtonBadge(){
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        button.layer.cornerRadius = button.frame.width / 2.0
        
        let color = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        button.setImage(UIImage(systemName: "cart.fill")!.withTintColor(color, renderingMode: .alwaysOriginal), for: .normal)
        let badgeLabel = UILabel(frame: CGRect(x: button.frame.width - 18, y: 25, width: 20, height: 20))
        badgeLabel.layer.cornerRadius = badgeLabel.frame.width / 2.0
        badgeLabel.layer.masksToBounds = true
        badgeLabel.textAlignment = .center
        badgeLabel.backgroundColor = #colorLiteral(red: 0.5803921569, green: 0.09019607843, blue: 0.1843137255, alpha: 1)
        badgeLabel.textColor = #colorLiteral(red: 0.9960784314, green: 0.9960784314, blue: 0.9960784314, alpha: 1)
        let customFont = UIFont(name: "Almarai-Bold", size: 14.0)!
        badgeLabel.font = customFont
        badgeLabel.text = ("\(ListOrderViewController.ordersCount)")
        if ListOrderViewController.ordersCount != 0 {
            button.addSubview(badgeLabel)
        }
      
        button.addTarget(self, action: #selector(ordersButtonTapped), for: .touchUpInside)
        let barButtonItem = UIBarButtonItem(customView: button)
        navigationItem.rightBarButtonItem = barButtonItem
        
        
    }
    @objc func ordersButtonTapped(){
        let controller = ListOrderViewController.instantiate(storyBord: "HomeUI")
        navigationController?.pushViewController(controller, animated: true)
        tabBarController?.tabBar.isHidden = true
        
    }
    private func registerNib (){
        
        categoryCollectionView.register(UINib(nibName: "CategoryCollectionViewCel", bundle:nil), forCellWithReuseIdentifier: "cel")
        popularCollectionView.register(UINib(nibName: "DishPortraitCollectionViewCell", bundle:nil), forCellWithReuseIdentifier: "DishPortraitCollectionViewCell")
        chefCollectionView.register(UINib(nibName: "DishLandscapeCollectionViewCell", bundle:nil), forCellWithReuseIdentifier: "DishLandscapeCollectionViewCell")
        
        
    }
    
    
    
}
extension HomeViewController :UICollectionViewDelegate , UICollectionViewDelegateFlowLayout , UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case categoryCollectionView :
            return arrCategory.count
            
        case  popularCollectionView :
            return  arrpopulars.count
        case chefCollectionView :
            return arrspecials.count
        default:
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case categoryCollectionView :
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cel", for: indexPath)as?CategoryCollectionViewCell{
                
                cell.setUp(category: arrCategory[indexPath.row])
                return cell
            }
            return UICollectionViewCell()
            
        case  popularCollectionView :
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DishPortraitCollectionViewCell", for: indexPath)as?DishPortraitCollectionViewCell{
                
                cell.setUp(dish: arrpopulars[indexPath.row])
                return cell
            }
            return UICollectionViewCell()
        case chefCollectionView  :
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DishLandscapeCollectionViewCell", for: indexPath)as?DishLandscapeCollectionViewCell{
                
                cell.setup(dish: arrspecials[indexPath.row])
                return cell
            }
            return UICollectionViewCell()
        default:
            return UICollectionViewCell()
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoryCollectionView {
            let controller = ListDishesViewController.instantiate(storyBord: "HomeUI")
            controller.category = arrCategory[indexPath.row]
            navigationController?.pushViewController(controller, animated: true)
        }
        else {
            let controller = DishDetailViewController.instantiate(storyBord: "HomeUI")
            controller.dish = collectionView == popularCollectionView ? arrpopulars[indexPath.row] : arrspecials[indexPath.row]
            navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    
}
