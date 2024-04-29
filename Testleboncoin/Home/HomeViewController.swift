//
//  HomeViewController.swift
//  Testleboncoin
//
//  Created by Yasin Akinci on 29/04/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Combine

protocol HomeDisplayLogic: class {
    func displayAds(viewModelAds: [Home.Ads.ViewModelAd], viewModelCategories: [Home.Ads.ViewModelCategory])
}

class HomeViewController: UIViewController, HomeDisplayLogic {
    var interactor: HomeBusinessLogic?
    var router: (NSObjectProtocol & HomeRoutingLogic & HomeDataPassing)?

    private var cancellables = Set<AnyCancellable>()
    private var tableView = UITableView()
    private lazy var dataSource: UITableViewDiffableDataSource<Int, Home.Ads.ViewModelAd> = {
        UITableViewDiffableDataSource(tableView: tableView) { tableView, indexPath, model in
            let cell: AdTableviewCell = tableView.dequeueReusableCell(withIdentifier: AdTableviewCell.identifier, for: indexPath) as! AdTableviewCell
            cell.ad = model
            return cell
        }
    }()
    // MARK: Object lifecycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: Setup

    private func setup() {
        let viewController = self
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        let router = HomeRouter()
        let worker = HomeWorker()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        interactor.worker = worker
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func setupView() {
        self.title = "Home"
        self.view.backgroundColor = .white
        tableView.register(AdTableviewCell.self, forCellReuseIdentifier: AdTableviewCell.identifier)
        tableView.dataSource = dataSource
    }

    // MARK: Routing

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTableView()
        fetchAdsAndCategories()
    }

    // MARK: Do something

    func fetchAdsAndCategories() {
        interactor?.fetchAdsAndCategories()
    }

    func displayAds(viewModelAds: [Home.Ads.ViewModelAd], viewModelCategories: [Home.Ads.ViewModelCategory]) {
        print(viewModelAds)
        print(viewModelCategories)
        var snapshot = NSDiffableDataSourceSnapshot<Int, Home.Ads.ViewModelAd>()
        snapshot.appendSections([0])
        snapshot.appendItems(viewModelAds,
                             toSection: 0)
        dataSource.apply(snapshot)
    }
}

extension HomeViewController {
    
    func setupTableView() {
      view.addSubview(tableView)
      tableView.translatesAutoresizingMaskIntoConstraints = false
      tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
      tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
      tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
}
