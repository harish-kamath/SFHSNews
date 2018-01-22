//
//  ViewController.h
//  SFHS News
//
//  Created by Harish Kamath on 12/20/14.
//  Copyright (c) 2014 Harish Kamath. All rights reserved.
//
//This class is the first view that you see on the screen. It implements a scrollView(which scrolls horizontally instead of vertically, and includes a pageControl(3 dots) which controls which page is currently being shown). It also holds the three social media icons, a small introduction to the app, the school logo, and the sidebar menu button.

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIScrollViewDelegate>{
    //Animation used to transfer between classes
    CATransition *animation;
    
    //Boolean representing bannerView usage.
    BOOL pageControlBeingUsed;
    
    //Arrays holding information gathered from database, or timers which will automatically go off at specific intervals.
    NSMutableArray *array;
    NSTimer *timerArray;
    NSTimer *timerViews;
    BOOL arraysReady;
    
    //The "loading circle" that indicates database connection.
    UIActivityIndicatorView *activityIndicator;
}

//These are aesthetic global variables that a user can see on his screen. Their names are self-explanatory: annNameLabel is used to define the label of the current "ann"ouncement on the banner.
@property(nonatomic, retain)IBOutlet UIImageView *sofoLogo;
@property(nonatomic, retain)IBOutlet UIPageControl *pageViewer;
@property(nonatomic, strong)UIDynamicAnimator*animator;
@property(nonatomic, retain)IBOutlet UIButton *facebookButton;
@property(nonatomic, retain)IBOutlet UIButton *twitterButton;
@property(nonatomic, retain)IBOutlet UIButton *instagramButton;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *awardsLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UILabel *annNameLabel;

//Method used to change bannerView screen.
-(IBAction)changePage;

@end

