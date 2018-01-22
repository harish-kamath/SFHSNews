//
//  ClubInfo.m
//  SFHS News
//
//  Created by Harish Kamath on 12/29/14.
//  Copyright (c) 2014 Harish Kamath. All rights reserved.
//

#import "ClubInfo.h"

@implementation ClubInfo
@synthesize name = _name, desc = _desc, advisor = _advisor, meeting = _meeting, contact = _contact, events = _events,results = _results, imageLink = _imageLink, uniqueID = _uniqueID, facebook = _facebook, twitter = _twitter;

- (id)initWithUniqueId:(int)uniqueId name:(NSString *)name desc:(NSString *)desc
               advisor:(NSString *)advisor meeting:(NSString *)meeting contact:(NSString *)contact events:(NSString *)events results:(NSString *)results imageLink:(NSString *)imageLink facebook:(NSString *)facebook twitter:(NSString *)twitter{
    if(self = [super init]){
        self.name = name;
        self.desc = desc;
        self.advisor = advisor;
        self.meeting = meeting;
        self.contact = contact;
        self.events = events;
        self.results = results;
        self.imageLink = imageLink;
        self.uniqueID = uniqueId;
        self.facebook = facebook;
        self.twitter = twitter;
    }
    return self;
}

- (void) dealloc {
    self.uniqueID = 0;
    self.name = nil;
    self.desc = nil;
    self.advisor = nil;
    self.meeting = nil;
    self.contact = nil;
    self.events = nil;
    self.results = nil;
    self.imageLink = nil;
    self.facebook = nil;
    self.twitter = nil;
}




@end
