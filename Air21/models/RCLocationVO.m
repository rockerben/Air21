//
//  RCLocationVO.m
//  Air21
//
//  Created by Phillip John Ardona on 5/31/12.
//  Copyright (c) 2012 SAS. All rights reserved.
//

#import "RCLocationVO.h"
#import "NetProxy.h"
#import "DataCodec.h"

@interface RCLocationVO() 

 
@end

@implementation RCLocationVO

@synthesize  originIndex, destIndex;
 
 
-(id) init  {
    self = [super initWithFile: @"assets/conf/location.txt"];
    if( self )  {
        
    }
    return self;
}
 

-(NSString*) zone:(int)index {
  NSMutableDictionary *obj = [dataSource.content objectAtIndex: index];
  return [obj valueForKey:@"zone"];
}


-(NSString*) locId:(int)index {
    NSMutableDictionary *obj = [dataSource.content objectAtIndex: index];
    return [obj valueForKey:@"value"];  
}

-(int) locIndex:(NSString *)locId {
    for( int i=0; i < dataSource.content.count;i++ ) {
        NSDictionary *item = [dataSource.content objectAtIndex:i];
        if( [[item valueForKey:@"loc_id"] isEqualToString: locId] ) {
            return  i;
        }
    }
    return -1;
}


-(NSString*) title:(int)index {
    NSMutableDictionary *obj = [dataSource.content objectAtIndex: index];
    return [obj valueForKey:@"title"];  
}

-(NSString*) getSelectedOrigin {
    NSDictionary *item = [  dataSource.content objectAtIndex: originIndex];
    return [item valueForKey:@"title"];
}

-(NSString*) getSelectedDest {
    NSDictionary *item = [dataSource.content objectAtIndex: destIndex ];
    return [item valueForKey:@"title"];
}

-(void) dealloc {
    [dataSource release];
    [super dealloc];
}
@end
