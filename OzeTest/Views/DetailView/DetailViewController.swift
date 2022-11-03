//
//  DetailViewController.swift
//  OzeAssesment
//
//  Created by Mac on 01/11/2022.
//

import UIKit
import Combine

class DetailViewController: UIViewController {
    
    /// checkbox to toggle button state
    lazy var checkbox: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "bookmark"), for: .normal)
        button.setBackgroundImage(UIImage(systemName: "bookmark.fill"), for: .selected)
        button.addTarget(self, action: #selector(self.checked(sender:)), for: .touchUpInside)
        button.constrainSize(width: 50, height: 50)
        return button
    }()
    
    lazy var devAvater: UIImageView = {
        let image = UIImageView()
        image.constrainSize(width: 100, height: 100)
        image.layer.cornerRadius = 20
        image.clipsToBounds = true
        return image
    }()
    
    lazy var devName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    
    lazy var repoNumber: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    
    var value: TableViewValue?
    var viewModel: ViewModel?
    private var repoDataCount: [RepoData] = []
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = value?.login
        checkbox.isHidden = true
        setUpView()
        if let devName = value?.login {
            viewModel?.fetchRepoData(name: devName)
        }
        setUpData()
    }
    
    func setUpView() {
        view.addSubview([
            checkbox,
            devAvater,
            devName,
            repoNumber
        ])
        
        checkbox.constrainTopSafeArea(to: view, constant: 20)
        checkbox.constrainRight(to: view,constant: -20)
        
        devAvater.constrainTopToBottom(of: checkbox, constant: 20)
        devAvater.constrainCenterX(to: view)
        
        devName.constrainCenterX(to: view)
        devName.constrainTopToBottom(of: devAvater, constant: 10)
        
        repoNumber.constrainCenterX(to: view)
        repoNumber.constrainTopToBottom(of: devName, constant: 10)
    }
    
    func setUpData() {
        
        if let countDevData = value?.repoData {
            
            if countDevData.isEmpty {
                checkbox.isSelected = false
                viewModel!
                    .$dataFetch
                    .sink(receiveValue: { value in
                        switch value {
                        case .success(let resut):
                            self.checkbox.isHidden = false
                            self.repoDataCount = resut
                            self.repoNumber.text = "Total Repo: \(resut.count)"
                            self.devName.text = self.value?.login
                            self.devAvater.loadImage(urlString: self.value?.avatarURL ?? "")
                        case .failed:
                            break
                        case .compeleted:
                            break
                        }
                    })
                    .store(in: &cancellables)
            } else {
                checkbox.isHidden = false
                checkbox.isSelected = true
                repoDataCount = viewModel?.transformArray(value: countDevData) ?? []
                self.repoNumber.text = "Total Repo: \(countDevData.count)"
                self.devName.text = self.value?.login
                self.devAvater.loadImage(urlString: self.value?.avatarURL ?? "")
            }
        }
    }
    
    /// This method toggles the button state using the state of the checkbox
    /// - Parameter sender: sender being the checkbox
    @objc private func checked(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        viewModel?.update(id: value?.id ?? 0,
                          updateValue: repoDataCount,
                          save: sender.isSelected)
    }
}
