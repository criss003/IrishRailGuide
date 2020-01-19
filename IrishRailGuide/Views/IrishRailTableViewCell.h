//
//  IrishRailTableViewCell.h
//  IrishRailGuide
//
//  Created by Criss on 1/5/16.
//  Copyright © 2016 Criss. All rights reserved.
//

@interface IrishRailTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *dueInLabel;
@property (weak, nonatomic) IBOutlet UILabel *expdepartLabel;
@property (weak, nonatomic) IBOutlet UILabel *directionLabel;
@property (weak, nonatomic) IBOutlet UILabel *traintypeLabel;

@end
