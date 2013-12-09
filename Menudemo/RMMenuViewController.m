//
//  RMMenuViewController.m
//  Menudemo
//
//  Created by Ronald Mannak on 12/7/13.
//  Copyright (c) 2013 Ronald Mannak. All rights reserved.
//

#import "RMMenuViewController.h"
#import "UIImage+ImageEffects.h"

@interface RMMenuViewController ()

@property (nonatomic, strong) UITapGestureRecognizer    *dismissRecognizer;
@property (nonatomic, strong) UIToolbar                 *toolbar;
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
    
    // Add blurry background
    
    // Toolbar view doesn't animate fluidly
//    self.toolbar = [[UIToolbar alloc] initWithFrame:[self.view bounds]];
//    [self.view.layer insertSublayer:[self.toolbar layer] atIndex:0];

}

// Note: if dismissViewControllerAnimated is called, dismissRecognizer won't be removed, and user interaction will stay NO
- (void)dismissMenuWithIndex:(NSInteger)index
{
    [self.presentingViewController.view.window removeGestureRecognizer:self.dismissRecognizer];
    self.presentingViewController.view.userInteractionEnabled = YES;
    
    UITabBarController *tabBarController = ((UITabBarController *)self.presentingViewController);
    
    [tabBarController dismissViewControllerAnimated:YES completion:^{
        if (index >= 0) {
            tabBarController.selectedIndex = index;
        }
    }];
}

#pragma mark - UIGestureRecognizer

- (void)tapOutsideView:(UITapGestureRecognizer *)sender
{
    CGPoint location = [sender locationInView:self.view];
    
    if (!CGRectContainsPoint(self.view.bounds, location)) {
        [self dismissMenuWithIndex:-1];
    }
}

#pragma mark - UIGestureRecognizerDelegate

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
