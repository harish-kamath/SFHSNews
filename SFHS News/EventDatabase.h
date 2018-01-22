//
//  EventDatabase.h
//  SFHS News
//
//  Created by Harish Kamath on 12/24/14.
//  Copyright (c) 2014 Harish Kamath. All rights reserved.
//

//   IMPORTANT
//   This class implements sqLite instead of MySQL. It is used nowhere else in the program. It merely
//   serves as a proof of concept. If the app was ever to need local databases(ex. w/o connection), it
//   would be extremely easy to implement, due to this class.
//  The main purpose of sqLite is to hold local databases to promote ease of information control, but does not have a place in this application.

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface EventDatabase : NSObject{

    sqlite3 *_database;
}
+(EventDatabase *)database;
-(NSArray *)clubInfos;
-(NSArray *)eventInfos;


@end
