//
//  DetailViewController.m
//  PQPTasks
//
//  Created by Jason Whitehouse on 9/18/14.
//  Copyright (c) 2014 WPI. All rights reserved.
//

#import "AJVDetailViewController.h"
#import <CoreData/CoreData.h>


@interface AJVDetailViewController ()
@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UITextField *descriptionField;
@property (weak, nonatomic) IBOutlet UISwitch *completeField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
- (void)configureView;
@end

@implementation AJVDetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(NSManagedObject*)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.navigationItem.title = [self.detailItem valueForKey:@"title"];
        // self.detailDescriptionLabel.text = [self.detailItem valueForKey:@"todoDescription"];
        
        self.titleField.text = [self.detailItem valueForKey:@"title"]  ;
        self.descriptionField.text = [self.detailItem valueForKey:@"todoDescription"];
        
        self.completeField.enabled = YES;
        self.completeField.On = (BOOL)[self.detailItem valueForKey:@"isDone"];
        self.saveButton.enabled = NO;
    }
}

- (IBAction)insertNewObject:(UIBarButtonItem *)sender
{
    // These hard-coded values are temporary to showcase persistent data. A new view controller will be needed
    // to create new to-dos
    
    // Set up entity
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"AJVToDoItem" inManagedObjectContext:self.managedObjectContext];
    
    // Set up record
    NSManagedObject *record = [[NSManagedObject alloc] initWithEntity:entity insertIntoManagedObjectContext:self.managedObjectContext];
    
    [record setValue:self.titleField.text forKey:@"title"];
    [record setValue:self.descriptionField.text forKey:@"todoDescription"];
    [record setValue:[NSDate date] forKey:@"dateAdded"];
    [record setValue:NO forKey:@"isDone"];
    
    // Save record
    NSError *error = nil;
    
    if ([self.managedObjectContext save:&error]) {
        [[[UIAlertView alloc] initWithTitle:@"Success!" message:@"A to-do item was created" delegate:nil cancelButtonTitle:@"Awesome!" otherButtonTitles:nil] show];
    } else {
        if (error) {
            NSLog(@"Unable to save to-do item.");
            NSLog(@"%@, %@", error, error.localizedDescription);
        }
        
        // Show Alert View
        [[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Your to-do could not be saved" delegate:nil cancelButtonTitle:@"Ahh :(" otherButtonTitles:nil] show];
    }

}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
