//
//  CheckOrderViewController.swift
//  tix
//
//  Created by Jubril on 19/11/2018.
//  Copyright © 2018 Tix. All rights reserved.
//

import UIKit
import SwiftValidator
import QRCodeReader
import AVFoundation

class CheckOrderViewController: UIViewController, Storyboardable, ValidationDelegate, QRCodeReaderViewControllerDelegate{
    @IBOutlet weak var checkOrderButton: TixButton!
    @IBOutlet weak var readerBackgroundView: UIView!
    let validator = Validator()
    @IBOutlet weak var scanLabel: UILabel!
    @IBOutlet weak var scanButton: TixButton!
    @IBOutlet weak var orderIDTextField: TixTextField!
    @IBOutlet weak var eventTitle: UILabel!
    var event: GetEventsQuery.Data.CurrentUser.Event.Edge.Node?
    var coordinator: EventsCoordinator?
    let loadingVC = LoadingViewController.instantiate()
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    lazy var readerVC: QRCodeReaderViewController = {
        let builder = QRCodeReaderViewControllerBuilder {
            let readerView = QRCodeReaderContainer(displayable: YourCustomView())
            $0.readerView = readerView
            $0.reader = QRCodeReader(metadataObjectTypes: [.qr], captureDevicePosition: .back)
        }
        
        return QRCodeReaderViewController(builder: builder)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventTitle.text = event?.title
        validator.registerField(orderIDTextField, rules: [RequiredRule(), FloatRule(message: "Invalid order id")])

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        orderIDTextField.text = ""
    }
    
    @IBAction func onBackButtonTap(_ sender: UIButton) {
        coordinator?.popViewController(self)
    }
    
    @IBAction func onScanButtonTap(_ sender: UIButton) {
        readerVC.delegate = self
        scanLabel.textColor = .white
        scanLabel.text = "Check in with QR Code"
        addChild(readerVC)
        readerBackgroundView.insertSubview(readerVC.view, belowSubview: scanLabel)
        readerVC.didMove(toParent: self)
        readerVC.view.frame = readerBackgroundView.bounds
    }
    
    @IBAction func onCheckOrderTap(_ sender: Any) {
        showActiviyIndicator()
        //checkOrderButton.isEnabled = false
        validator.validate(self)
    }
    
    @IBAction func onLogoutButtonTap(_ sender: UIButton) {
        coordinator?.logoutUser()
    }
    
    func validationSuccessful() {
        print("Short ID \(Int(orderIDTextField.text!)!)")
        coordinator?.checkOrderID(id: orderIDTextField.text!)
    }
    
    func validationFailed(_ errors: [(Validatable, ValidationError)]) {
        displayErrorModal(error: errors.first?.1.errorMessage)
        hideActivityIndicator()
    }
    
    func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
        print("ScanResult \(result.value)")
        coordinator?.checkOrderID(longID: result.value)
        showActiviyIndicator()
        scanLabel.textColor = .black
        scanLabel.text = "Or check in with QR Code"
        reader.stopScanning()
        reader.remove()
    }
    
    //This is an optional delegate method, that allows you to be notified when the user switches the cameraName
    //By pressing on the switch camera button
    func reader(_ reader: QRCodeReaderViewController, didSwitchCamera newCaptureDevice: AVCaptureDeviceInput) {
    }
    
    func readerDidCancel(_ reader: QRCodeReaderViewController) {
        scanLabel.textColor = .black
        scanLabel.text = "Or check in with QR Code"
        reader.stopScanning()
        readerVC.remove()
    }
    
    func showActiviyIndicator() {
        add(loadingVC)
        
    }
    
    func hideActivityIndicator() {
        loadingVC.remove()
    }

}

class YourCustomView: UIView, QRCodeReaderDisplayable {
    
    let cameraView: UIView            = UIView()
    let cancelButton: UIButton?       = UIButton()
    let switchCameraButton: UIButton? = SwitchCameraButton()
    let toggleTorchButton: UIButton?  = ToggleTorchButton()
    var overlayView: UIView?          = UIView()

    func setNeedsUpdateOrientation() {
        
    }
    
    func setupComponents(showCancelButton: Bool, showSwitchCameraButton: Bool, showTorchButton: Bool, showOverlayView: Bool, reader: QRCodeReader?) {
        
        self.addSubview(cameraView)
        self.addSubview(cancelButton!)
        if let reader = reader {
            cameraView.layer.insertSublayer(reader.previewLayer, at: 0)
            
            setNeedsUpdateOrientation()
        }
        cameraView.translatesAutoresizingMaskIntoConstraints = false
        cancelButton?.translatesAutoresizingMaskIntoConstraints = false
        cameraView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        cameraView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        cameraView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        cameraView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        cancelButton?.widthAnchor.constraint(equalToConstant: 136).isActive = true
        cancelButton?.heightAnchor.constraint(equalToConstant: 41.5).isActive = true
        cancelButton?.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -25).isActive = true
        cancelButton?.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 27).isActive = true
        cancelButton?.layer.cornerRadius = 5
        cancelButton?.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        cancelButton?.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        cancelButton?.layer.shadowRadius = 1
        cancelButton?.layer.masksToBounds = false
        cancelButton?.layer.shadowOpacity = 1
        cancelButton?.setTitle("Cancel scan", for: .normal)
        cancelButton?.setTitleColor(.white, for: .normal)
        cancelButton?.titleLabel?.font = UIFont(name: "Soleil-Bold", size: 16)
        cancelButton?.backgroundColor = UIColor(red: 0.99, green: 0.39, blue: 0.21, alpha: 1.0)
        self.layoutIfNeeded()
        
//        cameraView.frame = self.view.bounds
//        cancelButton = TixButton()
        
    }
    
    
    
}
