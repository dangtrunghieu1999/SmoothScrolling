//
//  ViewController.swift
//  TableView
//
//  Created by Bee_MacPro on 16/02/2022.
//

import UIKit

class ViewController: UITableViewController {
    
    fileprivate let userViewModelController = UserViewModelController()
    
    // Pre-Fetching queue
    fileprivate let imageLoadQueue      = OperationQueue()
    fileprivate var imageLoadOperations = [IndexPath: ImageLoadOperation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initFromPlist()
        self.prefetchDataTableView()
    }
    
    private func initFromPlist() {
        Feature.initFromPlist()
        if Feature.clearCaches.isEnabled {
            let cachesDirectory   = NSSearchPathForDirectoriesInDomains(.cachesDirectory,
                                                                        .userDomainMask, true)
            let cachesFolderItems = cachesDirectory
            
            for item in cachesFolderItems {
                try? FileManager.default.removeItem(atPath: item)
            }
        }
    }
    
    private func prefetchDataTableView() {
        if #available(iOS 10.0, *) {
            tableView.prefetchDataSource = self
        }
        userViewModelController.retrieveUsers { [weak self] success, error in
            guard let self = self else  { return }
            if !success {
                DispatchQueue.main.async {
                    let title = "error"
                    if let error = error {
                        self.showError(title, message: error.localizedDescription)
                    } else {
                        self.showError(title,
                                       message: NSLocalizedString("Can't retrieve contacs.",
                                                                  comment:  "Can't retrieve contacts."))
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
}

// MARK: - UITableViewDataSource

extension ViewController {
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        
        return userViewModelController.viewModelsCount
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell",
                                                 for: indexPath) as! UserCell
        
        if let viewModel = userViewModelController.viewModel(at: indexPath.row) {
            cell.configure(viewModel)
            if let imageLoadOperation = imageLoadOperations[indexPath],
               let image = imageLoadOperation.image {
                cell.avatar.setRoundedImage(image)
            } else {
                let imageLoadOperation = ImageLoadOperation(url: viewModel.avatarUrl)
                imageLoadOperation.completionHandler = { [weak self] (image) in
                    guard let self = self else {
                        return
                    }
                    cell.avatar.setRoundedImage(image)
                    self.imageLoadOperations.removeValue(forKey: indexPath)
                }
            }
        }
        
        if Feature.debugCellLifecycle.isEnabled {
            print(String.init(format: "cellfForRowAt #%i", indexPath.row))
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView,
                            willDisplay cell: UITableViewCell,
                            forRowAt indexPath: IndexPath) {
        
        if Feature.debugCellLifecycle.isEnabled {
            print(String.init(format: "willDisplay #%i", indexPath.row))
        }
    }
    
    override func tableView(_ tableView: UITableView,
                            didEndDisplaying cell: UITableViewCell,
                            forRowAt indexPath: IndexPath) {
        
        guard let imageLoadOpertion = imageLoadOperations[indexPath] else {
            return
        }
        imageLoadOpertion.cancel()
        imageLoadOperations.removeValue(forKey: indexPath)
        if Feature.debugCellLifecycle.isEnabled {
            print(String.init(format: "didEndDisplaying #%i", indexPath.row))
        }
    }
}

// MARK: - UITableViewDataSourcePrefetching
extension ViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView,
                   prefetchRowsAt indexPaths: [IndexPath]) {
        
        for indexPath in indexPaths {
            if let _ = imageLoadOperations[indexPath] {
                return
            }
            if let viewModel = userViewModelController.viewModel(at: (indexPath as NSIndexPath).row) {
                let imageLoadOperation = ImageLoadOperation(url: viewModel.avatarUrl)
                imageLoadQueue.addOperation(imageLoadOperation)
                imageLoadOperations[indexPath] = imageLoadOperation
            }
            
            if Feature.debugCellLifecycle.isEnabled {
                print(String.init(format: "prefetchRowsAt #%i", indexPath.row))
            }
        }
    }
    
    func tableView(_ tableView: UITableView,
                   cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            guard let imageLoadOperation = imageLoadOperations[indexPath] else {
                return
            }
            imageLoadOperation.cancel()
            imageLoadOperations.removeValue(forKey: indexPath)
            if Feature.debugCellLifecycle.isEnabled {
                print(String.init(format: "cancelPrefetchingForRowsAt #%i", indexPath.row))
            }
        }
    }
}

