//
//  DetailViewController.h
//  PQPTasks
//
//  Created by Jason Whitehouse on 9/18/14.
//  Copyright (c) 2014 WPI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
