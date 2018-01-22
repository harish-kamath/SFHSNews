//
//  ClubViewController.m
//  SFHS News
//
//  Created by Harish Kamath on 12/29/14.
//  Copyright (c) 2014 Harish Kamath. All rights reserved.
//

#import "ClubViewController.h"
#import "ClubInfo.h"
#import "EventDatabase.h"
#import "SQLDatabase.h"
#import "EventInfo.h"
#import "EventViewController.h"
#import "SDWebImage/UIImageView+WebCache.h"

@interface ClubViewController ()

@end

@implementation ClubViewController
@synthesize imageView, titleLabel, resultsLabel, advisorLabel, meetingLabel, contactLabel,eventScrollView, scrollView, descriptionLabel, uniqueID, facebook, twitter;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //Gets data from database
    dataArray = [SQLDatabase database].clubInfos;
    info = [dataArray objectAtIndex:uniqueID];
    
    [self fillData];
}

//Method used to enter all data into view.
-(void)fillData{
    [imageView sd_setImageWithURL:[NSURL URLWithString:info.imageLink] placeholderImage:[UIImage imageNamed:@"placeholder.jpg"]];
    titleLabel.text = info.name;
    titleLabel.adjustsFontSizeToFitWidth = YES;
    resultsLabel.text = info.results;
    resultsLabel.adjustsFontSizeToFitWidth = YES;
    advisorLabel.text = info.advisor;
    advisorLabel.adjustsFontSizeToFitWidth = YES;
    meetingLabel.text = info.meeting;
    meetingLabel.adjustsFontSizeToFitWidth = YES;
    contactLabel.text = info.contact;
    contactLabel.adjustsFontSizeToFitWidth = YES;
    descriptionLabel.text = info.desc;
    descriptionLabel.adjustsFontSizeToFitWidth = YES;
    
    if(info.facebook.length > 0)
        [facebook setEnabled:YES];
    else{
        [facebook setEnabled:NO];
        [facebook setAlpha:0.5f];
    }
    
    if(info.twitter.length > 0)
        [twitter setEnabled:YES];
    else{
        [twitter setEnabled:NO];
        [twitter setAlpha:0.5f];
    }
    [self fillEventScrollView];
    eventScrollView.contentSize = CGSizeMake(eventScrollView.frame.size.width, [eventScrollView.subviews count]*25 + 25);
    eventScrollView.backgroundColor = [UIColor grayColor];


}

//Method that fills view which holds all events of the club.
-(void)fillEventScrollView{
    UILabel *eventLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, eventScrollView.frame.size.width, 15)];
    [eventLabel setText:@"Events"];
    [eventLabel setTextColor:[UIColor whiteColor]];
    [eventLabel setTextAlignment:NSTextAlignmentCenter];
    eventLabel.adjustsFontSizeToFitWidth = YES;
    [eventScrollView addSubview:eventLabel];
    
    //Fills data of events.
    NSArray *eventArray = [EventDatabase database].eventInfos;
    for (EventInfo *infoTemp in eventArray) {
        if ([infoTemp.club isEqualToString:info.name]) {
            NSLog(@"%@", infoTemp.name);
            UIButton *eventButton = [[UIButton alloc] init];
            [eventButton setTitle:infoTemp.name forState:UIControlStateNormal];
            eventButton.tag = infoTemp.uniqueID;
            eventButton.frame = CGRectMake(0, [eventScrollView.subviews count]*25, eventScrollView.frame.size.width, 20);
            eventButton.tintColor = [UIColor blueColor];
            eventButton.hidden = NO;
            eventButton.opaque = YES;
            eventButton.titleLabel.adjustsFontSizeToFitWidth = YES;
            [eventButton addTarget:self action:@selector(clickedEvent:) forControlEvents:UIControlEventTouchUpInside];
            [eventScrollView addSubview:eventButton];
        }
    }
}

//Social media methods.
-(IBAction)getFacebook{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:info.facebook]];
}
-(IBAction)getTwitter{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:info.twitter]];

}

//Method called whenever user clicks on an event from the events list of the club.
-(IBAction)clickedEvent:(UIButton *)sender{
    UIStoryboard *storyboard = [self storyboard];
    UINavigationController *eventViewController = [storyboard instantiateViewControllerWithIdentifier:@"NavControllerEvent"];
    EventViewController *actualViewController = (EventViewController *)eventViewController.topViewController;
    actualViewController.uniqueID = (int)sender.tag;
    
    [self presentViewController:eventViewController animated:YES completion:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Goes back to previous view controller.
-(IBAction)goBack{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}


@end
