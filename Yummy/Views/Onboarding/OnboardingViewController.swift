//
//  OnboardingViewController.swift
//  Yummy
//
//  Created by hamdi on 23/02/2023.
//

import UIKit

class OnboardingViewController: UIViewController {
    var currentPage = 0 {
        didSet {
            if currentPage == arrslides.count - 1 {
                btnNext.setTitle("Get Start", for: .normal)
            }else{
                btnNext.setTitle("Next", for: .normal)
            }
        }
    }
    var arrslides =  [OnboardingSlide]()
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        arrslides.append(OnboardingSlide(tittle: "Delicious Dishes", description: "Experience a variety of amazing dishes from different cultures around the world.", photo: UIImage(named : "slide1")!))
        arrslides.append(OnboardingSlide(tittle: "World Class Chefs", description: "Our Dishes are prepared by only the best.", photo: UIImage(named: "slide2")!))
        arrslides.append(OnboardingSlide(tittle: "Instant World-wide Delivery", description: "Your orders will be delivered instantly irrespective of your location around the world.", photo: UIImage(named: "slide3")!))
        pageControl.numberOfPages = arrslides.count
        
            
        }
    
    
    
    @IBAction func btnNextPressd(_ sender: UIButton) {
        if currentPage != arrslides.count - 1 {
            currentPage += 1
            let index = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pageControl.currentPage = currentPage
        }else {
            UserDefaults.standard.hasOnboarded = true
            let storyBoard = UIStoryboard(name: "UserAuthorizationUI", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "login&signup")
           
            present(vc, animated: true,completion: nil)
           
        }
        
    }
    
}
extension OnboardingViewController :UICollectionViewDelegate ,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        arrslides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cel = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardindCollectionViewCell", for: indexPath)as! OnboardindCollectionViewCell
        cel.setUp(_slide: arrslides[indexPath.row])
        
        return cel
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:collectionView.frame.width  , height:collectionView.frame.height )
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width )
        pageControl.currentPage = currentPage
    }
    
    
}
