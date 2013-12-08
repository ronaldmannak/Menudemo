//
//  RMViewController.m
//  Menudemo
//
//  Created by Ronald Mannak on 12/8/13.
//  Copyright (c) 2013 Ronald Mannak. All rights reserved.
//

#import "RMViewController.h"
//#import "RMMenuDelegate.h"
#import "RMMenuAnimator.h"

@interface RMViewController ()

//@property (nonatomic, strong) id<UIViewControllerTransitioningDelegate>menuDelegate;
@property (nonatomic, strong) RMMenuAnimator *animator;

@end

@implementation RMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //    self.menuDelegate = [[RMMenuDelegate alloc] init];
    self.animator = [[RMMenuAnimator alloc] init];

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"MenuIdentifier"]) {
        
        UIViewController *toViewController = segue.destinationViewController;
        toViewController.transitioningDelegate = self;
    }
    
    [super prepareForSegue:segue sender:segue];
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source
{
    self.animator.dismiss = NO;
    return self.animator;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    self.animator.dismiss = YES;
    return self.animator;
}
/*
 - (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
 return AppDelegateAccessor.settingsInteractionController && AppDelegateAccessor.settingsInteractionController.interactionInProgress ? AppDelegateAccessor.settingsInteractionController : nil;
 }
 */

@end
