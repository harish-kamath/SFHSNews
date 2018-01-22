//
//  ClubViewController.h
//  SFHS News
//
//  Created by Harish Kamath on 12/29/14.
//  Copyright (c) 2014 Harish Kamath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClubInfo.h"

@interface ClubViewController : UIViewController
{
    NSArray *dataArray;
    ClubInfo *info;
}

@property (nonatomic, assign) int uniqueID;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *advisorLabel;
@property (weak, nonatomic) IBOutlet UILabel *contactLabel;
@property (weak, nonatomic) IBOutlet UILabel *meetingLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *eventScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *resultsLabel;
@property (weak, nonatomic) IBOutlet UIButton *facebook;
@property (weak, nonatomic) IBOutlet UIButton *twitter;
-(IBAction)getFacebook;
-(IBAction)getTwitter;
@end
