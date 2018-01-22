//
//  EventViewController.h
//  SFHS News
//
//  Created by Harish Kamath on 12/26/14.
//  Copyright (c) 2014 Harish Kamath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventInfo.h"
#import "EventDatabase.h"

@interface EventViewController : UIViewController{
    NSArray *eventInfos;
    int indexOfInfo;
    EventInfo *info;

}


@property (weak, nonatomic) IBOutlet UIImageView *clubImage;
@property (weak, nonatomic) IBOutlet UILabel *clubLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *mainImage;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *extraInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultsLabel;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, nonatomic) int uniqueID;

@end
