//
//  Person.h
//  test
//
//  Created by yanzhen on 17/3/28.
//  Copyright © 2017年 v2tech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject<NSCoding>
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *company;
@end
