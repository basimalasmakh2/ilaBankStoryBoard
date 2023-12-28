//
//  HomeViewController.swift
//  IlaBankStoryboard
//
//  Created by Yousif Radhi on 12/28/23.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet var myTable: UITableView!
    @IBOutlet weak var pageControlo: UIPageControl!
    
    @IBOutlet weak var collectionViewo: UICollectionView!
    
    var currentCellIndex = 0
    var arrProductPhotos = [UIImage(named: "bentleyTwo")!, UIImage(named: "mercededsTwo")!, UIImage(named: "toyotaTwo")!, UIImage(named: "nissanTwo")!, UIImage(named: "rollsTwo")!]
    var timer : Timer?
   
    var listCar = [CarData]()
    var searching = false
    var searchedCar = [CarData]()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    // MARK: - View Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up collection view delegate and data source
        collectionViewo.delegate = self
        collectionViewo.dataSource = self
        
        // Set up page control for the image carousel
        pageControlo.numberOfPages = arrProductPhotos.count
        
        // Start automatic image carousel
        startTimer()
        
        // Populate car data
        let car1 = CarData(cName: "Nissan", cCountry: "Japan", cPhoto: "nissan")
        listCar.append(car1)
        
        let car2 = CarData(cName: "Bentley", cCountry: "UK", cPhoto: "bentley")
        listCar.append(car2)
        let car3 = CarData(cName: "Rolls Royce", cCountry: "UK", cPhoto: "rolls")
        listCar.append(car3)
        let car4 = CarData(cName: "Mercedes", cCountry: "Germany", cPhoto: "mercedes")
        listCar.append(car4)
        let car5 = CarData(cName: "Toyota", cCountry: "Japan", cPhoto: "toyota")
        listCar.append(car5)
        
        // Configure search controller
        configureSearchController()
    }
    
    // MARK: - Private Methods
    
    private func configureSearchController() {
        // Set up the search controller
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        searchController.searchBar.placeholder = "Search Car By Name"
    }
}

// MARK: - Table View Delegate and Data Source

extension HomeViewController: UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, UISearchBarDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searching ? searchedCar.count : listCar.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyTableViewCell
        
        if searching {
            cell.carNameLabel.text = searchedCar[indexPath.row].carName
            cell.countryLabel.text = searchedCar[indexPath.row].country
            cell.carImageView.image = UIImage(named: searchedCar[indexPath.row].carPhoto)
        } else {
            cell.carNameLabel.text = listCar[indexPath.row].carName
            cell.countryLabel.text = listCar[indexPath.row].country
            cell.carImageView.image = UIImage(named: listCar[indexPath.row].carPhoto)
        }
        
        return cell
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // Reset search state when cancel button is clicked
        searching = false
        searchedCar.removeAll()
        myTable.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        // Filter cars based on search text
        let searchText = searchController.searchBar.text!
        if !searchText.isEmpty {
            searching = true
            searchedCar.removeAll()
            for car in listCar {
                if car.carName.lowercased().contains(searchText.lowercased()) {
                    searchedCar.append(car)
                }
            }
        } else {
            searching = false
            searchedCar.removeAll()
            searchedCar = listCar
        }
        myTable.reloadData()
    }
}

// MARK: - Collection View Delegate and Data Source

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrProductPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cello = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCello", for: indexPath) as! HomeoCollectionViewCell
        cello.imgProductPhotoo.image = arrProductPhotos[indexPath.row]
        return cello
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func startTimer() {
        // Start automatic image carousel timer
        timer = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(moveToNextIndex), userInfo: nil, repeats: true)
    }
    
    @objc func moveToNextIndex() {
        // Move to the next image in the carousel
        if currentCellIndex < arrProductPhotos.count - 1 {
            currentCellIndex += 1
        } else {
            currentCellIndex = 0
        }
        
        collectionViewo.scrollToItem(at: IndexPath(item: currentCellIndex, section: 0), at: .centeredHorizontally, animated: true)
        pageControlo.currentPage = currentCellIndex
    }
}
