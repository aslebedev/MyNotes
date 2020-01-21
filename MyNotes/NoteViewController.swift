//
//  NoteViewController.swift
//  MyNotes
//
//  Created by alexander on 21.01.2020.
//  Copyright © 2020 alexander. All rights reserved.
//

import UIKit

class NoteViewController: UIViewController {

    @IBOutlet weak var noteTextView: UITextView!
    
    var notes = Notes()
    var note: Note!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)

        let delete = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteNote))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbarItems = [delete, spacer]
        navigationController?.isToolbarHidden = false
        
        noteTextView.text = note.text
        if note.text.isEmpty {
            noteTextView.becomeFirstResponder()
        }
    }
    
    // MARK: - Work with note methods
    
    @objc private func deleteNote() {
        noteTextView.text = ""
        self.navigationController?.popViewController(animated: true)
    }
    
    //  MARK: - Keyboard behaviour
    
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)

        if notification.name == UIResponder.keyboardWillHideNotification {
            noteTextView.contentInset = .zero
            
            if noteTextView.text.isEmpty {
                toolbarItems?.last?.isEnabled = false
            } else {
                toolbarItems?.last?.isEnabled = true
            }
            
            if note.text != noteTextView.text {
                notes.save()
            }
            
            note.changeText(newText: noteTextView.text)
        } else {
            noteTextView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneEditing))
        }

        noteTextView.scrollIndicatorInsets = noteTextView.contentInset

        let selectedRange = noteTextView.selectedRange
        noteTextView.scrollRangeToVisible(selectedRange)
    }
    
    @objc private func doneEditing() {
        noteTextView.resignFirstResponder()
        self.navigationItem.rightBarButtonItem = nil
    }
    
    //  MARK: - View beehaviour
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        note.changeText(newText: noteTextView.text)
        
        if !notes.items.contains(note) && !noteTextView.text.isEmpty {
            notes.addItem(note)
        }
    }
}
