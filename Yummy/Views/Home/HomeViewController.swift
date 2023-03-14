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
                print(self?.arrCategory ?? [])
                self?.categoryCollectionView.reloadData()
                self?.arrpopulars = allDishes.populars ?? []
                print(self?.arrpopulars ?? [])
                self?.popularCollectionView.reloadData()
               
                self?.arrspecials = allDishes.specials ?? []
                print(self?.arrspecials ?? [])
                self?.chefCollectionView.reloadData()
               
                
            case .failure(let error):
               
                ProgressHUD.showError(error.localizedDescription)
            }
        }

        
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
