//
//  ViewController.swift
//  PersonalDictionary
//
//  Created by Maxim Ivanov on 30.09.2021.
//

import RIBs
import UIKit

struct WordListViewStaticContent {
    let newWordButtonImage: UIImage
    let deleteAction: DeleteActionViewParams.StaticContent
}

struct WordListViewStyles {
    let backgroundColor: UIColor
    let deleteAction: DeleteActionViewParams.Styles
}

class WordListViewController: UIViewController {

    var viewModel: WordListViewModel?

    let staticContent: WordListViewStaticContent
    let styles: WordListViewStyles

    let searchBar = UISearchBar()
    let tableView = UITableView()
    let newWordButton = UIButton()
    let navigateToSearchButton = UIButton()

    lazy var tableController: WordTableController = {
        WordTableController(wordList: [],
                            onDeleteTap: self.onDeleteWordTap,
                            deleteActionViewParams: DeleteActionViewParams(staticContent: staticContent.deleteAction,
                                                                           styles: styles.deleteAction))
    }()

    init(staticContent: WordListViewStaticContent, styles: WordListViewStyles) {
        self.staticContent = staticContent
        self.styles = styles
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }
}

extension WordListViewController: WordListView {

    func set(wordList: [WordItem]) {
        tableController.wordList = wordList
    }

    func addNewRowToList() {
        let count = tableController.wordList.count - 1

        tableView.insertRows(at: [IndexPath(row: count, section: 0)], with: .automatic)
    }

    func updateRowAt(_ position: Int) {
        guard position > -1 && position < tableController.wordList.count else { return }

        tableView.reloadRows(at: [IndexPath(row: position, section: 0)], with: .automatic)
    }

    func removeRowAt(_ position: Int) {
        guard position > -1 && position <= tableController.wordList.count else { return }

        tableView.deleteRows(at: [IndexPath(row: position, section: 0)], with: .automatic)
    }

    func reloadList() {
        tableView.reloadData()
    }
}

// User Action Handlers:
extension WordListViewController {

    @objc
    func onDeleteWordTap(_ position: Int) {
        let item = tableController.wordList[position]

        viewModel?.remove(item, position)
    }

    @objc
    func onNewWordButtonTap() {
        viewModel?.navigateToNewWord()
    }

    @objc
    func onNavigateToSearchButtonTap() {
        viewModel?.navigateToSearch()
    }
}
