//
//  RMTabBarDelegate.m
//  Menudemo
//
//  Created by Ronald Mannak on 12/7/13.
//  Copyright (c) 2013 Ronald Mannak. All rights reserved.
//

#import "RMTabBarDelegate.h"
#import "RMTabBarAnimator.h"

@interface RMTabBarDelegate ()

@end

@implementation RMTabBarDelegate

- (id<UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController
           animationControllerForTransitionFromViewController:(UIViewController *)fromVC
                                             toViewController:(UIViewController *)toVC
{
    return [[RMTabBarAnimator alloc] init];
}

@end
