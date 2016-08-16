//
//  UIRefreshControl+Smooth.m
//  TableviewRefresh
//
//  Created by sheldonloys on 16/8/16.
//  Copyright © 2016年 sheldonloys. All rights reserved.
//

#import "UIRefreshControl+Smooth.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation UIRefreshControl (Smooth)

+ (void)load{
    static dispatch_once_t hookOnce;
    dispatch_once(&hookOnce, ^{
        Method ori_Method = class_getInstanceMethod([UIRefreshControl class],sel_registerName("_addInsetHeight:"));
        Method new_Method = class_getInstanceMethod([UIRefreshControl class], @selector(_myAddInsetHeight:));
        
        method_exchangeImplementations(ori_Method,new_Method);
        
        Method ori_Method2 = class_getInstanceMethod([UIRefreshControl class],         sel_registerName("_recomputeNewState"));
        Method new_Method2 = class_getInstanceMethod([UIRefreshControl class], @selector(_myRecomputeNewState));
        method_exchangeImplementations(ori_Method2,new_Method2);
    });
}

- (void)_myAddInsetHeight:(double)height {
    
    if (height == [[self valueForKey:@"_refreshControlHeight"] floatValue]) {
        height = 0.0;
    }
    [self _myAddInsetHeight:height];
}

- (int)_myRecomputeNewState {
    
    int state = [self _myRecomputeNewState];
    
    UIScrollView *parentScroll = [self valueForKey:@"_scrollView"];
    parentScroll.userInteractionEnabled = YES;
    
    if (state >= 2 && state <4 && !parentScroll.isDragging) {
        [self _myAddInsetHeight:[[self valueForKey:@"_refreshControlHeight"] floatValue]+0.1];
        parentScroll.userInteractionEnabled = NO;
    }
    return [self _myRecomputeNewState];
}

@end
