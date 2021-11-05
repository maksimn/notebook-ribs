//
//  WordListView.swift
//  PersonalDictionary
//
//  Created by Maxim Ivanov on 05.10.2021.
//

protocol WordListView: AnyObject {

    func set(changedItemPosition: Int)

    func set(wordList: [WordItem])
}
