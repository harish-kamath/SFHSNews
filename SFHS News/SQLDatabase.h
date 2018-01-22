//
//  SQLDatabase.h
//  SFHS News
//
//  Created by Harish Kamath on 1/4/15.
//  Copyright (c) 2015 Harish Kamath. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SQLDatabase : NSObject{
    //Different collections that we will receive from the database.
    NSDictionary *_database;
    NSMutableArray *dictArrayEvents;
    NSMutableArray *dictArrayClubs;
}

//Creates static method that forms the database.
+(SQLDatabase *)database;

//An array of EventInfo class objects; this array is what holds all of the information gathered from the event.
-(NSArray *)eventInfos;

//Similar to eventInfos, but for clubs.
-(NSArray *)clubInfos;

//A global boolean that notifies any class whether there was an error during database connections.
@property(nonatomic)BOOL errorBool;

//Method used to clear the dictionary of any null strings, and instead replace them with empty strings.
-(NSDictionary *)nullFreeDictionaryWithDictionary:(NSDictionary *)dictionary;
@end
