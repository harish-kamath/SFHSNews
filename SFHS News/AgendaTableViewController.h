//
//  AgendaTableViewController.h
//  SFHS News
//
//  Created by Harish Kamath on 12/20/14.
//  Copyright (c) 2014 Harish Kamath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeedTableViewController.h"

@interface AgendaTableViewController : UITableViewController{
    //Aesthetic variables
    FeedTableViewController *feedViewController;
    CATransition *animation;
    
    //Data received from database.
    NSArray *eventInfos;
    NSMutableArray *uniqueIDArray;
}

@end
