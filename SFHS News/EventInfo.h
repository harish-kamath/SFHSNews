//
//  EventInfo.h
//  SFHS News
//
//  Created by Harish Kamath on 12/24/14.
//  Copyright (c) 2014 Harish Kamath. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EventInfo : NSObject{
    int _uniqueID;
    NSString * _date;
    NSString *_name;
    NSString *_desc;
    NSString *_founder;
    NSString *_timeStart;
    NSString *_timeEnd;
    NSString *_address;
    NSString *_club;
    NSString *_results;
    NSString *_extraInfo;

}
@property(nonatomic, assign) int uniqueID;
@property(nonatomic, copy)NSString *date;
@property(nonatomic, copy)NSString *name;
@property(nonatomic, copy)NSString *desc;
@property(nonatomic, copy)NSString *founder;
@property(nonatomic, copy)NSString *timeStart;
@property(nonatomic, copy)NSString *timeEnd;
@property(nonatomic, copy)NSString *address;
@property(nonatomic, copy)NSString *club;
@property(nonatomic, copy)NSString *results;
@property(nonatomic, copy)NSString *imageLink;
@property(nonatomic, copy)NSString *extraInfo;
- (NSInteger)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime;
-(NSString *)dateString;
-(NSDate *)dateFormat;
- (id)initWithUniqueId:(int)uniqueId name:(NSString *)name desc:(NSString *)desc
               founder:(NSString *)founder timeStart:(NSString *)timeStart date:(NSString *)date timeEnd:(NSString *)timeEnd address:(NSString *)address club:(NSString *)club results:(NSString *)results imageLink:(NSString *)imageLink extraInfo:(NSString *)extraInfo;

@end
