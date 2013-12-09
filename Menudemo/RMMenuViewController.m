//
//  RMMenuViewController.m
//  Menudemo
//
//  Created by Ronald Mannak on 12/7/13.
//  Copyright (c) 2013 Ronald Mannak. All rights reserved.
//

#import "RMMenuViewController.h"
#import "UIImage+ImageEffects.h"
#import "RMMenuDelegate.h"

static const NSInteger kNoIndexSelected = -1;

@interface RMMenuViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UITapGestureRecognizer    *dismissRecognizer;
@property (nonatomic, strong) UIPanGestureRecognizer    *panRecognizer;

@end

@implementation RMMenuViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationCustom;        // Keep presentingViewController visible on screen
//        self.modalInPopover; // Does not dismiss the modal view controller when tapped outside view on iPhone (like iPad does)
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Tap outside menu view to dismiss menu
    self.presentingViewController.view.userInteractionEnabled = NO;
    self.dismissRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOutsideView:)];
    [self.dismissRecognizer setNumberOfTapsRequired:1];
    self.dismissRecognizer.cancelsTouchesInView = NO;
    [self.presentingViewController.view.window addGestureRecognizer:self.dismissRecognizer];
    
    // Pan left to dismiss menu
    self.panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.presentingViewController.view.window addGestureRecognizer:self.panRecognizer];
    [self.view addGestureRecognizer:self.panRecognizer];
}

// Note: if dismissViewControllerAnimated is called, dismissRecognizer won't be removed, and user interaction will stay NO
- (void)dismissMenuWithIndex:(NSInteger)index
{
    [self.presentingViewController.view.window removeGestureRecognizer:self.dismissRecognizer];
    [self.presentingViewController.view.window removeGestureRecognizer:self.panRecognizer];
    
    self.presentingViewController.view.userInteractionEnabled = YES;
    
    UITabBarController *tabBarController = ((UITabBarController *)self.presentingViewController);
    
    [tabBarController dismissViewControllerAnimated:YES completion:^{
        if (index != kNoIndexSelected) {
            tabBarController.selectedIndex = index;
        }
    }];
}

#pragma mark - UIGestureRecognizer

- (void)tapOutsideView:(UITapGestureRecognizer *)sender
{
    CGPoint location = [sender locationInView:self.view];
    
    if (!CGRectContainsPoint(self.view.bounds, location)) {
        [self dismissMenuWithIndex:kNoIndexSelected];
    }
}

- (void)pan:(UIPanGestureRecognizer*)recognizer
{
    UIView *view = recognizer.view;
    NSLog(@"State: %li", recognizer.state);
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
//            ((RMMenuDelegate *)self.transitioningDelegate).interactionController = [[UIPercentDrivenInteractiveTransition alloc] init];
            [self dismissMenuWithIndex:kNoIndexSelected];
            break;
            
        case UIGestureRecognizerStateChanged: {
            
            // TODO: using RMMenuDelegate here isn't pretty, no link to RMMenuDelegate would be better
            CGPoint translation = [recognizer translationInView:view];
            CGFloat distance = fabs(translation.x / CGRectGetWidth(view.bounds));
            [((RMMenuDelegate *)self.transitioningDelegate).interactionController updateInteractiveTransition:distance];
            NSLog(@"distance: %f", distance);
            break;
        }
            
        case UIGestureRecognizerStateEnded:
            
            if ([recognizer velocityInView:view].x > 0) {
                [((RMMenuDelegate *)self.transitioningDelegate).interactionController finishInteractiveTransition];
            } else {
                [((RMMenuDelegate *)self.transitioningDelegate).interactionController cancelInteractiveTransition];
            }
            ((RMMenuDelegate *)self.transitioningDelegate).interactionController = nil;
            break;
            
        default:
            break;
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self dismissMenuWithIndex:indexPath.row];
}

- (void)tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
}

@end
