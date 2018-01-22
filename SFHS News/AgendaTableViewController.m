//
//  AgendaTableViewController.m
//  SFHS News
//
//  Created by Harish Kamath on 12/20/14.
//  Copyright (c) 2014 Harish Kamath. All rights reserved.
//

#import "AgendaTableViewController.h"
#import "FeedTableViewController.h"
#import "EventViewController.h"
#import "EventDatabase.h"
#import "FeedTableViewCell.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "SQLDatabase.h"
#import "SWRevealViewController.h"


@interface AgendaTableViewController ()

@end

@implementation AgendaTableViewController

- (void)viewDidLoad {
    //Initializes an instance of the Feed View. This is in order to access the events which the user is attending.
    feedViewController = [[FeedTableViewController alloc] init];
    
    [super viewDidLoad];
    
    //Aesthetics
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.navigationItem.backBarButtonItem setTarget: self.revealViewController];
        [self.navigationItem.backBarButtonItem setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    animation = [CATransition animation];
    [animation setDuration:0.5];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFromLeft];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    //Data from database
    eventInfos = [SQLDatabase database].eventInfos;
    uniqueIDArray = [[NSMutableArray alloc] init];
    NSLog(@"%@", [[[NSUserDefaults standardUserDefaults] dictionaryRepresentation] allKeys]);
    for(int i = 0; i < [[[[NSUserDefaults standardUserDefaults] dictionaryRepresentation] allKeys] count]; i++){
        
        if ([[[[[NSUserDefaults standardUserDefaults] dictionaryRepresentation] allKeys] objectAtIndex:i] intValue] != 0) {
            [uniqueIDArray addObject:[[[[NSUserDefaults standardUserDefaults] dictionaryRepresentation] allKeys] objectAtIndex:i]];
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//All of this can be derived from the FeedTableView(Same methods, generally the same information.
#pragma mark - Table view data source

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
return 200;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if ([uniqueIDArray count] >=1)
        return [uniqueIDArray count];
    
    
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FeedTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:@"FeedCell"];
    if(cell == nil){
        cell = [[FeedTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FeedCell"];
    }


    
    if([uniqueIDArray count]>= 1){
        
    int uniqueID = (int)[[uniqueIDArray objectAtIndex:indexPath.row] integerValue];
    EventInfo *info = [[EventInfo alloc] init];
    for(EventInfo *tempInfo in eventInfos){
        if (tempInfo.uniqueID == uniqueID) {
            info = tempInfo;
        }
    }
        if(info.uniqueID >= 1){
    cell.titleLabel.text = info.name;
    cell.descriptionLabel.text = info.desc;
    [cell.iconImage sd_setImageWithURL:[NSURL URLWithString:info.imageLink] placeholderImage:[UIImage imageNamed:@"placeholder.jpg"]];
    
    //NSLog(@"%i", info.uniqueID);
    cell.learnMore.tag = info.uniqueID;
    cell.signUp.tag = info.uniqueID;
    [cell.learnMore addTarget:self action:@selector(learnMoreClicked:) forControlEvents:UIControlEventTouchUpInside];
    [cell.signUp addTarget:self action:@selector(signUpClicked:) forControlEvents:UIControlEventTouchUpInside];
    cell.cardView.frame = CGRectMake(10, 5, 300, 190);
    }
        
    }
        else{
    cell.titleLabel.text = @"No found events saved!";
    cell.descriptionLabel.text = @"Please go to the Feed View in order to save an event";
    [cell.iconImage setImage:[UIImage imageNamed:@"placeholder.jpg"]];
        cell.learnMore.hidden = YES;
        cell.signUp.hidden = YES;
        cell.cardView.frame = CGRectMake(0, 0, 320, 300);
    }
    
    
    
    return cell;
}


-(void)learnMoreClicked:(UIButton *)sender{
    
    UIStoryboard *storyboard = [self storyboard];
    UINavigationController *eventViewController = [storyboard instantiateViewControllerWithIdentifier:@"NavControllerEvent"];
    EventViewController *actualViewController = (EventViewController *)eventViewController.topViewController;
    actualViewController.uniqueID = (int)sender.tag;
    
    [animation setSubtype:kCATransitionFromLeft];
    [self.view.window.layer addAnimation:animation forKey:kCATransition];
    [self presentViewController:eventViewController animated:NO completion:nil];
    
    
}

-(void)signUpClicked:(UIButton *)sender{
    EventInfo *neededInfo;
    for (EventInfo *info in eventInfos) {
        if (info.uniqueID == sender.tag) {
            neededInfo = info;
        }
    }
    NSLog(@"%@",[NSNumber numberWithInteger:sender.tag]);
    
    if ([sender.currentTitle isEqual:@"Sign Up"]) {
        [sender setTitle:@"Attending" forState:UIControlStateNormal];
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:sender.tag] forKey:[NSString stringWithFormat:@"%li", (long)sender.tag]];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else{
        [sender setTitle:@"Sign Up" forState:UIControlStateNormal];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:[NSString stringWithFormat:@"%li", (long)sender.tag]];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    //NSLog(@"%lu", [[[NSUserDefaults standardUserDefaults] dictionaryRepresentation]count]);
    NSLog(@"%@", [[[NSUserDefaults standardUserDefaults] dictionaryRepresentation] allKeys]);
}

@end
