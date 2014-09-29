//
//  AJVArithTestModel.m
//  PQPTasks
//
//  Created by Alexander Chen on 9/29/14.
//  Copyright (c) 2014 WPI. All rights reserved.
//

#import "AJVArithTestModel.h"

@implementation AJVArithTestModel

- (int)add:(NSInteger)addNum
{
    return self.num + addNum;
}

- (int)mult:(NSInteger)multNum
{
    return self.num * multNum;
}

@end
