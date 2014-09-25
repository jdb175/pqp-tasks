//
//  DetailViewController.h
//  PQPTasks
//
//  Created by Jason Whitehouse on 9/18/14.
//  Copyright (c) 2014 WPI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AJVDetailViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) id toDoItem;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
