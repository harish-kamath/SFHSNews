//
//  PhotoCollectionViewController.m
//  SFHS News
//
//  Created by Harish Kamath on 1/9/15.
//  Copyright (c) 2015 Harish Kamath. All rights reserved.
//

#import "PhotoCollectionViewController.h"
#import "SQLDatabase.h"
#import "EventInfo.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "SWRevealViewController.h"
#import "EventViewController.h"
#import "PictureViewController.h"

@interface PhotoCollectionViewController ()

@end

@implementation PhotoCollectionViewController

static NSString * const reuseIdentifier = @"photoCell";

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
    
    
    //Date from database
    photoArray = [[NSMutableArray alloc] init];
    for (EventInfo *info in [SQLDatabase database].eventInfos) {
        if (info.imageLink.length > 0) {
            [photoArray addObject:info.imageLink];
        }
    }
    
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UICollectionViewDataSource>

//Called whenever a cell is selected
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    UIStoryboard *storyboard = [self storyboard];
    UINavigationController *eventNavController = [storyboard instantiateViewControllerWithIdentifier:@"NavControllerEvent"];
    EventViewController *actualViewController = (EventViewController *)eventNavController.topViewController;
    actualViewController.uniqueID = (int)indexPath.row;
    for(EventInfo *info in [SQLDatabase database].eventInfos){
        if([info.imageLink isEqual:[photoArray objectAtIndex:indexPath.row]]){
            actualViewController.uniqueID = info.uniqueID;
            UIStoryboard *storyboard = [self storyboard];
            UINavigationController *eventViewController = [storyboard instantiateViewControllerWithIdentifier:@"NavControllerPicture"];
            PictureViewController *actualViewController = (PictureViewController *)eventViewController.topViewController;
            actualViewController.imageLink = info.imageLink;
            
            [self presentViewController:eventViewController animated:NO completion:nil];
        }
    }
    [self presentViewController:eventNavController animated:YES completion:nil];
    
}

//Method for how many sections there are(in this case, there are none, so we return the default 1).
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

//Returns how many items there are in each section. Since there is only one section, there is only need to return directly the array which we hold our data in.
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [photoArray count];
}

//Adds content(picture) to each cell.
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView sd_setImageWithURL:[photoArray objectAtIndex:indexPath.row]];
    cell.backgroundView = imageView;
    
    // Configure the cell
    
    return cell;
}

//Defines the size of each cell.
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(80, 80);



}

//Used to go back to the main view.
-(IBAction)goBack{
    [[self navigationController] dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
