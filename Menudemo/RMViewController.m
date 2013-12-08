//
//  RMViewController.m
//  Menudemo
//
//  Created by Ronald Mannak on 12/8/13.
//  Copyright (c) 2013 Ronald Mannak. All rights reserved.
//

#import "RMViewController.h"
#import "RMMenuDelegate.h"

@interface RMViewController ()

@property (nonatomic, strong) id<UIViewControllerTransitioningDelegate>menuDelegate;

@end

@implementation RMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.menuDelegate = [[RMMenuDelegate alloc] init];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"MenuIdentifier"]) {
        
        UIViewController *toViewController = segue.destinationViewController;
        toViewController.transitioningDelegate = self.menuDelegate;
    }
    
    [super prepareForSegue:segue sender:segue];
}

@end
