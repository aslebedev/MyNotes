//
//  TableViewController.swift
//  MyNotes
//
//  Created by alexander on 21.01.2020.
//  Copyright © 2020 alexander. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    var notes = Notes()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "My Notes"
        navigationController?.navigationBar.prefersLargeTitles = true

        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let compose = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(createNote))
        toolbarItems = [spacer, compose]
        navigationController?.isToolbarHidden = false
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "NoteCell")
        
        loadNotes()
    }

    private func loadNotes() {
        
    }
    
    // MARK: - Work with notes methods
    
    @objc private func createNote() {
        if let nvc = storyboard?.instantiateViewController(withIdentifier: "NoteVC") as? NoteViewController {
            let newNote = Note()
            nvc.note = newNote
            nvc.notes = notes
            navigationController?.pushViewController(nvc, animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return notes.items.count
    }

    //  Show notes preview
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath)
        let note = notes.items[indexPath.row]
        cell.textLabel?.text = note.title
        cell.detailTextLabel?.text = note.subTitle
        return cell
    }

    //  Open note
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let nvc = storyboard?.instantiateViewController(withIdentifier: "NoteVC") as? NoteViewController {
            nvc.note = notes.items[indexPath.row]
            nvc.notes = notes
            navigationController?.pushViewController(nvc, animated: true)
        }
    }

    //  Delete notes
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            notes.removeItem(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
