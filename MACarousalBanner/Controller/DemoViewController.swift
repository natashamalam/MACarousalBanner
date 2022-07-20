//
//  DemoViewController.swift
//  MACarousalBanner
//
//  Created by Mahjabin Alam on 2022/07/10.
//

import UIKit

class DemoViewController: UIViewController {
    var carousalBannerView: MACarousalBannerView!
    
    var carousalViewModel: MACarousalViewModel!
    
    let remoteConfigManager = RemoteConfigManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addCarousalView()
        
        carousalViewModel = MACarousalViewModel(dataSource())
        carousalBannerView.datasource = carousalViewModel.datasource
        
        remoteConfigManager.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        remoteConfigManager.fetchRemoteConfigValues()
    }
    
    func addCarousalView() {
        carousalBannerView = MACarousalBannerView()
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
    
    func dataSource() -> [UIImage]{
        var list = [UIImage?]()
        var count = 1
        while count < 6 {
            let name = "img_" + "\(count)"
            let image = UIImage(named: name)
            list += [image]
            count += 1
        }
        return list.filter( { $0 != nil }).map({$0!})
    }
}

extension DemoViewController: MACarousalBannerViewDelegate {
    func moveForwards() {}
    
    func moveBackwards() {}
}

extension DemoViewController: RemoteConfigManagerProtocol {
    func didReiceveValues(_ response: RemoteConfigResponse?) {
        guard let response = response,
              let pattern = response.arrowPattern else {
                  return
              }
        carousalBannerView.abTestingPattern = pattern
    }
}
