//
//  MasterViewController.h
//  PQPTasks
//
//  Created by
//    Jason Whitehouse
//    Victor Andreoni
//  Copyright (c) 2014 WPI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AJVMasterViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
