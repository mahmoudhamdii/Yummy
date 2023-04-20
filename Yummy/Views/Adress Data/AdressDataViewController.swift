//
//  AdressDataViewController.swift
//  Yummy
//
//  Created by hamdi on 08/04/2023.
//

import UIKit
import CoreLocation
import MapKit

class AdressDataViewController: UIViewController {
    var areaName = ""
    var areaFlag = true
    var streetFlag = true
    var buildingTypeFlag = true
    var buildingNameFlag = true
    var floorFlag = true
    var adressFlag = true
    var landMarkFlag = true
    var mobileNumberFlag = true
    var optionalNumberFlag = true
    var arrBuildingType = ["Street" ,"Cafe","House","Office"]
    @IBOutlet weak var addressMapView: MKMapView!
    var currentindex = 0
    var mySet = Set<UITextField>()
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
        
        let pikerView = UIPickerView()
        pikerView.delegate = self
        pikerView.dataSource = self
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let btnDone = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(closePiker))
        toolBar.setItems([btnDone], animated: true)
        buildingType.inputView = pikerView
        buildingType.inputAccessoryView = toolBar
        title = "New Address"
        super.viewDidLoad()
        addressMapView.setRegion(  MapViewController.region!, animated: true)
        addressMapView.isScrollEnabled = false
        addressMapView.isZoomEnabled = false
        addressMapView.isUserInteractionEnabled = false
        btnRefineLoction.addBorder
        UITextField.addFieldsLine(fields: [areaTxf,streetNameTxf,buildingType,floorNumber,buildingName,adressName,landMark,mobileNumber,optionalLandingNumber])
        addDelgate(fields: [areaTxf,streetNameTxf,buildingName,buildingType,floorNumber,adressName,landMark,optionalLandingNumber])
        
        navigationController?.navigationBar.tintColor =   #colorLiteral(red: 0.5803921569, green: 0.09019607843, blue: 0.1843137255, alpha: 1)
        navigationItem.backButtonTitle = ""
        
        if areaName != ""{
            areaTxf.text = areaName
        }
        
        
    }
    
    func addDelgate(fields:[UITextField]){
        for textField in fields{
            textField.delegate = self
        }}
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func btnRefineLocationAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSaveAdressAction(_ sender: Any) {
        if UITextField.validateEmptyFields(fields: [areaTxf,streetNameTxf,buildingName,buildingType,floorNumber,adressName,landMark,mobileNumber]) {
            if Utalities.isValidEgyptPhoneNumber(mobileNumber.text!){
                //send OTP to mobile number
                sendOTP(mobile :mobileNumber.text!)
                //validate OTp
                let controller = OTPViewController.instantiate(storyBord: "HomeUI")
                
                controller.area = areaTxf.text!
                controller.streetName = streetNameTxf.text!
                controller.mobile = mobileNumber.text!
                navigationController?.pushViewController(controller, animated: true)
            }else{
                showAlert(tittle: "Unavailable", msg: "please enter Valid phone number ")
            }
            
            
        }else{
            
            showAlert(tittle: "Unavailable", msg: "please fill all require fields!")
            
        }
    }
    func sendOTP (mobile :String){
        
    }
    
    

    func  showAlert(tittle:String,msg:String){
        let alertController = UIAlertController(title: tittle, message: msg, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            
        }
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)
        
        
        
    }
    
    func creatFieldsLabel(textField:UITextField){
        if let index = stackView.arrangedSubviews.firstIndex(of: textField) {
            let label = UILabel()
            label.textColor = #colorLiteral(red: 0.5803921569, green: 0.09019607843, blue: 0.1843137255, alpha: 1)
            label.font = UIFont(name:"Almarai-Regular", size: 15)
            label.text = ("\(textField.placeholder ?? "")*")
            if textField.text != "" {
                if !mySet.contains(textField){
                    stackView.insertArrangedSubview(label, at: index)
                    mySet.insert(textField)
                }
            }else{
                if let x = stackView.arrangedSubviews.firstIndex(of: textField){
                    let indexToRemove = x-1
                    let subviewToRemove = stackView.arrangedSubviews[indexToRemove]
                    stackView.removeArrangedSubview(subviewToRemove)
                    subviewToRemove.removeFromSuperview()
                    mySet.remove(textField)
                }}
        }
        
        
    }
}

extension AdressDataViewController :UIPickerViewDelegate,UIPickerViewDataSource{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        arrBuildingType.count    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrBuildingType[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentindex = row
        buildingType.text = arrBuildingType[row]
    }
    
    @objc func closePiker(){
        buildingType.text = arrBuildingType[currentindex]
        view.endEditing(true)
    }
    
}





extension AdressDataViewController :UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case areaTxf :
            streetNameTxf.becomeFirstResponder()
        case streetNameTxf :
            buildingType.becomeFirstResponder()
        case buildingType :
            floorNumber.becomeFirstResponder()
        case floorNumber :
            buildingName.becomeFirstResponder()
        case buildingName :
            adressName.becomeFirstResponder()
        case adressName :
            landMark.becomeFirstResponder()
        case landMark :
            mobileNumber.becomeFirstResponder()
        case mobileNumber:
            optionalLandingNumber.becomeFirstResponder()
        case optionalLandingNumber :
            btnSaveAdressAction(UIButton.self)
        default:
            break
        }
        return true
    }
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        switch textField {
        case areaTxf :
            creatFieldsLabel(textField: areaTxf)
        case streetNameTxf :
            creatFieldsLabel(textField: streetNameTxf)
        case buildingType :
            creatFieldsLabel(textField: buildingType)
        case floorNumber :
            creatFieldsLabel(textField: floorNumber)
        case buildingName :
            creatFieldsLabel(textField: buildingName)
        case adressName :
            creatFieldsLabel(textField:adressName )
        case landMark :
            creatFieldsLabel(textField: landMark)
        case mobileNumber:
            creatFieldsLabel(textField: mobileNumber)
        case optionalLandingNumber :
            creatFieldsLabel(textField: optionalLandingNumber)
        default:
            break
        }
    }
    
}
