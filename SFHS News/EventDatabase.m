//
//  EventDatabase.m
//  SFHS News
//
//  Created by Harish Kamath on 12/24/14.
//  Copyright (c) 2014 Harish Kamath. All rights reserved.
//

#import "EventDatabase.h"
#import "EventInfo.h"
#import "ClubInfo.h"

@implementation EventDatabase

static EventDatabase *_database;

+(EventDatabase *)database{
    if(_database == nil){
        _database = [[EventDatabase alloc] init];
    
    }
    return _database;
}
-(id) init{
    if(self = [super init]){
        NSURL *url = [NSURL URLWithString:@"http://www.sfhsnews.com/SFHSNews.db"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        
        NSString *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory,@"Database.db"];
        [data writeToFile:filePath atomically:YES];
        
        if(sqlite3_open([filePath UTF8String], &_database) != SQLITE_OK){
            NSLog(@"Failed to open database!");
        }
        else{
            NSLog(@"Database Opened!");
        }
    }
    return self;
}

-(NSArray *)eventInfos{
    NSMutableArray *retVals = [[NSMutableArray alloc] init];
    NSString *query = @"SELECT uniqueID, name, desc, founder, date, timeStart, timeEnd, address, club, results, imageLink, extraInfo FROM EventList ORDER BY date, name DESC";
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2(_database,[query UTF8String], -1, &statement, nil) == SQLITE_OK){
       // NSLog(@"%d", ((sqlite3_step(statement)) == SQLITE_ROW));
        while (sqlite3_step(statement) == SQLITE_ROW) {
            int uniqueId = sqlite3_column_int(statement, 0);
            char *nameChars = (char *) sqlite3_column_text(statement, 1);
            char *descChars = (char *) sqlite3_column_text(statement, 2);
            char *founderChars = (char *) sqlite3_column_text(statement, 3);
            char *dateChars = (char *)sqlite3_column_text(statement, 4);
            char *timeStartChars = (char *) sqlite3_column_text(statement, 5);
            char *timeEndChars = (char *) sqlite3_column_text(statement, 6);
            char *addressChars = (char *) sqlite3_column_text(statement, 7);
            char *clubChars = (char *) sqlite3_column_text(statement, 8);
            char *resultsChars = (char *) sqlite3_column_text(statement, 9);
            char *imageLinkChars = (char *) sqlite3_column_text(statement, 10);
            char *extraInfoChars = (char *) sqlite3_column_text(statement, 11);
            
            NSString *name = [[NSString alloc] initWithUTF8String:nameChars];
            NSString *desc = [[NSString alloc] initWithUTF8String:descChars];
            NSString *founder = [[NSString alloc] initWithUTF8String:founderChars];
            NSString *date = [[NSString alloc] initWithUTF8String:dateChars];
            NSString *timeStart = [[NSString alloc] initWithUTF8String:timeStartChars];
            NSString *timeEnd = [[NSString alloc] initWithUTF8String:timeEndChars];
            NSString *address = [[NSString alloc] initWithUTF8String:addressChars];
            NSString *club = [[NSString alloc] initWithUTF8String:clubChars];
            NSString *results = [[NSString alloc] initWithUTF8String:resultsChars];
            NSString *imageLink = [[NSString alloc] initWithUTF8String:imageLinkChars];
            NSString *extraInfo = [[NSString alloc] initWithUTF8String:extraInfoChars];
            EventInfo *info = [[EventInfo alloc] initWithUniqueId:uniqueId name:name desc:desc founder:founder timeStart:timeStart date:date timeEnd:timeEnd address:address club:club results:results imageLink:imageLink extraInfo:extraInfo];
            [retVals addObject:info];
            
        //NSLog(@"%d %@ %@ %@ %d %@ %@ %@ %@ %@ %@", info.uniqueID, info.name, info.desc, info.founder, info.date, info.timeStart, info.timeEnd, info.address, info.club, info.results, info.extraInfo);
        }
        sqlite3_finalize(statement);
    
    }
    else{
        NSLog(@"sqlite can not prepare!");
        NSLog(@"%s", sqlite3_errmsg(_database));
    }
    return  retVals;



}


-(NSArray *)clubInfos{
    NSMutableArray *retVals = [[NSMutableArray alloc] init];
    NSString *query = @"SELECT name, uniqueID, Description, Advisor, Meetings, Contact, Events, Results, Picture FROM Clubs ORDER BY uniqueID DESC";
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2(_database,[query UTF8String], -1, &statement, nil) == SQLITE_OK){
        //NSLog(@"%d", ((sqlite3_step(statement)) == SQLITE_ROW));
        while (sqlite3_step(statement) == SQLITE_ROW) {
            char *nameChars = (char *) sqlite3_column_text(statement, 0);
            int uniqueId = sqlite3_column_int(statement, 1);
            char *descChars = (char *) sqlite3_column_text(statement, 2);
            char *advisorChars = (char *) sqlite3_column_text(statement, 3);
            char *meetingsChars = (char *) sqlite3_column_text(statement, 4);
            char *contactChars = (char *) sqlite3_column_text(statement, 5);
            char *eventsChars = (char *) sqlite3_column_text(statement, 6);
            char *resultsChars = (char *) sqlite3_column_text(statement, 7);
            char *pictureChars = (char *) sqlite3_column_text(statement, 8);
            
            
            NSString *name = [[NSString alloc] initWithUTF8String:nameChars];
            NSString *desc = [[NSString alloc] initWithUTF8String:descChars];
            NSString *advisor = [[NSString alloc] initWithUTF8String:advisorChars];
            NSString *meetings = [[NSString alloc] initWithUTF8String:meetingsChars];
            NSString *contact = [[NSString alloc] initWithUTF8String:contactChars];
            NSString *events = [[NSString alloc] initWithUTF8String:eventsChars];
            NSString *results = [[NSString alloc] initWithUTF8String:resultsChars];
            NSString *imageLink = [[NSString alloc] initWithUTF8String:pictureChars];
            ClubInfo *info = [[ClubInfo alloc] initWithUniqueId:uniqueId name:name desc:desc advisor:advisor meeting:meetings contact:contact events:events results:results imageLink:imageLink facebook:nil twitter:nil];
            [retVals addObject:info];
            
        }
        sqlite3_finalize(statement);
        
    }
    else{
        NSLog(@"sqlite can not prepare!");
        NSLog(@"%s", sqlite3_errmsg(_database));
    }
    return  retVals;



}


-(void) dealloc{
    sqlite3_close(_database);
    
}


@end
