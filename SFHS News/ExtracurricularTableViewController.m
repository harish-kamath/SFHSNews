//
//  ExtracurricularTableViewController.m
//  SFHS News
//
//  Created by Harish Kamath on 12/20/14.
//  Copyright (c) 2014 Harish Kamath. All rights reserved.
//

#import "ExtracurricularTableViewController.h"
#import "ClubInfo.h"
#import "ClubViewController.h"
#import "EventDatabase.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "SQLDatabase.h"
#import "SWRevealViewController.h"

@interface ExtracurricularTableViewController ()

@end

@implementation ExtracurricularTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Initializes content needed for club.
    clubArray = [SQLDatabase database].clubInfos;
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.navigationItem.backBarButtonItem setTarget: self.revealViewController];
        [self.navigationItem.backBarButtonItem setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
//Called when user clicks on a club.
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIStoryboard *storyboard = [self storyboard];
    UINavigationController *clubNavController = [storyboard instantiateViewControllerWithIdentifier:@"clubNavController"];
    ClubViewController *actualViewController = (ClubViewController *)clubNavController.topViewController;
    actualViewController.uniqueID = (int)indexPath.row;
    [self presentViewController:clubNavController animated:YES completion:nil];
}

//Since there is only one section(default), we only return one section.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

//Self-explanatory.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [clubArray count];
}

//Similar to feed cells, this initializes the cell.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ecCell"];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ecCell"];
    }
    [cell.textLabel setFont:[UIFont fontWithName:@"AvenirNext-Bold" size:10.0]];
    ClubInfo *info = [clubArray objectAtIndex:indexPath.row];
    cell.textLabel.text = info.name;
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:info.imageLink] placeholderImage:[UIImage imageNamed:@"placeholder.jpg"]];
    
    
    return cell;
}


@end
