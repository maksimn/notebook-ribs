//
//  WordListView.swift
//  PersonalDictionary
//
//  Created by Maxim Ivanov on 05.10.2021.
//

protocol WordListView: AnyObject {

    func set(wordList: [WordItem])

    func addNewRowToList()

    func updateRowAt(_ position: Int)

    func removeRowAt(_ position: Int)

    func reloadList()
}
