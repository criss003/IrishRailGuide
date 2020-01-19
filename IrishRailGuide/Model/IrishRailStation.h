//
//  IrishRailStation.h
//  IrishRailGuide
//
//  Created by Criss on 1/5/16.
//  Copyright © 2016 Criss. All rights reserved.
//

@interface IrishRailStation : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) CGFloat latitude;
@property (nonatomic, assign) CGFloat longitude;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *identifier;

@end
