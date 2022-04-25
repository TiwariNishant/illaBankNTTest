//
//  FirstViewController.swift
//  NishantCaroselDemo
//
//  Created by webwerks on 23/04/22.
//

import UIKit

class FirstViewController: UIViewController {

    // MARK: - Outlet Declaration
    @IBOutlet weak var firstTableView: UITableView!
    @IBOutlet weak var caroselCollectionView: UICollectionView!
    @IBOutlet weak var searchTextField: UISearchBar!
    @IBOutlet weak var pageControl: UIPageControl!
    
    // MARK: - ViewModel Binding
    var viewModel = FirstViewModel()
    
    // MARK: - Controller Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialValue()
        if #available(iOS 15.0, *) {
            firstTableView.sectionHeaderTopPadding = 0
        }
    }
    
    // MARK: - Private function declaration
    private func setupInitialValue() {
        viewModel.getList { [weak self] success in
            guard let self = self else { return }
            if success {
                self.firstTableView.reloadData()
                self.pageControl.numberOfPages = self.viewModel.firstArrayList.count
                self.caroselCollectionView.reloadData()
            }
        }
        self.caroselCollectionView.contentInsetAdjustmentBehavior = .never

    }
    
    func reloadTable() {
        DispatchQueue.main.async {
            self.firstTableView.reloadData()
        }
    }
}

// MARK: - Tableview Delegate & DataSource Method
extension FirstViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  viewModel.getListCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FirstTableViewCell") as? FirstTableViewCell else { return UITableViewCell() }
        var model: FirstModel
        if !viewModel.isSearchActive {
            model = viewModel.firstArrayList[indexPath.row]
        } else {
            model = viewModel.searchArrayList[indexPath.row]
        }
        
        cell.configureCell(model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if  let view = Bundle.main.loadNibNamed("SearchBarView", owner: nil, options: nil)?.first as? SearchBarView {
            view.searchBar.barTintColor = .white
            view.searchBar.delegate = self
            return view
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}

// MARK: - CollectionView Delegate & Datasource Method
extension FirstViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.firstArrayList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeaderCollectionViewCell", for: indexPath) as? HeaderCollectionViewCell else { return UICollectionViewCell() }
        
        let model = viewModel.firstArrayList[indexPath.item]
        cell.configureCell(model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: collectionView.frame.size.width, height: 200)
        return size
    }
}

 // MARK: - SearchBar Delegate Method
extension FirstViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            viewModel.isSearchActive = false
        } else {
            viewModel.isSearchActive = true
            
            viewModel.searchArrayList = self.viewModel.firstArrayList.filter({(($0.name?.localizedCaseInsensitiveContains(searchText)))!})
        }
        reloadTable()
    }
}

// MARK: - ScrollView method
extension FirstViewController {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let center = CGPoint(x: scrollView.contentOffset.x + (scrollView.frame.width / 2), y: (scrollView.frame.height / 2))
        if let ip = caroselCollectionView.indexPathForItem(at: center) {
            pageControl.currentPage = ip.item
            viewModel.isSearchActive = false
            viewModel.firstArrayList.shuffle()
            reloadTable()
        }
    }
}
