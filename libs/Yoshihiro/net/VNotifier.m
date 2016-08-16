//
//  Notifier.m
//  Quartz1
//
//  Created by jopi on 8/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "VNotifier.h"

#import "NotificationEvent.h"
@implementation VNotifier


-(id) init {
    self = [super init];
   
    if( self) {
 
        listeners = [[NSMutableArray alloc] initWithCapacity:1];
    }
    return self;
}


-(void) addListener:(NSString *)type withTarget:(id)target andMethod: (NSString*) methodName {
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:2];
    [dic setObject: target forKey: @"target"];
    [dic setObject: methodName forKey: @"method"];
    [dic setObject:type forKey:@"type"];
    
    //[listeners setObject:(id) dic forKey: type ];
    [listeners addObject: dic]; 
    [dic release];
   
}

-(void) removeListener: (NSString*) type  withTarget:(id) target andMethod :(NSString*) methodName{
    
    for( int i=0; i < [listeners count] ; i++ ) {
        NSDictionary *dic = [listeners objectAtIndex:i];
        
        NSString *dtype = [dic objectForKey:@"type"];
        id  dtarget  = [dic objectForKey:@"target"];
        NSString *dmethod = [dic objectForKey:@"method"];
        
        if( [dtype isEqualToString: type]  && [dmethod isEqualToString: methodName]  && [target isEqual: dtarget] ){
     
            [listeners removeObject:dic];
            
        }
    }
    
    
}

-(void) notify:(NSString *)type {
    
    //NSLog(@"firing %@", self );
    for( int i=0; i < [listeners count] ; i++ ) {
        NSDictionary *dic = [listeners objectAtIndex:i];
        NSString *dtype = [dic objectForKey:@"type"];
        
        if( [dtype isEqualToString: type ] ) {
            NSString *methodName = [dic objectForKey:@"method"];

            //NSLog(@"fire [%@] method[%@]\n\n" , type , methodName ); 
  
            id target  = [dic objectForKey:@"target"];
            
            SEL  method = (SEL) NSSelectorFromString( methodName );
            
            [target performSelector: method];
          
            
        }
    }
    
       
}

-(void) dispatch:(NSString *)type data:(id)data {
    [self informListener: type data:data];
}

-(void) informListener:(NSString *)type data:(id)data {
    for( int i=0; i < [listeners count] ; i++ ) {
        NSDictionary *dic = [listeners objectAtIndex:i];
        NSString *dtype = [dic objectForKey:@"type"];
        
        if( [dtype isEqualToString: type ] ) {
            
            id target  = [dic objectForKey:@"target"];
            NSString *methodName = [dic objectForKey:@"method"];
            
            SEL  method = (SEL) NSSelectorFromString( methodName );
             
            //[target performSelector: method];
            
            NotificationEvent *event = [[[NotificationEvent alloc] init] autorelease];
            [event addObject: type name:@"type"];
            [event addObject: self name:@"source"];
            [event addObject: data name:@"data"];
            
            [target performSelector: method withObject: event];
            
        }
    }
}

-(void) clean  {
    //NSLog(@"notifier clean");
    if( listeners !=  nil ) {
        while ( [listeners count ] > 0 ) {
            NSMutableDictionary *hashref = [listeners objectAtIndex:0];
            [hashref removeObjectForKey:@"target"];
            [hashref removeObjectForKey:@"type"];
            [hashref removeObjectForKey:@"method"];
            [listeners removeObjectAtIndex:0];
        }
        [listeners release];
        listeners = nil;
    }
}

-(void) dealloc {
   
    if( listeners !=  nil ) {
        while ( [listeners count ] > 0 ) {
            [listeners removeObjectAtIndex:0];
        }
        [listeners release];
    }
    //NSLog(@"Notifer dealloc %@ ", self );
    [super dealloc];
}
@end
