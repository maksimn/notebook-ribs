//
//  WordTableController.swift
//  PersonalDictionary
//
//  Created by Maxim Ivanov on 05.10.2021.
//

import UIKit

typealias DeleteActionViewParams = ViewParams<DeleteActionStaticContent, DeleteActionStyles>

struct DeleteActionStaticContent {
    let image: UIImage
}

struct DeleteActionStyles {
    let backgroundColor: UIColor
}

final class WordTableController: NSObject, UITableViewDataSource, UITableViewDelegate {

    var changedItemPosition: Int = -1

    var wordList: [WordItem] {
        willSet {
            previousWordCount = wordList.count
        }
        didSet {
            updateTableView()
        }
    }

    private var previousWordCount = -1

    private let deleteActionViewParams: DeleteActionViewParams?
    private var onDeleteTap: ((Int) -> Void)?

    private unowned let tableView: UITableView

    init(tableView: UITableView,
         wordList: [WordItem],
         onDeleteTap: ((Int) -> Void)?,
         deleteActionViewParams: DeleteActionViewParams?) {
        self.tableView = tableView
        self.wordList = wordList
        self.onDeleteTap = onDeleteTap
        self.deleteActionViewParams = deleteActionViewParams
        super.init()
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        wordList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(WordItemCell.self)",
                                                       for: indexPath) as? WordItemCell else {
            return UITableViewCell()
        }
        let wordItem = wordList[indexPath.row]

        cell.set(wordItem: wordItem)

        return cell
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let onDeleteTap = onDeleteTap,
              let deleteActionViewParams = deleteActionViewParams else {
            return nil
        }
        let deleteAction = UIContextualAction(style: .normal, title: "",
                                              handler: { (_, _, success: (Bool) -> Void) in
                                                onDeleteTap(indexPath.row)
                                                success(true)
                                              })

        deleteAction.image = deleteActionViewParams.staticContent.image
        deleteAction.backgroundColor = deleteActionViewParams.styles.backgroundColor

        return UISwipeActionsConfiguration(actions: [deleteAction])
    }

    // MARK: - Private

    private func updateTableView() {
        if wordList.count == previousWordCount - 1 {
            guard changedItemPosition > -1 && changedItemPosition <= wordList.count else { return }

            tableView.deleteRows(at: [IndexPath(row: changedItemPosition, section: 0)], with: .automatic)
        } else if wordList.count == previousWordCount {
            guard changedItemPosition > -1 && changedItemPosition < wordList.count else { return }

            tableView.reloadRows(at: [IndexPath(row: changedItemPosition, section: 0)], with: .automatic)
        } else if wordList.count == previousWordCount + 1 {
            let count = wordList.count - 1

            tableView.insertRows(at: [IndexPath(row: count, section: 0)], with: .automatic)
        } else {
            tableView.reloadData()
        }
    }
}
