//
//  FeedTableViewController.h
//  SFHS News
//
//  Created by Harish Kamath on 12/20/14.
//  Copyright (c) 2014 Harish Kamath. All rights reserved.
//
//This is the News tab. It is primarily a single table view controller, with a navigation bar, the sidebar button, and a table view. This table view calls from the FeedTableViewCell, which is a template for all the cells that this table view will hold. It is split into two sections, week and later, to give the user a clear distinction based upon chronological order.

#import <UIKit/UIKit.h>

@interface FeedTableViewController : UITableViewController<UITableViewDelegate>{
    CATransition *animation;
    
    //Arrays containing data received from database.
    NSArray *eventInfos;
    NSMutableArray *eventWeek;
    NSMutableArray *eventMonth;
}

-(IBAction)changeSelection;
@end
