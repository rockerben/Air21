//
//  NotificationEvent.h
//  BrochureS
//
//  Created by jopi on 9/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NotificationEvent : NSObject {
    NSMutableDictionary *hash;
}

-(void) addObject:(id) obj  name:(NSString*) name;
-(id) getObject:(NSString*) name;
@end
