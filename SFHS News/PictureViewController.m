//
//  PictureViewController.m
//  SFHS News
//
//  Created by Harish Kamath on 2/4/15.
//  Copyright (c) 2015 Harish Kamath. All rights reserved.
//

#import "PictureViewController.h"
#import "SDWebImage/UIImageView+WebCache.h"

@interface PictureViewController ()

@end

@implementation PictureViewController
@synthesize imageView, buttonSource, imageLink;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Adds image to view
    [imageView sd_setImageWithURL:[NSURL URLWithString:imageLink]];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Opens image in Safari with source.
-(IBAction)getSource:(id)sender{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:imageLink]];
}

//Goes back to previous view(used for "Done" button)
-(IBAction)goBack{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
