//
//  StationsParser.h
//  DARTGuide
//
//  Created by Criss on 1/5/16.
//  Copyright © 2016 Criss. All rights reserved.
//

#import "TBXML.h"
#import "TBXML+HTTP.h"
#import "IrishRailStation.h"
#import "IrishRailTrain.h"

@interface IrishRailXMLParser : NSObject

@property (nonatomic) NSMutableArray *stationsArray;
@property (nonatomic) NSMutableArray *trainsArray;

+ (instancetype)sharedParser;

- (void)loadStationsDataWithSuccesBlock:(void (^)())succesBlock errorBlock:(void (^)(NSError *))errorBlock;
- (void)loadTrainsDataForStationCode:(NSString *)code succesBlock:(void (^)())succesBlock errorBlock:(void (^)(NSError *))errorBlock;

@end
