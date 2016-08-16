//
//  RCModelBase.m
//  Air21
//
//  Created by Phillip John Ardona on 5/31/12.
//  Copyright (c) 2012 SAS. All rights reserved.
//

#import "RCModelBase.h"
#import "NetProxy.h"
#import "DataCodec.h"



@implementation RCModelBase
@synthesize dataSource;

-(id) initWithFile:(NSString *)path {
    self = [super init];
    if( self ) {
        
       //NSLog(@"Path %@" , path );
        NSString *data = [NetProxy loadBundleDataNow: path ];
       // NSLog(@"Data %@", data );
        NSArray *hash = [DataCodec jsonToObject: data];
        //NSLog(@"Hash %@" , hash );
        dataSource = [[RateDataSource alloc] initWithContent: hash];
      
    }
    return self;
}



-(void) dealloc {
    [dataSource release];
    [super dealloc];
}

@end
