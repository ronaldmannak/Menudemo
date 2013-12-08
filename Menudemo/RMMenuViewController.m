//
//  RMMenuViewController.m
//  Menudemo
//
//  Created by Ronald Mannak on 12/7/13.
//  Copyright (c) 2013 Ronald Mannak. All rights reserved.
//

#import "RMMenuViewController.h"

@interface RMMenuViewController ()

@property (nonatomic, strong) UITapGestureRecognizer *dismissRecognizer;
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

    self.presentingViewController.view.userInteractionEnabled = NO;
    self.dismissRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOutsideView:)];
    [self.dismissRecognizer setNumberOfTapsRequired:1];
    self.dismissRecognizer.cancelsTouchesInView = NO;
    [self.presentingViewController.view.window addGestureRecognizer:self.dismissRecognizer];
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

@end
