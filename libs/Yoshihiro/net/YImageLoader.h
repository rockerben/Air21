//
//  YImageLoader.h
//  VirtualHairstyler
//
//  Created by Phillip John Ardona on 5/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "VNotifier.h"

@interface YImageLoader : VNotifier <NSURLConnectionDelegate> {
    NSURLConnection *connection;
    NSMutableData *_data;
    
    long _loadedbytes;
    long _totalbytes;
    NSString *writePath;
}

-(void) load: (NSString*) url;
-(void) load:(NSString*) url thenWrite:(NSString*) path;
-(NSData*) content;

@end
