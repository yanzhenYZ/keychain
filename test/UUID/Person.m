//
//  Person.m
//  test
//
//  Created by yanzhen on 17/3/28.
//  Copyright © 2017年 v2tech. All rights reserved.
//

#import "Person.h"

@implementation Person
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        self.name = [coder decodeObjectForKey:@"name"];
        self.company = [coder decodeObjectForKey:@"company"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.company forKey:@"company"];
}
@end
