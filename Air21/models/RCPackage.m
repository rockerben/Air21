//
//  RCPackage.m
//  Air21
//
//  Created by Phillip John Ardona on 5/31/12.
//  Copyright (c) 2012 SAS. All rights reserved.
//

#import "RCPackage.h"
#import "NetProxy.h"
#import "DataCodec.h"
@implementation RCPackage

@synthesize  selectedIndex;

-(id) init {
    self = [super initWithFile: @"assets/conf/package.txt"];
    if ( self ) {
        
        NSLog(@"Package count %d" , dataSource.content.count );
    }
    return self;
}
 
-(NSString*) getSelected {
    NSDictionary *item = [dataSource.content objectAtIndex: selectedIndex];
    return [item valueForKey:@"title"];
}

-(NSString*) packageId {
    NSDictionary *item = [dataSource.content objectAtIndex: selectedIndex];
    return [item valueForKey: @"value"];
}


-(RCVolume) volume {
    NSDictionary *item = [dataSource.content objectAtIndex: selectedIndex];
    float l = [[item valueForKey:@"l"] floatValue];
    float w = [[item valueForKey:@"w"] floatValue];
    float h = [[item valueForKey:@"h"] floatValue];
    RCVolume v = RCVolumeMake( l , w, h );
    return v;
}
 
@end
