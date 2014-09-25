//
//  MasterViewController.m
//  PQPTasks
//
//  Created by
//    Jason Whitehouse
//    Victor Andreoni
//  Copyright (c) 2014 WPI. All rights reserved.
//

#import "AJVMasterViewController.h"

#import "AJVDetailViewController.h"

#import <CoreData/CoreData.h>

@interface AJVMasterViewController () <NSFetchedResultsControllerDelegate>

    @property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@end

@implementation AJVMasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Fetch stored values
    
    // Set up request
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"AJVToDoItem"];
    
    // Set up sort descriptor
    [fetchRequest setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"dateAdded" ascending:YES]]];
    
    // Set up controller
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    [self.fetchedResultsController setDelegate:self];
    
    // Fetch
    NSError *error = nil;
    [self.fetchedResultsController performFetch:&error];
    
    if (error) {
        NSLog(@"Unable to perform fetch.");
        NSLog(@"%@, %@", error, error.localizedDescription);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark Fetched results controller methods
- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    switch (type) {
        case NSFetchedResultsChangeInsert: {
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
        case NSFetchedResultsChangeDelete: {
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
        case NSFetchedResultsChangeUpdate: {
            // Get the record
            NSManagedObject *record = [self.fetchedResultsController objectAtIndexPath:indexPath];
            
            // Update the cell
            [self.tableView cellForRowAtIndexPath:indexPath].textLabel.text = [record valueForKey:@"title"];
            break;
        }
    }
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *sections = [self.fetchedResultsController sections];
    id<NSFetchedResultsSectionInfo> sectionInfo = [sections objectAtIndex:section];
    
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Fetch Record
    NSManagedObject *record = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    cell.textLabel.text = [record valueForKey:@"title"];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        // Set up the detail view controller
        AJVDetailViewController *detailViewController = (AJVDetailViewController *)[segue destinationViewController];
        detailViewController.managedObjectContext = self.managedObjectContext;
        
        // Determine which item is being selected
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSManagedObject *toDoItem = [self.fetchedResultsController objectAtIndexPath:indexPath];
        
        // Pass the ToDo item to the detail view
        detailViewController.toDoItem = toDoItem;
        
        // Set the back button for editing mode
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:self.navigationItem.title style:UIBarButtonItemStyleBordered target:nil action:nil];
    } else if ([[segue identifier] isEqualToString:@"New"]) {
        // Set up the detail view controller
        AJVDetailViewController *detailViewController = (AJVDetailViewController *)[segue destinationViewController];
        detailViewController.managedObjectContext = self.managedObjectContext;
        
        // Set back button for new ToDo items
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:nil action:nil];
        
    }
}

@end
