//
//  BranchDatabase.h
//  Air21
//
//  Created by Ben Cortez on 4/06/12.
//  Copyright (c) 2012 SAS. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "/usr/include/sqlite3.h"
#import "sqlite3.h"
#import "A21BranchVO.h"
 
@interface BranchDatabase : NSObject {
   sqlite3 *_database;
    NSMutableArray *branches;
    NSMutableArray *locations;
    NSMutableArray *locIndices;
    int cityStartIndex ;
}


@property(nonatomic, readonly) NSMutableArray *locations, *locIndices;
+ (BranchDatabase*)database;
 
-(NSArray*) branchesByCity:(NSString*) cityName;
-(void) resetCityStartIndex;
-(int) searchForIndex:(NSString*) first;

-(A21BranchVO*) branchForSection:(int) section row:(int) row;
 
@end
