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
        self.detailDescriptionLabel.text = [self.detailItem valueForKey:@"todoDescription"];
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
