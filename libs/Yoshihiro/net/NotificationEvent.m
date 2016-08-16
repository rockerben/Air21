//
//  NotificationEvent.m
//  BrochureS
//
//  Created by jopi on 9/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NotificationEvent.h"


@implementation NotificationEvent

-(id) init {
    self = [super init];
    if( self ) {
        hash = [[NSMutableDictionary alloc] initWithCapacity:0];
    }
    
    
    return self;
}

-(void) addObject:(id) obj  name:(NSString*) name {
    if( obj != nil ) {
        [hash setObject:obj forKey: name];
    }
}

-(id) getObject:(NSString *)name {
    return  [hash objectForKey:name];
}

-(void) dealloc {
    [hash release];
    [super dealloc];
}
@end
