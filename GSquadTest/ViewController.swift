//
//  ViewController.swift
//  GSquadTest
//
//  Created by Apple on 10/09/2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private let reuseIdentifier = "PropertyCustomCell"
    private var properties = [Property]()
    @IBOutlet weak var peropertyCollectionView : UICollectionView!
    var shouldDisplayBottomRefresh = false//just in case we want to show UI . only added , have not shown cell based on that,
    var page_number = 2
    var isLoading = false //for handling pagination
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.getStatesList(page: page_number)
    }
    
    func getStatesList(page : Int)
    {
        self.page_number = page
        let request_data = PropertyListRequestModel(page: "\(page)", perPage: K.perPageCount, sortBy: "date", sortType: "asc", distance: "2000", pointSearch: "43.6964,7.2716")
        isLoading = true
        APIClient.getPropertyList(data: request_data) { (result: Result<PropertyListResponseModel, RequestError>) in
            self.isLoading = false// to make next page call
            switch result {
            case .success(let obj):
                self.properties.append(contentsOf: obj.properties)
                DispatchQueue.main.async {
                    self.peropertyCollectionView.reloadData()
                }
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
}
// MARK: - UICollectionViewDataSource

extension ViewController : UICollectionViewDataSource
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return shouldDisplayBottomRefresh ? 2 : 1
    }
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        if shouldDisplayBottomRefresh{
            if section == 0 {
                return properties.count
            }else{
                return 1
            }
        }else{
            return properties.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // just in case we want to add an indicator at the bottom,currently not being used
        /*
        if shouldDisplayBottomRefresh {
            if indexPath.section == 0{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                              for: indexPath) as! PropertyCustomCell
                cell.loadData(property: properties[indexPath.row])
                return cell
            }else{
                //  show refresh control for later if needed
            }
        }*/
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                      for: indexPath) as! PropertyCustomCell
        cell.loadData(property: properties[indexPath.row])
        return cell
    }
    
}

extension ViewController: UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let threshold: CGFloat = 100.0
        let contentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height;
        if (maximumOffset - contentOffset <= threshold) && (maximumOffset - contentOffset != -5.0  && !isLoading) {
                self.getStatesList(page: page_number+1)
            //we can add resfresh control cell at bottom
        }
    }
    
}
//for setting size
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height  = (collectionView.frame.size.height-20)/2 // adding static value we can adjust the size based on view height as well , depending upon how many items we need to show
        return CGSize(width: collectionView.frame.size.width - 30, height: height)
    }
}
extension UIImageView {
    func downloaded(from url: URL) {
        DispatchQueue.global(qos: .background).async {  URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
        }
    }
    func downloaded(from link: String) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url)
    }
}
