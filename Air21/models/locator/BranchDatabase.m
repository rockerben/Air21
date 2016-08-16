//
//  BranchDatabase.m
//  Air21
//
//  Created by Ben Cortez on 4/06/12.
//  Copyright (c) 2012 SAS. All rights reserved.
//
//

#import "BranchDatabase.h"
 
#import "A21BranchVO.h"
#import "DataCodec.h"
#import "NetProxy.h"
@interface  BranchDatabase()  

-(void) retrieveBranches;
-(void) loadLocations;
-(void) initLocationIndices;
@end

@implementation BranchDatabase

@synthesize locations, locIndices;

static BranchDatabase *_instance;

+ (BranchDatabase*)database {
     if (_instance == nil) {
        _instance = [[BranchDatabase alloc] init];
    }
    return _instance;
}

- (id)init {
    if ((self = [super init])) {
        NSString *sqLiteDb = [[NSBundle mainBundle] pathForResource:@"branches" ofType:@"sqlite3"];
         
             
        if (sqlite3_open([sqLiteDb UTF8String], &_database) != SQLITE_OK) {
            NSLog(@"Failed to open database!");
        } else {
          
        }
       
        [self initLocationIndices];
        [self resetCityStartIndex];
        [self loadLocations];
        [self retrieveBranches];
    }
    return self;
}

-(void) initLocationIndices {
    locIndices = [[NSMutableArray alloc] initWithCapacity:26];
    [locIndices addObject:@"A"];
    [locIndices addObject:@"B"];
    [locIndices addObject:@"C"];
    [locIndices addObject:@"D"];
    [locIndices addObject:@"E"];
    
   // [locIndices addObject:@"F"];
    [locIndices addObject:@"G"];
    [locIndices addObject:@"H"];
    [locIndices addObject:@"I"];
   // [locIndices addObject:@"J"];
    
    [locIndices addObject:@"K"];
    [locIndices addObject:@"L"];
    [locIndices addObject:@"M"];
    [locIndices addObject:@"N"];
   // [locIndices addObject:@"O"];
    
    [locIndices addObject:@"P"];
    [locIndices addObject:@"Q"];
    [locIndices addObject:@"R"];
    [locIndices addObject:@"S"];
    [locIndices addObject:@"T"];
    
   // [locIndices addObject:@"U"];
    [locIndices addObject:@"V"];
    [locIndices addObject:@"W"];
  //  [locIndices addObject:@"X"];
   // [locIndices addObject:@"Y"];
    
    [locIndices addObject:@"Z"];
     
    
}

-(void) loadLocations {
    NSString *data = [NetProxy loadBundleDataNow: @"assets/conf/location.txt" ];
   NSArray *hash = [DataCodec jsonToObject: data]; 
    locations = [[NSMutableArray alloc] initWithCapacity:[hash count]];
    for ( int i = 0; i < [hash count] ; i++ ) {
        NSDictionary *item = [hash objectAtIndex:i];
        NSString *loc = [item objectForKey:@"title"];
        [locations addObject: loc];
    }
}
 

-(void) retrieveBranches  {
    
    
   // NSString *sql = @"SELECT * from branch_file ORDER BY air21";
     NSString *sql = @"SELECT * from branches ORDER BY field";
    sqlite3_stmt *statement;
    int prepared = sqlite3_prepare_v2( _database, [sql UTF8String] , -1, &statement, nil );
    if( prepared  == SQLITE_OK ) {
     //   NSLog(@"Squlite prepared?");
        //int  numColumns = sqlite3_column_count( statement );
        branches = [[NSMutableArray alloc] initWithCapacity: 0];
           
        while (  sqlite3_step(statement) == SQLITE_ROW  ) {
            A21BranchVO *branch = [[[A21BranchVO alloc] initWithStatement:statement]autorelease];
           // NSLog(@"%@ | %@ | %@" , branch.city , branch.air21, branch.spr);
            [branches addObject:branch];
        }
        
        sqlite3_finalize( statement );
     
    } else {
        //NSLog(@" SQLITE NOT WORKING");
    }
}
-(void) resetCityStartIndex {
    cityStartIndex = 0;
}
-(NSArray*) branchesByCity:(NSString *)zone {
    
    NSString *dzone = zone;
    if( [zone isEqualToString: @"Makati City" ] ) {
        dzone = [zone substringWithRange: NSMakeRange(0, 6)];
    }
    
    
    NSMutableArray *list = [[[NSMutableArray alloc] initWithCapacity:0] autorelease];
    BOOL matchFound = NO;
    cityStartIndex = 0;
    
 
    for( int i = cityStartIndex; i < [branches count]; i++)  {
        A21BranchVO *branch = [branches objectAtIndex:i];
        NSString *a21 = [NSString stringWithFormat:@"Air21 %@", dzone];
       // NSLog(@"branchesByCity [%@] [%@]", branch.air21 , a21 );
       
        
         
        if( matchFound == YES &&  [branch.air21 isEqualToString: a21] == NO ) {
            //had changed
            cityStartIndex = i;
            break;
        }
        
        if( [branch.air21 isEqualToString: a21]  ) {
           [list addObject: branch];
            matchFound = YES;
        }
        
       
    }
    return list;
    
}


-(int) searchForIndex:(NSString *)first {
    int index = 0;
    for ( int i = 0; i < [locations count] ; i++ ) {
        NSString *title = [locations objectAtIndex:i];
        NSRange  r = NSMakeRange(0, 1);
        NSString *fletter = [title substringWithRange: r];
        if( [fletter isEqualToString: first] ) {
            index = i;
            break;
        }
    }
    return index;
}



-(A21BranchVO*) branchForSection:(int)section row:(int)row {
    NSString *loc = [locations objectAtIndex: section];
    
    if( [loc isEqualToString:@"Makati City"] ) {
      loc = [loc substringWithRange: NSMakeRange(0, 6 )];
    }
    NSArray *cityBranches = [self branchesByCity: loc ];
    return [cityBranches objectAtIndex:row];
}

- (void)dealloc {
    sqlite3_close(_database);
    [branches release];
    [locIndices release];
    [super dealloc];
    
}

 

 
@end