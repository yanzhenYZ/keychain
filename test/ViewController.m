//
//  ViewController.m
//  test
//
//  Created by yanzhen on 17/3/28.
//  Copyright © 2017年 v2tech. All rights reserved.
//

#import "ViewController.h"
//#import "YZKeychainManager.h"
//#import <YZUIKit/YZKeychainManager.h>
#import "YZKeychainManager.h"
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //75B03C58-16A6-41E0-B1B5-15D5D69A90C6
//    NSLog(@"TTTT:%@",[YZKeyChainManager getDeviceUUIDWithBundleID:@"com.v2tech.test"]);
//    NSLog(@"TTTT:%@",[YZKeyChainManager getKeyChainItemWithIdentifier:@"1234"]);
//    [YZKeyChainManager deleteKeyChainItemWithIdentifier:@"com.v2tech.test"];
    Person *p = [[Person alloc] init];
    p.name = @"yanzhen";
    p.company = @"v2";
    
    [YZKeychainManager saveKeyChainItem:p identifier:@"person"];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//         NSLog(@"TTTT:%@",[YZKeyChainManager getDeviceUUIDWithBundleID:@"com.v2tech.test"]);
    Person *p = [YZKeychainManager getKeyChainItemWithIdentifier:@"person"];
    NSLog(@"TTTT:%@",p.name);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
