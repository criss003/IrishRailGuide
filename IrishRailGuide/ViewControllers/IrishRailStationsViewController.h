//
//  IrishRailStationsViewController.h
//  IrishRailGuide
//
//  Created by Criss on 1/5/16.
//  Copyright © 2016 Criss. All rights reserved.
//

@class IrishRailStationsViewController;

@protocol IrishRailStationsViewControllerDelegate <NSObject>

@optional

- (void)irishRailStationsViewController:(IrishRailStationsViewController *)irishRailStationsViewController didSelectStation:(NSString *)stationName;

@end

@interface IrishRailStationsViewController : UIViewController

@property (nonatomic, assign) id<IrishRailStationsViewControllerDelegate> delegate;

@property (nonatomic) NSArray *currentStationsArray;

@end
