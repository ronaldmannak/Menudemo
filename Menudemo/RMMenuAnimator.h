//
//  RMMenuAnimator.h
//  Menudemo
//
//  Created by Ronald Mannak on 12/7/13.
//  Copyright (c) 2013 Ronald Mannak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RMAnimator.h"

@interface RMMenuAnimator : RMAnimator <UIViewControllerInteractiveTransitioning>

@property (nonatomic) BOOL dismiss; // Should be set to YES for dismiss animation

@end
