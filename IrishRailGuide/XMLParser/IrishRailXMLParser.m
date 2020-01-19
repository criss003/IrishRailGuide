//
//  StationsParser.m
//  DARTGuide
//
//  Created by Criss on 1/5/16.
//  Copyright © 2016 Criss. All rights reserved.
//

#import "IrishRailXMLParser.h"
#import "IrishRailConstants.h"

@interface IrishRailXMLParser ()

@property (nonatomic) TBXML *tbxml;

@end

@implementation IrishRailXMLParser

+ (instancetype)sharedParser
{
    static IrishRailXMLParser *sharedParser = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedParser = [[IrishRailXMLParser alloc] initParser];
    });
    
    return sharedParser;
}

- (instancetype)initParser
{
    self = [super init];
    
    if (self)
    {
        _stationsArray = [NSMutableArray array];
        _trainsArray = [NSMutableArray array];
    }
    
    return self;
}


- (void)loadStationsDataWithSuccesBlock:(void (^)())succesBlock errorBlock:(void (^)(NSError *))errorBlock
{
    [self.stationsArray removeAllObjects];
    
    TBXMLSuccessBlock successBlock = ^(TBXML *tbxmlDocument) {
        if (tbxmlDocument.rootXMLElement)
        {
            [self traverseElement:tbxmlDocument.rootXMLElement];
        }
        
        self.tbxml = nil;
        
        if (succesBlock)
        {
            succesBlock();
        }
    };
    
    TBXMLFailureBlock failureBlock = ^(TBXML *tbxmlDocument, NSError * error) {
        self.tbxml = nil;
        
        if (errorBlock)
        {
            errorBlock(error);
        }
        NSLog(@"Error! %@ %@", [error localizedDescription], [error userInfo]);
    };
    
    self.tbxml = [[TBXML alloc] initWithURL:[NSURL URLWithString:kSuburbanStationsURL]
                               success:successBlock
                               failure:failureBlock];
}

- (void)loadTrainsDataForStationCode:(NSString *)code succesBlock:(void (^)())succesBlock errorBlock:(void (^)(NSError *))errorBlock
{
    [self.trainsArray removeAllObjects];
    
    TBXMLSuccessBlock successBlock = ^(TBXML *tbxmlDocument) {
        if (tbxmlDocument.rootXMLElement)
        {
            [self traverseElement:tbxmlDocument.rootXMLElement];
        }
        
        self.tbxml = nil;
        
        if (succesBlock)
        {
            succesBlock();
        }
    };
    
    TBXMLFailureBlock failureBlock = ^(TBXML *tbxmlDocument, NSError * error) {
        self.tbxml = nil;
        
        if (errorBlock)
        {
            errorBlock(error);
        }
        NSLog(@"Error! %@ %@", [error localizedDescription], [error userInfo]);
    };
    
    self.tbxml = [[TBXML alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:kTrainStationsURL, code]]
                               success:successBlock
                               failure:failureBlock];
}


- (void) traverseElement:(TBXMLElement *)element
{
    do
    {
        if (element->firstChild)
        {
            [self traverseElement:element->firstChild];
        }
        
        if ([[TBXML elementName:element] isEqualToString:kObjStation])
        {
            TBXMLElement *descElement = [TBXML childElementNamed:kStationDesc parentElement:element];
            TBXMLElement *latitudeElement = [TBXML childElementNamed:kStationLatitude parentElement:element];
            TBXMLElement *longitudeElement = [TBXML childElementNamed:kStationLongitude parentElement:element];
            TBXMLElement *codeElement = [TBXML childElementNamed:kStationCode parentElement:element];
            TBXMLElement *idElement = [TBXML childElementNamed:kStationId parentElement:element];
            
            IrishRailStation *station = [[IrishRailStation alloc] init];
            station.name = [TBXML textForElement:descElement];
            station.latitude = [[TBXML textForElement:latitudeElement] doubleValue];
            station.longitude = [[TBXML textForElement:longitudeElement] doubleValue];
            station.code = [TBXML textForElement:codeElement];
            station.identifier = [TBXML textForElement:idElement];
            
            [self.stationsArray addObject:station];
        }
        else if ([[TBXML elementName:element] isEqualToString:kObjStationData])
        {
            TBXMLElement *dueInElement = [TBXML childElementNamed:kDuein parentElement:element];
            TBXMLElement *expdepartElement = [TBXML childElementNamed:kExpdepart parentElement:element];
            TBXMLElement *directionElement = [TBXML childElementNamed:kDirection parentElement:element];
            TBXMLElement *traintypeElement = [TBXML childElementNamed:kTraintype parentElement:element];
            
            IrishRailTrain *station = [[IrishRailTrain alloc] init];
            station.dueIn = [TBXML textForElement:dueInElement];
            station.expdepart = [TBXML textForElement:expdepartElement];
            station.direction = [TBXML textForElement:directionElement];
            station.traintype = [TBXML textForElement:traintypeElement];
            
            [self.trainsArray addObject:station];
        }
    }
    while ((element = element->nextSibling));
}

@end
