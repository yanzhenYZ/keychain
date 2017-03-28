//
//  YZKeychainManager.m
//  test
//
//  Created by yanzhen on 17/3/28.
//  Copyright © 2017年 v2tech. All rights reserved.
//

#import "YZKeychainManager.h"

@implementation YZKeychainManager
+ (NSString * _Nonnull)getDeviceUUIDWithBundleID:(NSString  * _Nonnull)bundleID
{
    NSString *uuid = (NSString *)[self getKeyChainItemWithIdentifier:bundleID];
    if (uuid.length < 1) {
        uuid = [NSUUID UUID].UUIDString;
        //将该uuid保存到keychain
        [self saveKeyChainItem:uuid identifier:bundleID];
    }
    return uuid;
}

+ (void)saveKeyChainItem:(id _Nonnull)item identifier:(NSString * _Nonnull)identifier
{
    //Get search dictionary
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:identifier];
    //Delete old item before add new item
    SecItemDelete((CFDictionaryRef)keychainQuery);
    //Add new object to search dictionary(Attention:the data format)
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:item] forKey:(id)kSecValueData];
    //Add item to keychain with the search dictionary
    SecItemAdd((CFDictionaryRef)keychainQuery, NULL);
}

+ (id __nullable)getKeyChainItemWithIdentifier:(NSString * _Nonnull)identifier
{
    id ret = nil;
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:identifier];
    //Configure the search setting
    //Since in our simple case we are expecting only a single attribute to be returned (the password) we can set the attribute kSecReturnData to kCFBooleanTrue
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
    [keychainQuery setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
        } @catch (NSException *e) {
            NSLog(@"Unarchive of %@ failed: %@", identifier, e);
        } @finally {
            
        }
    }
    if (keyData)
        CFRelease(keyData);
    return ret;
}

+ (void)deleteKeyChainItemWithIdentifier:(NSString * _Nonnull)identifier
{
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:identifier];
    SecItemDelete((CFDictionaryRef)keychainQuery);
}

#pragma mark - KeyChainTool
+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service
{
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (id)kSecClassGenericPassword,(id)kSecClass,
            service, (id)kSecAttrService,
            service, (id)kSecAttrAccount,
            (id)kSecAttrAccessibleAfterFirstUnlock,(id)kSecAttrAccessible,
            nil];
}

@end
