//
//  RMMenuViewController.m
//  Menudemo
//
//  Created by Ronald Mannak on 12/7/13.
//  Copyright (c) 2013 Ronald Mannak. All rights reserved.
//

#import "RMMenuViewController.h"

@interface RMMenuViewController ()

@end

@implementation RMMenuViewController

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITabBarController *tabBarController = ((UITabBarController *)self.presentingViewController);
    
    [self dismissViewControllerAnimated:YES completion:^{
        tabBarController.selectedIndex = indexPath.row;
    }];
}

@end
