//
//  ViewController.m
//  DARTGuide
//
//  Created by Criss on 1/5/16.
//  Copyright © 2016 Criss. All rights reserved.
//

#import "IrishRailViewController.h"
#import "IrishRailXMLParser.h"
#import "IrishRailTableViewCell.h"
#import "IrishRailConstants.h"
#import "IrishRailStationsViewController.h"

@interface IrishRailViewController () <IrishRailStationsViewControllerDelegate, UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *stationsTableView;
@property (weak, nonatomic) IBOutlet UIButton *currentStationButton;

@property (nonatomic, copy) NSString *currentStationCode;

- (IBAction)refreshAction:(id)sender;

@end

@implementation IrishRailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [[IrishRailXMLParser sharedParser] loadStationsDataWithSuccesBlock:^{
        
    }errorBlock:^(NSError *error){
        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [IrishRailXMLParser sharedParser].trainsArray.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"IrishRailTableViewCell";
    
    IrishRailTableViewCell *cell = (IrishRailTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (indexPath.row % 2)
    {
        cell.contentView.backgroundColor = [UIColor lightGrayColor];
    }
    else
    {
        cell.contentView.backgroundColor = [UIColor whiteColor];
    }
    
    if (indexPath.row != 0)
    {
        IrishRailTrain *train = [[IrishRailXMLParser sharedParser].trainsArray objectAtIndex:indexPath.row - 1];
        cell.expdepartLabel.text = train.expdepart;
        cell.traintypeLabel.text = train.traintype;
        cell.dueInLabel.text = train.dueIn;
        cell.directionLabel.text = train.direction;
    }
    
    return cell;
}

#pragma mark - Prepare For Segue

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] caseInsensitiveCompare: @"showStations"] == NSOrderedSame)
    {
        IrishRailStationsViewController *stationsViewController = [segue destinationViewController];
        stationsViewController.delegate = self;
        stationsViewController.currentStationsArray = @[kSuburbanStationBroombridge, kSuburbanStationBooterstown];
    }
}

#pragma mark - IrishRailStationsViewControllerDelegate

- (void)irishRailStationsViewController:(IrishRailStationsViewController *)irishRailStationsViewController didSelectStation:(NSString *)stationName
{
    [self.currentStationButton setTitle:stationName forState:UIControlStateNormal];
    
    for (IrishRailStation *station in [IrishRailXMLParser sharedParser].stationsArray)
    {
        if ([station.name isEqualToString:stationName])
        {
            self.currentStationCode = station.code;
            break;
        }
    }
    
    [self refreshAction:nil];
}

#pragma mark - IBActions

- (IBAction)refreshAction:(id)sender
{
    [[IrishRailXMLParser sharedParser] loadTrainsDataForStationCode:self.currentStationCode succesBlock:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.stationsTableView reloadData];
        });
    } errorBlock:^(NSError *error){
        
    }];
}

@end
