//
//  FeedTableViewCell.h
//  SFHS News
//
//  Created by Harish Kamath on 12/23/14.
//  Copyright (c) 2014 Harish Kamath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedTableViewCell : UITableViewCell

@property(nonatomic, retain)IBOutlet UIButton *signUp;
@property(nonatomic, retain)IBOutlet UIButton *learnMore;


@property(nonatomic, weak)IBOutlet UIImageView *iconImage;
@property(nonatomic, weak)IBOutlet UILabel *titleLabel;
@property(nonatomic, weak)IBOutlet UILabel *descriptionLabel;
@property(nonatomic, weak)IBOutlet UIButton *attendingButton;
@property(nonatomic, weak)IBOutlet UIView *cardView;
@property(nonatomic, weak)IBOutlet UILabel *dateLabel;


@end
