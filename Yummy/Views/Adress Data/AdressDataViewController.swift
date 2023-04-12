//
//  AdressDataViewController.swift
//  Yummy
//
//  Created by hamdi on 08/04/2023.
//

import UIKit

class AdressDataViewController: UIViewController {
    var areaFlag = true
    var streetFlag = true
    var buildingTypeFlag = true
    var buildingNameFlag = true
    var floorFlag = true
    var adressFlag = true
    var landMarkFlag = true
    var mobileNumberFlag = true
    var optionalNumberFlag = true
    
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var optionalLandingNumber: UITextField!
    @IBOutlet weak var mobileNumber: UITextField!
    @IBOutlet weak var landMark: UITextField!
    @IBOutlet weak var adressName: UITextField!
    @IBOutlet weak var floorNumber: UITextField!
    @IBOutlet weak var buildingName: UITextField!
    @IBOutlet weak var buildingType: UITextField!
    @IBOutlet weak var streetNameTxf: UITextField!
    @IBOutlet weak var areaTxf: UITextField!
    @IBOutlet weak var btnRefineLoction: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        btnRefineLocationSetup()
        fieldStyle(fields: [areaTxf,streetNameTxf,buildingType,floorNumber,buildingName,adressName,landMark,mobileNumber,optionalLandingNumber])
        //        areaTxf.delegate = self
        //        streetNameTxf.delegate = self
        //        buildingName.delegate = self
        //        buildingType.delegate = self
        //        floorNumber.delegate = self
        //        adressName.delegate = self
        //        landMark.delegate = self
        //        optionalLandingNumber.delegate = self
        areaTxf.addTarget(self, action: #selector(creatAreaLable), for: .editingChanged)
        streetNameTxf.addTarget(self, action: #selector(creatStreetNameLable), for: .editingChanged)
        buildingType.addTarget(self, action: #selector(creatBuildingTypeLable), for: .editingChanged)
        buildingName.addTarget(self, action: #selector(creatBuildingNameLable), for: .editingChanged)
        floorNumber.addTarget(self, action: #selector(creatFloorNumberLable), for: .editingChanged)
        adressName.addTarget(self, action: #selector(creatadressNameLable), for: .editingChanged)
        landMark.addTarget(self, action: #selector(creatLandMarkLable), for: .editingChanged)
        mobileNumber.addTarget(self, action: #selector(creatMobileNumberLable), for: .editingChanged)
        optionalLandingNumber.addTarget(self, action: #selector(creatOptionalNumberLable), for: .editingChanged)
        
        
    }
    func fieldStyle(fields:[UITextField]){
        for textField in fields{
            let bottomLine = CALayer()
            bottomLine.frame = CGRect(x: 0, y: textField.frame.height - 1, width: textField.frame.width, height: 1)
            bottomLine.backgroundColor =  #colorLiteral(red: 0.5803921569, green: 0.09019607843, blue: 0.1843137255, alpha: 1).cgColor
            textField.layer.addSublayer(bottomLine)
        }}
    @objc func creatOptionalNumberLable(){
        if let index = stackView.arrangedSubviews.firstIndex(of: optionalLandingNumber) {
            let label = UILabel()
            label.textColor = #colorLiteral(red: 0.5803921569, green: 0.09019607843, blue: 0.1843137255, alpha: 1)
            label.font = UIFont(name:"Almarai-Regular", size: 15)
            label.text = ("\(optionalLandingNumber.placeholder ?? "")*")
            if optionalLandingNumber.text != "" {
                if optionalNumberFlag{
                    stackView.insertArrangedSubview(label, at: index)
                    optionalNumberFlag = false
                }
            }else{
                if let x = stackView.arrangedSubviews.firstIndex(of: optionalLandingNumber){
                    var indexToRemove = x-1
                    let subviewToRemove = stackView.arrangedSubviews[indexToRemove]
                    stackView.removeArrangedSubview(subviewToRemove)
                    subviewToRemove.removeFromSuperview()
                    optionalNumberFlag = true
            }}
        }
        
        
    }
    
    @objc func creatMobileNumberLable(){
        if let index = stackView.arrangedSubviews.firstIndex(of: mobileNumber) {
            let label = UILabel()
            label.textColor = #colorLiteral(red: 0.5803921569, green: 0.09019607843, blue: 0.1843137255, alpha: 1)
            label.font = UIFont(name:"Almarai-Regular", size: 15)
            label.text = ("\(mobileNumber.placeholder ?? "")*")
            if mobileNumber.text != "" {
                if mobileNumberFlag{
                    stackView.insertArrangedSubview(label, at: index)
                    mobileNumberFlag = false
                }
            }else{
                if let x = stackView.arrangedSubviews.firstIndex(of: mobileNumber){
                    var indexToRemove = x-1
                    let subviewToRemove = stackView.arrangedSubviews[indexToRemove]
                    stackView.removeArrangedSubview(subviewToRemove)
                    subviewToRemove.removeFromSuperview()
                    mobileNumberFlag = true
                }}
            
        }
        
        
    }
    @objc func creatLandMarkLable(){
        if let index = stackView.arrangedSubviews.firstIndex(of: landMark) {
            let label = UILabel()
            label.textColor = #colorLiteral(red: 0.5803921569, green: 0.09019607843, blue: 0.1843137255, alpha: 1)
            label.font = UIFont(name:"Almarai-Regular", size: 15)
            label.text = ("\(landMark.placeholder ?? "")*")
            if landMark.text != "" {
                if landMarkFlag{
                    stackView.insertArrangedSubview(label, at: index)
                    landMarkFlag = false
                }
            }else{
                if let x = stackView.arrangedSubviews.firstIndex(of: landMark){
                    var indexToRemove = x-1
                    let subviewToRemove = stackView.arrangedSubviews[indexToRemove]
                    stackView.removeArrangedSubview(subviewToRemove)
                    subviewToRemove.removeFromSuperview()
                    landMarkFlag = true
            }}
        }
        
        
        
    }
    @objc func creatadressNameLable(){
        if let index = stackView.arrangedSubviews.firstIndex(of: adressName) {
            let label = UILabel()
            label.textColor = #colorLiteral(red: 0.5803921569, green: 0.09019607843, blue: 0.1843137255, alpha: 1)
            label.font = UIFont(name:"Almarai-Regular", size: 15)
            label.text = ("\(adressName.placeholder ?? "")*")
            if adressName.text != "" {
                if adressFlag{
                    stackView.insertArrangedSubview(label, at: index)
                    adressFlag = false
                }
            }else{
                if let x = stackView.arrangedSubviews.firstIndex(of: adressName){
                    var indexToRemove = x-1
                    let subviewToRemove = stackView.arrangedSubviews[indexToRemove]
                    stackView.removeArrangedSubview(subviewToRemove)
                    subviewToRemove.removeFromSuperview()
                    adressFlag = true
                }}
            
            
        }
        
    }
    @objc func creatFloorNumberLable(){
        if let index = stackView.arrangedSubviews.firstIndex(of: floorNumber) {
            let label = UILabel()
            label.textColor = #colorLiteral(red: 0.5803921569, green: 0.09019607843, blue: 0.1843137255, alpha: 1)
            label.font = UIFont(name:"Almarai-Regular", size: 15)
            label.text = ("\(floorNumber.placeholder ?? "")*")
            if floorNumber.text != "" {
                if floorFlag{
                    stackView.insertArrangedSubview(label, at: index)
                    floorFlag = false
                }
            }else{
                if let x = stackView.arrangedSubviews.firstIndex(of: floorNumber){
                    var indexToRemove = x-1
                    let subviewToRemove = stackView.arrangedSubviews[indexToRemove]
                    stackView.removeArrangedSubview(subviewToRemove)
                    subviewToRemove.removeFromSuperview()
                    floorFlag = true
                }}
        }
        
        
        
    }
    @objc func creatBuildingNameLable(){
        if let index = stackView.arrangedSubviews.firstIndex(of: buildingName) {
            let label = UILabel()
            label.textColor = #colorLiteral(red: 0.5803921569, green: 0.09019607843, blue: 0.1843137255, alpha: 1)
            label.font = UIFont(name:"Almarai-Regular", size: 15)
            label.text = ("\(buildingName.placeholder ?? "")*")
            if buildingName.text != "" {
                if buildingNameFlag{
                    stackView.insertArrangedSubview(label, at: index)
                    buildingNameFlag = false
                }
            }else{
                if let x = stackView.arrangedSubviews.firstIndex(of: buildingName){
                    var indexToRemove = x-1
                    let subviewToRemove = stackView.arrangedSubviews[indexToRemove]
                    stackView.removeArrangedSubview(subviewToRemove)
                    subviewToRemove.removeFromSuperview()
                    buildingNameFlag = true
                }
            }
        }
        
        
        
    }
    @objc func creatAreaLable(){
        
        if let index = stackView.arrangedSubviews.firstIndex(of: areaTxf) {
            let label = UILabel()
            label.textColor = #colorLiteral(red: 0.5803921569, green: 0.09019607843, blue: 0.1843137255, alpha: 1)
            label.font = UIFont(name:"Almarai-Regular", size: 15)
            label.text = ("\(areaTxf.placeholder ?? "")*")
            label.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
            
            if areaTxf.text != "" {
                if areaFlag{
                    stackView.insertArrangedSubview(label, at: index)
                    areaFlag = false
                }
            }else{
                if let x = stackView.arrangedSubviews.firstIndex(of: areaTxf)  {
                    var indexToRemove = x-1
                    let subviewToRemove = stackView.arrangedSubviews[indexToRemove]
                    stackView.removeArrangedSubview(subviewToRemove)
                    subviewToRemove.removeFromSuperview()
                    areaFlag = true
                }}
        }
        
        
    }
    @objc func creatStreetNameLable(){
        if let index = stackView.arrangedSubviews.firstIndex(of: streetNameTxf) {
            let label = UILabel()
            label.textColor = #colorLiteral(red: 0.5803921569, green: 0.09019607843, blue: 0.1843137255, alpha: 1)
            label.font = UIFont(name:"Almarai-Regular", size: 15)
            label.text = ("\(streetNameTxf.placeholder ?? "")*")
            if streetNameTxf.text != "" {
                if streetFlag{
                    stackView.insertArrangedSubview(label, at: index)
                    streetFlag = false
                }
            }else{
                if let x = stackView.arrangedSubviews.firstIndex(of: streetNameTxf){
                    var indexToRemove = x-1
                    let subviewToRemove = stackView.arrangedSubviews[indexToRemove]
                    stackView.removeArrangedSubview(subviewToRemove)
                    subviewToRemove.removeFromSuperview()
                    streetFlag = true
                }}
        }
        
        
    }
    @objc func creatBuildingTypeLable(){
       
        if let index = stackView.arrangedSubviews.firstIndex(of: buildingType) {
            let label = UILabel()
            label.textColor = #colorLiteral(red: 0.5803921569, green: 0.09019607843, blue: 0.1843137255, alpha: 1)
            label.font = UIFont(name:"Almarai-Regular", size: 15)
            label.text = ("\(buildingType.placeholder ?? "")*")
            if buildingType.text != "" {
                if buildingTypeFlag{
                    stackView.insertArrangedSubview(label, at: index)
                    buildingTypeFlag = false
                    
                }
            }else{
                if let x = stackView.arrangedSubviews.firstIndex(of: buildingType){
                    var indexToRemove = x-1
                    let subviewToRemove = stackView.arrangedSubviews[indexToRemove]
                    stackView.removeArrangedSubview(subviewToRemove)
                    subviewToRemove.removeFromSuperview()
                    buildingTypeFlag = true
                }}
        }
        
        
        
    }
    
    func btnRefineLocationSetup(){
        btnRefineLoction.layer.borderWidth = 2
        btnRefineLoction.layer.borderColor = #colorLiteral(red: 0.5803921569, green: 0.09019607843, blue: 0.1843137255, alpha: 1).cgColor
    }
    
    
    @IBAction func btnRefineLocationAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
}

