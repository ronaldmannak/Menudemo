//
//  RMModalViewController.m
//  Menudemo
//
//  Created by Ronald Mannak on 12/7/13.
//  Copyright (c) 2013 Ronald Mannak. All rights reserved.
//

#import "RMModalViewController.h"

@interface RMModalViewController ()

@end

@implementation RMModalViewController

- (IBAction)dismiss:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
