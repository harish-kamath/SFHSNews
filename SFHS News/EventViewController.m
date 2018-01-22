//
//  EventViewController.m
//  SFHS News
//
//  Created by Harish Kamath on 12/26/14.
//  Copyright (c) 2014 Harish Kamath. All rights reserved.
//

#import "EventViewController.h"
#import "EventInfo.h"
#import "EventDatabase.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "AgendaTableViewController.h"
#import "SQLDatabase.h"
#import <QuartzCore/QuartzCore.h>

@interface EventViewController ()

@end

@implementation EventViewController
@synthesize uniqueID, clubImage, clubLabel, titleLabel, mainImage, dateLabel, addressLabel, timeLabel, descLabel, extraInfoLabel, resultsLabel, scrollView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //Gathers information from database
    eventInfos = [SQLDatabase database].eventInfos;
    //NSLog(@"The current event showing has an ID of:%i", uniqueID);
        for(EventInfo *infoTemp in eventInfos){
    if(infoTemp.uniqueID == uniqueID)
        indexOfInfo = (int)[eventInfos indexOfObject:infoTemp];
    
    }
    
    //Calls method and therefore creates and organizes all data needed for view.
    [self fillData];
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
    scrollView.contentSize = CGSizeMake(320, titleLabel.frame.size.height +mainImage.frame.size.height +addressLabel.frame.size.height + descLabel.frame.size.height +extraInfoLabel.frame.size.height +resultsLabel.frame.size.height + 30);
    
}

//A method used to efficiently(minimal lag) blur the image, so that it can serve as a sufficient background.
- (UIImage *)blurWithCoreImage:(UIImage *)sourceImage
{
    CIImage *inputImage = [CIImage imageWithCGImage:sourceImage.CGImage];
    
    // Apply Affine-Clamp filter to stretch the image so that it does not
    // look shrunken when gaussian blur is applied
    CGAffineTransform transform = CGAffineTransformIdentity;
    CIFilter *clampFilter = [CIFilter filterWithName:@"CIAffineClamp"];
    [clampFilter setValue:inputImage forKey:@"inputImage"];
    [clampFilter setValue:[NSValue valueWithBytes:&transform objCType:@encode(CGAffineTransform)] forKey:@"inputTransform"];
    
    // Apply gaussian blur filter with radius of 30
    CIFilter *gaussianBlurFilter = [CIFilter filterWithName: @"CIGaussianBlur"];
    [gaussianBlurFilter setValue:clampFilter.outputImage forKey: @"inputImage"];
    [gaussianBlurFilter setValue:@5 forKey:@"inputRadius"];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef cgImage = [context createCGImage:gaussianBlurFilter.outputImage fromRect:[inputImage extent]];
    
    // Set up output context.
    UIGraphicsBeginImageContext(self.view.frame.size);
    CGContextRef outputContext = UIGraphicsGetCurrentContext();
    
    // Invert image coordinates
    CGContextScaleCTM(outputContext, 1.0, -1.0);
    CGContextTranslateCTM(outputContext, 0, -self.view.frame.size.height);
    
    // Draw base image.
    CGContextDrawImage(outputContext, self.view.frame, cgImage);
    
    // Apply white tint
    CGContextSaveGState(outputContext);
    CGContextSetFillColorWithColor(outputContext, [UIColor colorWithWhite:1 alpha:0.2].CGColor);
    CGContextFillRect(outputContext, self.view.frame);
    CGContextRestoreGState(outputContext);
    
    // Output image is ready.
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return outputImage;
}

//Adds data to the view.
-(void)fillData{
    info = [eventInfos objectAtIndex:indexOfInfo];
    clubLabel.text = info.club;
    clubLabel.adjustsFontSizeToFitWidth = YES;
    titleLabel.text = info.name;
    titleLabel.adjustsFontSizeToFitWidth = YES;
    [mainImage sd_setImageWithURL:[NSURL URLWithString:info.imageLink] placeholderImage:[UIImage imageNamed:@"placeholder.jpg"]];
    mainImage.image = [self blurWithCoreImage:mainImage.image];
    dateLabel.text = [info dateString];
    dateLabel.adjustsFontSizeToFitWidth = YES;
    timeLabel.text = [NSString stringWithFormat:@"%@ - %@", info.timeStart, info.timeEnd];
    timeLabel.adjustsFontSizeToFitWidth = YES;
    addressLabel.text = info.address;
    addressLabel.adjustsFontSizeToFitWidth = YES;
    [descLabel setText:info.desc];
    [descLabel sizeToFit];
    [extraInfoLabel setText:info.extraInfo];
    [extraInfoLabel sizeToFit];
    [resultsLabel setText:info.results];
    [resultsLabel sizeToFit];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Used to go back to previous view.
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
