//
//  RMAnimator.m
//  Menudemo
//
//  Created by Ronald Mannak on 12/7/13.
//  Copyright (c) 2013 Ronald Mannak. All rights reserved.
//
//  Based on Jesse Wolff's SOLPresentationFun https://github.com/soleares/SOLPresentingFun

#import "RMAnimator.h"

static NSTimeInterval const kDefaultDuration = .3f;

@implementation RMAnimator

- (id)init
{
    self = [super init];
    if (self) {
        self.duration = kDefaultDuration;
    }
    return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return self.duration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    // Must be implemented by inheriting class
    [self doesNotRecognizeSelector:_cmd];
}

@end
