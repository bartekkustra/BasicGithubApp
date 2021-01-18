//
//  ListViewController.swift
//  GithubFeed
//
//  Created by Aleksandra Kustra on 13/01/2021.
//

import UIKit
import Foundation
import CoreData

final class ListViewController: UICollectionViewController {
    private let viewFactory: ListViewFactory
    //TODO: Implement showing and hiding errorState
    private let viewManager: ListViewManaging?
    private let viewModel: ListViewModel
    private var dataSource: UICollectionViewDataSource & ListDataSourceProtocol
    private let router: Router
    private let authModel: Oauth2Model?

    private lazy var listView = viewFactory.make()
    private var noDataIsSaved: Bool = true

    init(
        viewFactory: ListViewFactory,
        viewManager: ListViewManaging? = nil,
        viewModel: ListViewModel,
        dataSource: UICollectionViewDataSource & ListDataSourceProtocol,
        layout: UICollectionViewFlowLayout,
        router: Router,
        authModel: Oauth2Model?
    ) {
        self.viewFactory = viewFactory
        self.viewManager = viewManager
        self.viewModel = viewModel
        self.dataSource = dataSource
        self.router = router
        self.authModel = authModel

        super.init(collectionViewLayout: layout)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = listView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource.setup(collectionView: listView.collectionView)
        listView.collectionView.delegate = self
        listView.searchBar.delegate = self
        listView.collectionView.dataSource = dataSource

        navigationItem.title = viewModel.title
        navigationItem.setHidesBackButton(true, animated: true)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Refresh", style: .plain, target: self, action: #selector(refreshList))
        
        listView.layoutButton.setTitle("Grid", for: .normal)
        listView.layoutButton.addTarget(self, action: #selector(changeLayout(sender:)), for: .touchUpInside)
        
        listView.filterRepositoryButton.setTitle("Repo", for: .normal)
        listView.filterRepositoryButton.addTarget(self, action: #selector(filterRepository(sender:)), for: .touchUpInside)
        
        listView.filterTeamButton.setTitle("Team", for: .normal)
        listView.filterTeamButton.addTarget(self, action: #selector(filterTeam(sender:)), for: .touchUpInside)
        
        listView.filterActivityButton.setTitle("Activity", for: .normal)
        listView.filterActivityButton.addTarget(self, action: #selector(filterActivity(sender:)), for: .touchUpInside)
        
        updateViewModel()
    }
    
    @objc private func refreshList() {
        updateViewModel()
    }

    private func updateViewModel() {
        listView.activityIndicator.startAnimating()
        listView.isUserInteractionEnabled = false
        viewModelWillUpdate()
        viewModel.update { [weak self] error in
            DispatchQueue.main.async {
                self?.listView.activityIndicator.stopAnimating()
                self?.listView.isUserInteractionEnabled = true
                if let error = error {
                    self?.handleError(error)
                    return
                }
                self?.viewModelDidUpdate()
            }
        }
    }
    
    private func viewModelWillUpdate() {
        viewManager?.hideErrorState(from: listView)
    }
    
    private func viewModelDidUpdate() {
        noDataIsSaved = retriveData().isEmpty
        if noDataIsSaved {
            for section in viewModel.sections {
                saveDataForOffline(for: section)
            }
        }
        
        dataSource.sections = viewModel.sections
        listView.collectionView.reloadData()
        navigationItem.title = viewModel.title
    }

    private func handleError(_ error: Error) {
        //TODO: Refactor updating data for offline
        let storedData = retriveData()
        viewModel.updateForOffline(storedData: storedData)
        dataSource.sections = viewModel.sections
        listView.collectionView.reloadData()
        //TODO: Add error handler
        navigationItem.title = "Error occured"
    }

    @objc private func changeLayout(sender: UIBarButtonItem) {
        if dataSource.isListView {
            listView.layoutButton.setTitle("List", for: .normal)
            dataSource.isListView = false
        } else {
            listView.layoutButton.setTitle("Grid", for: .normal)
            dataSource.isListView = true
        }
        listView.collectionView.reloadData()
    }
    
    private func applyFilters() {
        dataSource.sections = viewModel.apply()
        listView.collectionView.reloadData()
    }
    
    @objc private func filterRepository(sender: UIBarButtonItem) {
        //TODO: Add to viewManager
        if viewModel.filters.contains(.repository) {
            listView.filterRepositoryButton.backgroundColor = .navyBlue()
            viewModel.remove(currentFilters: .repository)
        } else {
            listView.filterRepositoryButton.backgroundColor = .peach()
            viewModel.add(currentFilters: .repository)
        }
        applyFilters()
    }
    
    @objc private func filterTeam(sender: UIBarButtonItem) {
        //TODO: Add to viewManager
        if viewModel.filters.contains(.team) {
            viewModel.remove(currentFilters: .team)
            listView.filterTeamButton.backgroundColor = .navyBlue()
        } else {
            listView.filterTeamButton.backgroundColor = .peach()
            viewModel.add(currentFilters: .team)
        }
        applyFilters()
    }
    
    @objc private func filterActivity(sender: UIBarButtonItem) {
        //TODO: Add to viewManager
        if viewModel.filters.contains(.activity) {
            viewModel.remove(currentFilters: .activity)
            listView.filterActivityButton.backgroundColor = .navyBlue()
        } else {
            listView.filterActivityButton.backgroundColor = .peach()
            viewModel.add(currentFilters: .activity)
        }
        applyFilters()
    }
    
    private func saveDataForOffline(for section: ListSectionProtocol) {
        let user = viewModel.title
        for item in section.items {
            let item = StoredItemEntity(
                itemTitle: item.title,
                itemShortTitle: item.shortTitle ?? "",
                itemDescription: item.description ?? ""
            )
            self.save(item: item, for: user)
        }
    }
}

extension ListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            self.dataSource.sections = viewModel.sections
        } else {
            var sectionsResult: [ListSectionProtocol] = []
            var items: [ListItemProtocol] = []
            
            for sections in viewModel.sections {
                //TODO: Refactor
                if viewModel.filters.isEmpty || viewModel.filters.contains(sections.type) || viewModel.filters.count == 3 {
                    items = []
                    for item in sections.items {
                        let description = item.description?.lowercased() ?? ""
                        
                        if
                            item.title.lowercased().contains(searchText.lowercased()) ||
                                description.contains(searchText.lowercased())
                        {
                            items.append(item)
                        }
                    }
                    if !items.isEmpty {
                        sectionsResult.append(ListSection(title: sections.title, type: sections.type, items: items, isSelectable: sections.isSelectable))
                    }
                }
            }
            dataSource.sections = sectionsResult
        }
        listView.collectionView.reloadData()
    }
}

extension ListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = listView.collectionView.safeAreaLayoutGuide.layoutFrame.width
        if dataSource.isListView {
            return CGSize(width: width, height: 100)
        } else {
            return CGSize(width: (width - 15)/2, height: (width - 15)/2)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = listView.collectionView.safeAreaLayoutGuide.layoutFrame.width
        return CGSize(width: width, height: 40)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedItem = dataSource.sections[indexPath.section].items[indexPath.item]
        if dataSource.sections[indexPath.section].isSelectable {
            let viewController = DetailsViewDependencyConfigurator().configure(
                authModel: authModel,
                repositoryName: selectedItem.title
            )
            router.route(to: viewController)
        }
    }
}

extension ListViewController {
    private func save(item: StoredItemEntity, for user: String) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainer.viewContext
            
            guard
                let itemEntityDescription = NSEntityDescription.entity(forEntityName: "ItemModel", in: context)
            else {
                return
            }
            
            let newValue = NSManagedObject(entity: itemEntityDescription, insertInto: context)
            newValue.setValue(item.itemTitle, forKey: "title")
            newValue.setValue(item.itemShortTitle, forKey: "shortTitle")
            newValue.setValue(item.itemDescription, forKey: "itemDescription")
            
            do {
                try context.save()
            } catch {
                //TODO: Hadnle error
                fatalError("Error occured")
            }
        }
    }
    
    private func retriveData() -> [StoredItemEntity] {
        var storedResults: [StoredItemEntity] = []
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainer.viewContext
            let fetchItemRequest = NSFetchRequest<ItemModel>(entityName: "ItemModel")
            
            do {
                let itemResults = try context.fetch(fetchItemRequest)
                for result in itemResults {
                    let itemTitle = result.title
                    let itemShortTitle = result.shortTitle
                    let description = result.description
                    
                    let result = StoredItemEntity(
                        itemTitle: itemTitle ?? "",
                        itemShortTitle: itemShortTitle ?? "",
                        itemDescription: description
                    )
                    storedResults.append(result)
                }
            } catch {
                //TODO: Hadnle error
                fatalError("Error occured")
            }
        }
        return storedResults
    }
}
