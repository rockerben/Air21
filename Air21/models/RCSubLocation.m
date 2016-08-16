//
//  RCSubLocation.m
//  Air21
//
//  Created by Phillip John Ardona on 5/31/12.
//  Copyright (c) 2012 SAS. All rights reserved.
//

#import "RCSubLocation.h"

@implementation RCSubLocation

@synthesize origin , destination , originIndex, destIndex;

-(id) init {
    self = [super initWithFile: @"assets/conf/sub_location.txt"];
    if( self ) {
       
    }
    return self;
}

-(void) selectOrigin: (NSString *)locId {
    if( origin != nil ) {
        [origin release];
        origin = nil;
    }
    NSMutableArray *sourceContent = [[[NSMutableArray alloc]initWithCapacity:0] autorelease];
    for ( int i = 0 ; i < dataSource.content.count; i++ ) {
        NSDictionary *item = [dataSource.content objectAtIndex:i];
        NSString *loc_id = [item valueForKey:@"loc_id"];
        if( [loc_id isEqualToString: locId] ) {
            [sourceContent addObject: item];
        }
    }
    
    origin = [[RateDataSource alloc] initWithContent: sourceContent];
    
   
}






-(void) selectDestination:(NSString *)locId {
    if( destination != nil ) {
        [destination release];
        destination = nil;
    }
    NSMutableArray *sourceContent = [[[NSMutableArray alloc]initWithCapacity:0] autorelease];
    for ( int i = 0 ; i < dataSource.content.count; i++ ) {
        NSDictionary *item = [dataSource.content objectAtIndex:i];
        NSString *loc_id = [item valueForKey:@"loc_id"];
        if( [loc_id isEqualToString: locId] ) {
            [sourceContent addObject: item];
        }
    }
    destination = [[RateDataSource alloc] initWithContent: sourceContent];

}

-(NSString*) firstOriginCity {
    if( origin.content == nil || origin.content.count <= 0 ) {
        return nil;
    }
    
    NSDictionary *item = [origin.content objectAtIndex:0];
    return [item valueForKey:@"branch"];
}

-(NSString*) firstDestinationCity {
    if(  destination.content == nil || destination.content.count <= 0 ) {
        return nil;
    }
    NSDictionary *item = [destination.content objectAtIndex:0];
    return [item valueForKey:@"branch"];
}



-(NSString*) getSelectedOrigin {
    NSDictionary *item = [origin.content objectAtIndex: originIndex];
    return [item valueForKey:@"branch"];
}

-(NSString*) getSelectedDest {
    NSDictionary *item = [destination.content objectAtIndex: destIndex ];
    return [item valueForKey:@"branch"];
}


-(void) dealloc{
    [destination release];
    [origin release];
    [super dealloc];
}
@end
