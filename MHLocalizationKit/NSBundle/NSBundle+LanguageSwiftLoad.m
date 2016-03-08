//
//  NSBundle+LanguageSwiftLoad.m
//  MHLocalizationKit
//
//  Created by Milen Halachev on 3/7/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

#import "NSBundle+LanguageSwiftLoad.h"
#import <objc/runtime.h>
#import <MHLocalizationKit/MHLocalizationKit-Swift.h>

@implementation NSBundle (LanguageSwiftLoad)

+(void)load
{
    [self _language_swift_load];
}

@end
