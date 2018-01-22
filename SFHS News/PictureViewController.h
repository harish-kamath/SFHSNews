//
//  PictureViewController.h
//  SFHS News
//
//  Created by Harish Kamath on 2/4/15.
//  Copyright (c) 2015 Harish Kamath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PictureViewController : UIViewController

@property(nonatomic, retain)IBOutlet UIImageView *imageView;
@property(nonatomic, retain)IBOutlet UIButton *buttonSource;
@property(nonatomic, weak)NSString *imageLink;

-(IBAction)getSource:(id)sender;
-(IBAction)goBack;

@end
