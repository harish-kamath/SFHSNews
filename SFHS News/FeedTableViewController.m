//
//  FeedTableViewController.m
//  SFHS News
//
//  Created by Harish Kamath on 12/20/14.
//  Copyright (c) 2014 Harish Kamath. All rights reserved.
//

#import "FeedTableViewController.h"
#import "FeedTableViewCell.h"
#import "EventDatabase.h"
#import "EventInfo.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "EventViewController.h"
#import "SQLDatabase.h"
#import "SWRevealViewController.h"
#import "ClubInfo.h"

@interface FeedTableViewController ()

@end

@implementation FeedTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Creates sideBar Menu
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.navigationItem.backBarButtonItem setTarget: self.revealViewController];
        [self.navigationItem.backBarButtonItem setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    //Initializes all database information needed.
    eventWeek = [[NSMutableArray alloc] init];
    eventMonth = [[NSMutableArray alloc] init];
    eventInfos = [SQLDatabase database].eventInfos;
    EventInfo *tempInfo = [[EventInfo alloc] init];
    for(EventInfo *info in eventInfos){
        double dayDifference = [tempInfo daysBetweenDate:[NSDate date] andDate:[info dateFormat]];
        if(dayDifference <= 7 && dayDifference >= 0)
            [eventWeek addObject:info];
        else if(dayDifference > 7)
            [eventMonth addObject:info];
    }
    
    //Aesthetic Code
    self.tableView.separatorColor = [UIColor clearColor];
    
    animation = [CATransition animation];
    [animation setDuration:0.5];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFromLeft];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Method used to autoscroll to "Later" section.
-(IBAction)changeSelection{
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        
}

//Beginning of all tableView information.
#pragma mark - Table view data source

//Defines height of each row in tableView.
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}

//The two sections represent the "Week" and "Later" sections on the view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}

//Self-explanatory
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if(section == 0)
        return [eventWeek count];
    
    return [eventMonth count];
}

//Self-explanatory
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
if(section == 0)
    return @"This Week";

    return @"Later";
}

//Defines each "cell" in the tableView. This is the actual content on the feed.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //Creates the cell.
    FeedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FeedCell"];
    if(cell == nil){
    cell = [[FeedTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FeedCell"];
    }
    
    //Gets the EventInfo object needed based on index of row.
    EventInfo *info = [[EventInfo alloc] init];
    if([indexPath section] == 0){
        info = [eventWeek objectAtIndex:indexPath.row];
        
        
    }
    else{
        info = [eventMonth objectAtIndex:indexPath.row];
    }
    
    //Aesthetics
    if(info.name)
    cell.titleLabel.text = info.name;
    else
        cell.titleLabel.text = @"No name for this event.";
    if (info.desc) {
    cell.descriptionLabel.text = info.desc;
    }
    else{
    cell.descriptionLabel.text = @"Sorry, no description available!";
    }
    ClubInfo *clubInfo = [[ClubInfo alloc] init];
    for(ClubInfo *tempClub in [SQLDatabase database].clubInfos){
        if ([tempClub.name isEqualToString:info.club]) {
            clubInfo = tempClub;
        }
    }
        [cell.iconImage sd_setImageWithURL:[NSURL URLWithString:clubInfo.imageLink] placeholderImage:[UIImage imageNamed:@"placeholder.jpg"]];
    [cell.dateLabel setText:[info dateString]];
    
    //NSLog(@"%i", info.uniqueID);
    cell.learnMore.tag = info.uniqueID;
    cell.signUp.tag = info.uniqueID;
    if([[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%li", (long)info.uniqueID ]]){
        [cell.signUp setTitle:@"Attending" forState:UIControlStateNormal];
    
    }
    cell.signUp.titleLabel.adjustsFontSizeToFitWidth = YES;
    
    [cell.learnMore addTarget:self action:@selector(learnMoreClicked:) forControlEvents:UIControlEventTouchUpInside];
    [cell.signUp addTarget:self action:@selector(signUpClicked:) forControlEvents:UIControlEventTouchUpInside];
    cell.cardView.frame = CGRectMake(10, 5, 300, 190);
    
    
    return cell;
}

//Goes to the event page, when "Learn More" button is clicked in cell.
-(void)learnMoreClicked:(UIButton *)sender{
    
    UIStoryboard *storyboard = [self storyboard];
    UINavigationController *eventViewController = [storyboard instantiateViewControllerWithIdentifier:@"NavControllerEvent"];
    EventViewController *actualViewController = (EventViewController *)eventViewController.topViewController;
    actualViewController.uniqueID = (int)sender.tag;

    [animation setSubtype:kCATransitionFromRight];
    [self.view.window.layer addAnimation:animation forKey:kCATransition];
    [self presentViewController:eventViewController animated:NO completion:nil];


}

//Signs up/unsigns person from an event.
-(void)signUpClicked:(UIButton *)sender{
    EventInfo *neededInfo = [[EventInfo alloc] init];
    for (EventInfo *info in eventInfos) {
        if (info.uniqueID == sender.tag) {
            neededInfo = info;
        }
    }
    
   // NSLog(@"%i", neededInfo.uniqueID);
    NSLog(@"%@",[NSNumber numberWithInteger:sender.tag]);
    NSLog(@"%li", (long)sender.tag);
    
    if ([sender.currentTitle isEqual:@"Sign Up"]) {
        [sender setTitle:@"Attending" forState:UIControlStateNormal];
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:sender.tag] forKey:[NSString stringWithFormat:@"%li", (long)sender.tag]];
        [[NSUserDefaults standardUserDefaults] synchronize];
        //NSLog(@"%lu", [[[NSUserDefaults standardUserDefaults] dictionaryRepresentation]count]);
    }
    else{
        [sender setTitle:@"Sign Up" forState:UIControlStateNormal];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:[NSString stringWithFormat:@"%li", (long)sender.tag]];
        [[NSUserDefaults standardUserDefaults] synchronize];
        //NSLog(@"%lu", [[[NSUserDefaults standardUserDefaults] dictionaryRepresentation]count]);
    }

}



@end
