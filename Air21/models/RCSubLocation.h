//
//  RCSubLocation.h
//  Air21
//
//  Created by Phillip John Ardona on 5/31/12.
//  Copyright (c) 2012 SAS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RateDataSource.h"
#import "RCModelBase.h"

@interface RCSubLocation : RCModelBase {
    RateDataSource *origin;
    RateDataSource *destination;
    
    int originIndex;
    int destIndex;
}


@property( nonatomic, readonly) RateDataSource *origin , *destination;
@property(nonatomic, assign) int originIndex,  destIndex;
-(void) selectOrigin:(NSString*) locId;
-(void) selectDestination:(NSString*) locId;

-(NSString*) firstOriginCity;
-(NSString*) firstDestinationCity;

-(NSString*) getSelectedOrigin;
-(NSString*) getSelectedDest;
@end
