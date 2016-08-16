//
//  UIRefreshControl+Smooth.h
//  TableviewRefresh
//
//  Created by sheldonloys on 16/8/16.
//  Copyright © 2016年 sheldonloys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIRefreshControl (Smooth)

- (void)_myAddInsetHeight:(double)height;
- (int)_myRecomputeNewState;

@end
