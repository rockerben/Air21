//
//  Notifier.h
//  MejijoX
//
//  Created by jopi on 9/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface VNotifier : NSObject {
    NSMutableArray *listeners;
}

- (void) addListener: (NSString*) type  withTarget:(id) target andMethod:(NSString*) methodName ;
//- (void) removeListener: (NSString*) type;
-(void) removeListener: (NSString*) type  withTarget:(id) target andMethod :(NSString*) methodName;
-(void) notify:( NSString*) type ;
-(void) informListener:(NSString*) type data:(id) data;
-(void) dispatch:(NSString*) type data:(id) data;
-(void) clean;
@end

