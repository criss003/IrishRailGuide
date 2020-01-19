//
//  IrishRailStationsViewController.m
//  IrishRailGuide
//
//  Created by Criss on 1/5/16.
//  Copyright © 2016 Criss. All rights reserved.
//

#import "IrishRailStationsViewController.h"
#import "IrishRailConstants.h"

@interface IrishRailStationsViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation IrishRailStationsViewController 

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.currentStationsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"IrishRailStationsTableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = [self.currentStationsArray objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    [self dismissViewControllerAnimated:YES completion:^{}];
    
    if ([self.delegate respondsToSelector:@selector(irishRailStationsViewController:didSelectStation:)])
    {
        [self.delegate irishRailStationsViewController:self didSelectStation:[self.currentStationsArray objectAtIndex:indexPath.row]];
    }
}

@end
