//
//  CreateTaskViewController.swift
//  Tasks
//
//  Created by Ben Gohlke on 4/20/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class CreateTaskViewController: UIViewController {
    
    // MARK: - Properties
    var complete = false
    
    // MARK: - IBOutlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var priorityControl: UISegmentedControl!
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - IBActions
    @IBAction func save(_ sender: Any) {
        
        // Grab individual values from the views
        guard let name = nameTextField.text,
            !name.isEmpty else { return }
        
        let notes = notesTextView.text
        
        let selctedPriority = priorityControl.selectedSegmentIndex
        let priority = TaskPriority.allCases[selctedPriority]
        
        Task(name: name,
             notes: notes,
             complete: complete,
             priority: priority,
             context: CoreDataStack.shared.mainContext)
        
        do {
            try CoreDataStack.shared.mainContext.save()
            navigationController?.dismiss(animated: true, completion: nil)
        } catch {
            NSLog("Error saving manage object context: \(error)")
        }
        
    }
    
    @IBAction func cancel(_ sender: Any) {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func toggleComplete(_ sender: UIButton) {
        complete.toggle()
        
        let image = complete ? UIImage(systemName: "checkmark.circle.fill") : UIImage(systemName: "circle")
        
        sender.setImage(image, for: .normal)
    }
}
