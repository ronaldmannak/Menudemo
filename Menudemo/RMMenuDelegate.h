//
//  RMMenuDelegate.h
//  Menudemo
//
//  Created by Ronald Mannak on 12/7/13.
//  Copyright (c) 2013 Ronald Mannak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RMMenuDelegate : NSObject <UIViewControllerTransitioningDelegate>

@property (strong, nonatomic) UIPercentDrivenInteractiveTransition* interactionController;

@end
