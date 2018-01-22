//
//  AchievementsTableViewController.m
//  SFHS News
//
//  Created by Harish Kamath on 1/9/15.
//  Copyright (c) 2015 Harish Kamath. All rights reserved.
//

#import "AchievementsTableViewController.h"
#import "SQLDatabase.h"
#import "EventInfo.h"
#import "SWRevealViewController.h"
#import "FeedTableViewCell.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "EventViewController.h"

@interface AchievementsTableViewController ()

@end

@implementation AchievementsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Aesthetics
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.navigationItem.backBarButtonItem setTarget: self.revealViewController];
        [self.navigationItem.backBarButtonItem setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    //Data from database.
    infoPast = [[NSMutableArray alloc] init];
    if([SQLDatabase database].eventInfos){
    for(EventInfo *info in [SQLDatabase database].eventInfos){
        if([self expiredDate:info.date]){
            [infoPast addObject:info];
        }
    }
    }
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//All of these methods are generally exactly from those in Feed and Agenda View Controllers. Exceptions will be explained.
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if([infoPast count] >0){
    if ([infoPast count] > 10) {
        return 10;
    }
    return [infoPast count];

    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FeedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"resultCell"];
    if(cell == nil){
        cell = [[FeedTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"resultCell"];
    }
    if([infoPast count] > 0){
    EventInfo *info = (EventInfo *)[infoPast objectAtIndex:indexPath.row];
    [cell.iconImage sd_setImageWithURL:[NSURL URLWithString:info.imageLink] placeholderImage:[UIImage imageNamed:@"placeholder.jpg"]];
    [cell.titleLabel setText:info.name];
    [cell.descriptionLabel setText:info.results];
    [cell.learnMore setTag:info.uniqueID];
      [cell.learnMore addTarget:self action:@selector(learnMoreClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    else{
        [cell.iconImage setImage:[UIImage imageNamed:@"placeholder.jpg"]];
        [cell.titleLabel setText:@"Sorry, No results Available!"];
        [cell.descriptionLabel setText:@"Check back later"];
        
        
    }
    // Configure the cell...
    
    return cell;
}

//Defines whether the given date has passed or not.
-(BOOL)expiredDate:(NSString *)dateInput{
    
    NSDateFormatter *df= [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSDate *dateString = [df dateFromString:dateInput];
    NSDate *dateCurrent = [NSDate date];
    NSComparisonResult result = [dateString compare:dateCurrent];

    switch (result) {
        case NSOrderedAscending:
           // NSLog(@"Ascending: %@", dateString);
            return true;
            break;
        case NSOrderedDescending:
           // NSLog(@"Descending: %@", dateString);
            return false;
        case NSOrderedSame:
            return false;
        default:
            break;
    }
}


-(void)learnMoreClicked:(UIButton *)sender{
    
    UIStoryboard *storyboard = [self storyboard];
    UINavigationController *eventViewController = [storyboard instantiateViewControllerWithIdentifier:@"NavControllerEvent"];
    EventViewController *actualViewController = (EventViewController *)eventViewController.topViewController;
    actualViewController.uniqueID = (int)sender.tag;
    [self presentViewController:eventViewController animated:YES completion:nil];
    
    
}


@end
