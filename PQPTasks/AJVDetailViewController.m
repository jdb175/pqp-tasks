//
//  DetailViewController.m
//  PQPTasks
//
//  Created by
//    Jason Whitehouse
//    Victor Andreoni
//  Copyright (c) 2014 WPI. All rights reserved.
//

#import "AJVDetailViewController.h"
#import <CoreData/CoreData.h>


@interface AJVDetailViewController ()

    @property (weak, nonatomic) IBOutlet UITextField *titleField;
    @property (weak, nonatomic) IBOutlet UITextField *descriptionField;
    @property (weak, nonatomic) IBOutlet UISwitch *completeField;
    @property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
    @property (weak, nonatomic) IBOutlet UISegmentedControl *priorityField;
    - (void)configureView;

@end

@implementation AJVDetailViewController

#pragma mark - Managing the detail item

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self configureView];
}

- (void)configureView
{
    // Update the user interface for the detail item.
    if (self.toDoItem) {
        // Set title
        self.navigationItem.title = [self.toDoItem valueForKey:@"title"];
        
        // Get values from object
        self.titleField.text = [self.toDoItem valueForKey:@"title"]  ;
        self.descriptionField.text = [self.toDoItem valueForKey:@"todoDescription"];
        self.completeField.enabled = YES;
        self.completeField.On = [[self.toDoItem valueForKey:@"isDone"] boolValue];
        self.priorityField.selectedSegmentIndex = [[self.toDoItem valueForKey:@"priority"] integerValue];
    } else {
        // Set title
        self.navigationItem.title = @"Create new ToDo";
        self.priorityField.selectedSegmentIndex = 0;
    }
}

/** Validate input fields from the interface
 
 Checks that required fields are properly populated
 
 @brief Validate input fields
 @result Whether the fields are valid or not
 */
- (bool)validateFields
{
    if (!self.titleField.text || !self.titleField.text.length) {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"The name field cannot be empty" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        return false;
    }
    return true;
}

/** Main method called for saving/updating a ToDoItem
 
 @brief Save ToDo Item
 @result The ToDo Item is saved
 
 @param sender The button calling this action
 */
- (IBAction)insertNewObject:(UIBarButtonItem *)sender
{
    // Validate interface fields
    if ([self validateFields]) {
        // Updating record
        if (self.toDoItem) {
            // Update record values
            [self.toDoItem setValue:self.titleField.text forKey:@"title"];
            [self.toDoItem setValue:self.descriptionField.text forKey:@"todoDescription"];
            [self.toDoItem setValue:[NSNumber numberWithBool:self.completeField.isOn] forKey:@"isDone"];
            [self.toDoItem setValue:[NSNumber numberWithInteger:self.priorityField.selectedSegmentIndex] forKey:@"priority"];
        } else {
            // Set up entity and record
            NSEntityDescription *entity = [NSEntityDescription entityForName:@"AJVToDoItem" inManagedObjectContext:self.managedObjectContext];
            NSManagedObject *record = [[NSManagedObject alloc] initWithEntity:entity insertIntoManagedObjectContext:self.managedObjectContext];
            
            // Set record values
            [record setValue:self.titleField.text forKey:@"title"];
            [record setValue:self.descriptionField.text forKey:@"todoDescription"];
            [record setValue:[NSDate date] forKey:@"dateAdded"];
            [record setValue:false forKey:@"isDone"];
            [record setValue:[NSNumber numberWithInteger:self.priorityField.selectedSegmentIndex] forKey:@"priority"];
        }
        
        // Pop the view controller
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
