//
//  UIViewController+LocalizableSwiftLoad.m
//  MHLocalizationKit
//
//  Created by Milen Halachev on 3/9/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

#import "UIViewController+LocalizableSwiftLoad.h"
#import <MHLocalizationKit/MHLocalizationKit-Swift.h>

@implementation UIViewController (LocalizableSwiftLoad)

+(void)load {
 
    [self _localizable_swift_load];
}

@end
