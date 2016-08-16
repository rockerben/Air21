//
//  A21BranchVO.m
//  Air21
//
//  Created by Phillip John Ardona on 6/11/12.
//  Copyright (c) 2012 SAS. All rights reserved.
//

#import "A21BranchVO.h"
@interface A21BranchVO()
-(void) testSQL: (sqlite3_stmt*) stmt;
-(int) intColumnValue:(sqlite3_stmt*) statement  column:(int) col ;
-(NSString*) stringColumnValue:(sqlite3_stmt*) statement  column:(int) col;
@end

@implementation A21BranchVO

@synthesize cid, zip;

@synthesize  air21,  branch,  address1,  address2,  city,  spr, country,  longi, lati,  manager,  telephone1,  telephone2,  telephone3,  email, photo,  day1,  day2,  day3,  day4,  hours1, hours2,  hours3,  hours4;


/*
 
 
 
 2012-06-28 15:20:03.005 Air21[3749:207] column:[0][field] ->  Air21 Cebu
 2012-06-28 15:20:03.005 Air21[3749:207] column:[1][Branch] -> Osmena Boulevard (Andre Dominc Business Center)
 2012-06-28 15:20:03.006 Air21[3749:207] column:[2][AddressLine1] -> G/F Causing Building
 2012-06-28 15:20:03.006 Air21[3749:207] column:[3][AddressLine2] -> Osmeña Boulevard
 2012-06-28 15:20:03.007 Air21[3749:207] column:[4][City] -> Cebu City
 2012-06-28 15:20:03.007 Air21[3749:207] column:[5][State] -> Cebu
 2012-06-28 15:20:03.008 Air21[3749:207] column:[6][ZipCode] -> 6000
 2012-06-28 15:20:03.008 Air21[3749:207] column:[7][Country] -> Philippines
 2012-06-28 15:20:03.009 Air21[3749:207] column:[8][Long] -> 123.894933
 2012-06-28 15:20:03.009 Air21[3749:207] column:[9][Lat] -> 10.304195
 2012-06-28 15:20:03.010 Air21[3749:207] column:[10][Manager] -> 
 2012-06-28 15:20:03.010 Air21[3749:207] column:[11][Telephone1] ->  (031) 253 5638
 2012-06-28 15:20:03.011 Air21[3749:207] column:[12][Telephone2] -> 
 2012-06-28 15:20:03.011 Air21[3749:207] column:[13][Telephone3] -> 
 2012-06-28 15:20:03.012 Air21[3749:207] column:[14][EmailAddress] -> 
 2012-06-28 15:20:03.012 Air21[3749:207] column:[15][Photo] -> 
 2012-06-28 15:20:03.013 Air21[3749:207] column:[16][Day] -> 
 2012-06-28 15:20:03.013 Air21[3749:207] column:[17][Hours] -> 
 2012-06-28 15:20:03.014 Air21[3749:207] column:[18][Day2] -> 
 2012-06-28 15:20:03.014 Air21[3749:207] column:[19][Hours2] -> 
 2012-06-28 15:20:03.015 Air21[3749:207] column:[20][Day3] -> 
 2012-06-28 15:20:03.015 Air21[3749:207] column:[21][Hours3] -> 
 2012-06-28 15:20:03.016 Air21[3749:207] column:[22][Day4] -> 
 2012-06-28 15:20:03.016 Air21[3749:207] column:[23][Hours4] -> 
 
 */

-(void) testSQL: (sqlite3_stmt*) stmt {
    int columns =  sqlite3_column_count( stmt );
    
    NSLog(@"column statement %d", columns);
    
    for ( int i =0; i < columns; i++ ) {
        
        const char *ccValue = sqlite3_column_name(   stmt, i);
        
        NSString *colname = [NSString stringWithCString: ccValue encoding: NSUTF8StringEncoding];
         
        const char *columnValue = (const char*) sqlite3_column_text( stmt , i); 
        NSString *colValue = [NSString stringWithCString:  columnValue encoding: NSUTF8StringEncoding];
        
        NSLog(@"column:[%d][%@] -> %@" , i,  colname , colValue);
        
    }
}

-(id) initWithStatement:(sqlite3_stmt *)stmt   {
    self = [super init];
    if( self ) {
       
        
        //new doesn't have cid
        
        
      
        air21 = [[self stringColumnValue:stmt column:0]retain];
        branch = [[self stringColumnValue:stmt column:1]retain];
        address1 = [[self stringColumnValue:stmt column:2]retain];
        address2 = [[self stringColumnValue:stmt column:3]retain];
        city = [[self stringColumnValue:stmt column:4]retain];
        spr = [[self stringColumnValue:stmt column:5]retain];
        zip = [[self stringColumnValue:stmt column:6]retain];
        country = [[self stringColumnValue:stmt column:7]retain];
        longi = [[self stringColumnValue:stmt column:8]retain];
        lati = [[self stringColumnValue:stmt column:9]retain];
        manager = [[self stringColumnValue:stmt column:10]retain];
        telephone1 = [[self stringColumnValue:stmt column:11]retain];
        telephone2 = [[self stringColumnValue:stmt column:12]retain];
        telephone3 =  [[self stringColumnValue:stmt column:13]retain];
        email = [[self stringColumnValue:stmt column:14]retain];
        photo = [[self stringColumnValue:stmt column:15]retain];
        day1 = [[self stringColumnValue:stmt column:16]retain];
        hours1 = [[self stringColumnValue:stmt column:17]retain];
        
        day2 = [[self stringColumnValue:stmt column:18]retain];
        hours2 = [[self stringColumnValue:stmt column:19]retain];
        
        day3 = [[self stringColumnValue:stmt column:20]retain];
        hours3 = [[self stringColumnValue:stmt column:21]retain];
        
        day4 = [[self stringColumnValue:stmt column:22]retain];
        hours4 = [[self stringColumnValue:stmt column:23]retain];
        
        /* //old
        cid = [self intColumnValue:stmt column:0];
        air21 = [self stringColumnValue:stmt column:1];
        branch = [self stringColumnValue:stmt column:2];
        address1 = [self stringColumnValue:stmt column:3];
        address2 = [self stringColumnValue:stmt column:4];
        city = [self stringColumnValue:stmt column:5];
        spr = [self stringColumnValue:stmt column:6];
        zip = [self intColumnValue:stmt column:7];
        country = [self stringColumnValue:stmt column:8];
        longi = [self stringColumnValue:stmt column:9];
        lati = [self stringColumnValue:stmt column:10];
        manager = [self stringColumnValue:stmt column:11];
        telephone1 = [self stringColumnValue:stmt column:12];
        telephone2 = [self stringColumnValue:stmt column:13];
        telephone3 =  [self stringColumnValue:stmt column:14];
        email = [self stringColumnValue:stmt column:15];
        photo = [self stringColumnValue:stmt column:16];
        day1 = [self stringColumnValue:stmt column:17];
        hours1 = [self stringColumnValue:stmt column:18];
        
        day2 = [self stringColumnValue:stmt column:19];
        hours2 = [self stringColumnValue:stmt column:20];
        
        day3 = [self stringColumnValue:stmt column:21];
        hours3 = [self stringColumnValue:stmt column:22];
        
        day4 = [self stringColumnValue:stmt column:23];
        hours4 = [self stringColumnValue:stmt column:24];
        */
        
    }
    return self;
}
 
 


-(int) intColumnValue:(sqlite3_stmt *)statement column:(int)col {
    return sqlite3_column_int(statement, col );
}

-(NSString*) stringColumnValue:(sqlite3_stmt *)statement column:(int)col {
    const char *ccValue = (const char*) sqlite3_column_text(statement, col);
    return   [NSString stringWithCString:ccValue encoding:NSUTF8StringEncoding];
}

-(void) dealloc {
    
    [air21 release];
    [branch release];
    [address1 release];
    [address2 release];
    [city release];
    [spr release];
    [country release];
    [longi release];
    [lati release];
    [manager release];
    [telephone1 release];
    [telephone2 release];
    [telephone3 release];
    [email release];
    [photo release];
    [day1 release];
    [day2 release];
    [day3 release];
    [day4 release];
    [hours1 release];
    [hours2 release];
    [hours3 release];
    [hours4 release];
    
    [super dealloc];
}

@end
