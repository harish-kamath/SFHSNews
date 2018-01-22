//
//  EventInfo.m
//  SFHS News
//
//  Created by Harish Kamath on 12/24/14.
//  Copyright (c) 2014 Harish Kamath. All rights reserved.
//

#import "EventInfo.h"

@implementation EventInfo
@synthesize name = _name, founder = _founder, desc = _desc, date = _date, timeStart = _timeStart, timeEnd = _timeEnd, address = _address, club = _club, results = _results, imageLink = _imageLink, extraInfo = _extraInfo, uniqueID = _uniqueID;

//Initializes the current object with variables given by parameters, if the parameters exist.
- (id)initWithUniqueId:(int)uniqueId name:(NSString *)name desc:(NSString *)desc
               founder:(NSString *)founder timeStart:(NSString *)timeStart date:(NSString *)date timeEnd:(NSString *)timeEnd address:(NSString *)address club:(NSString *)club results:(NSString *)results imageLink:(NSString *)imageLink extraInfo:(NSString *)extraInfo{
    if(self = [super init]){
        if(name)
        self.name = name;
        if(founder)
        self.founder = founder;
        if(desc)
        self.desc = desc;
        if(date)
        self.date = date;
        if(timeStart)
        self.timeStart = timeStart;
        if(timeEnd)
        self.timeEnd = timeEnd;
        if(address)
        self.address = address;
        if(club)
        self.club = club;
        if(results)
        self.results = results;
        if(imageLink)
        self.imageLink = imageLink;
        if(extraInfo)
        self.extraInfo = extraInfo;
        if(uniqueId)
        self.uniqueID = uniqueId;
    }
    return self;
}

//Converts iOS date into a readable, aesthetic date.
-(NSString *)dateString{
    NSString *datePure = self.date;
    NSString *dateFormatString;
    NSMutableArray *months = [[NSMutableArray alloc] initWithObjects:@"Undefined", @"January", @"February", @"March", @"May", @"June", @"July", @"August", @"September", @"October", @"November", @"December", nil];
    NSArray *dateParts = [datePure componentsSeparatedByString:@"-"];
    NSString *month = [months objectAtIndex:[[dateParts objectAtIndex:1]integerValue] ];
    NSString *day = [dateParts objectAtIndex:2];
    NSString *year = [dateParts objectAtIndex:0];
    dateFormatString = [NSString stringWithFormat:@"%@ %@, %@", month, day, year];
    return  dateFormatString;

}

//Converts date given to by database into a date usable by iOS.
-(NSDate *)dateFormat{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSDate *finalDate = [dateFormatter dateFromString:self.date];
    //NSLog(@"%@ and %@ and %@", [self dateString], finalDate, self.date);
    return finalDate;
}


//Calculates distance between two dates.
- (NSInteger)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime
{
    NSDate *fromDate;
    NSDate *toDate;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&fromDate
                 interval:NULL forDate:fromDateTime];
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&toDate
                 interval:NULL forDate:toDateTime];
    
    NSDateComponents *difference = [calendar components:NSCalendarUnitDay
                                               fromDate:fromDate toDate:toDate options:0];
    //NSLog(@"Day One: %@ Day Two: %@ Day difference: %f",fromDate, toDate,(double)[difference day]);
    return [difference day];
}

//Destroys everything after object is released.
- (void) dealloc {
    self.uniqueID = 0;
    self.name = nil;
    self.date = nil;
    self.founder = nil;
    self.timeStart = nil;
    self.timeEnd = nil;
    self.address = nil;
    self.club = nil;
    self.results = nil;
    self.imageLink = nil;
    self.extraInfo = nil;
}


@end
