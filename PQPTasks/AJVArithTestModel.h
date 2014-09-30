//
//  AJVArithTestModel.h
//  PQPTasks
//
//  Created by Alexander Chen on 9/29/14.
//  Copyright (c) 2014 WPI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AJVArithTestModel : NSObject

@property (nonatomic) NSInteger num;

- (NSInteger)add:(NSInteger)addNum;
- (NSInteger)mult:(NSInteger)multNum;

@end
