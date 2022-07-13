//
//  DemoViewController.swift
//  MACarousalBanner
//
//  Created by Mahjabin Alam on 2022/07/10.
//

import UIKit

class DemoViewController: UIViewController {

    var list = [UIImage]()
    let carousalBannerView = MACarousalBannerView()
    
    var carousalViewModel: MACarousalViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addCarousalView()
        prepareDataSource()
        carousalViewModel = MACarousalViewModel(list)
        carousalBannerView.datasource = carousalViewModel.datasource
    }
    
    func addCarousalView() {
        carousalBannerView.delegate = self
        view.addSubview(carousalBannerView)
        addLayoutToCarousalView()
    }

    func addLayoutToCarousalView() {
        carousalBannerView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            carousalBannerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            carousalBannerView.leftAnchor.constraint(equalTo: view.leftAnchor),
            carousalBannerView.rightAnchor.constraint(equalTo: view.rightAnchor),
            carousalBannerView.heightAnchor.constraint(equalToConstant: 200)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func prepareDataSource() {
        var tempList = [UIImage?]()
        var count = 1
        while count < 6 {
            let name = "img_" + "\(count)"
            let image = UIImage(named: name)
            tempList += [image]
            count += 1
        }
        list = tempList.filter( { $0 != nil }).map({$0!})
    }
}

extension DemoViewController: MACarousalBannerViewDelegate {
    func moveForwards() {
        
    }
    
    func moveBackwards() {
        
    }
    
    
}
