//
//  RCScale.m
//  Air21
//
//  Created by Phillip John Ardona on 5/31/12.
//  Copyright (c) 2012 SAS. All rights reserved.
//

#import "RCScale.h"

@implementation RCScale 

-(id) init {
    self = [super initWithFile:@"assets/conf/rate_scale.txt"];
    if( self ) {
        
    }
    return self;
}


-(NSString*) from:(NSString *)origin destination:(NSString *)dest {
    //NSLog(@"Scale Origin %@ destination %@" , origin , dest );
    NSString *result = nil;
    for( int i = 0; i <  dataSource.content.count; i++ ) {
        NSDictionary *item = [dataSource.content objectAtIndex:i];
        NSString *_from = [item valueForKey:@"from"];
        NSString *_to = [item valueForKey:@"to"];
      //  NSLog(@"From %@ To %@" , _from , _to );
        if( [_from isEqualToString: origin] && [_to isEqualToString: dest] ) {
            result = [item valueForKey: @"scale"];
        }
        
    }
     
    return result;
}
@end
