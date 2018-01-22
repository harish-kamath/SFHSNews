//
//  ClubInfo.h
//  SFHS News
//
//  Created by Harish Kamath on 12/29/14.
//  Copyright (c) 2014 Harish Kamath. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClubInfo : NSObject{
    int _uniqueID;
    NSString *_name;
    NSString *_desc;
    NSString *_advisor;
    NSString *_meeting;
    NSString *_contact;
    NSString *_events;
    NSString *_results;
    NSString *_imageLink;
    NSString *_twitter;
    NSString *_facebook;

    
}

@property(nonatomic,assign)int uniqueID;
@property(nonatomic, copy)NSString *name;
@property(nonatomic, copy)NSString *desc;
@property(nonatomic, copy)NSString *advisor;
@property(nonatomic, copy)NSString *meeting;
@property(nonatomic, copy)NSString *contact;
@property(nonatomic, copy)NSString *events;
@property(nonatomic, copy)NSString *results;
@property(nonatomic, copy)NSString *imageLink;
@property(nonatomic, copy)NSString *facebook;
@property(nonatomic, copy)NSString *twitter;

- (id)initWithUniqueId:(int)uniqueId name:(NSString *)name desc:(NSString *)desc
               advisor:(NSString *)advisor meeting:(NSString *)meeting contact:(NSString *)contact events:(NSString *)events results:(NSString *)results imageLink:(NSString *)imageLink facebook:(NSString *)facebook twitter:(NSString *)twitter;

@end
