//
//  RCRates.h
//  Air21
//
//  Created by Phillip John Ardona on 5/31/12.
//  Copyright (c) 2012 SAS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCModelBase.h"
@interface RCRates : RCModelBase {
    NSArray *activeRate;
    RCVolume activeVol;
    float activeWeight;
    NSString *activePID;
    NSString *activeScale;
    
    float currentMaxWeight;
}

@property(nonatomic, readonly) float currentMaxWeight;

-(float) calculate :(NSString*) packageId weight:(float) weight scale:(NSString*) scale volume:(RCVolume) vol;
-(BOOL)isAllowedWeight:(float) weight package:(NSString*) pid volume:(RCVolume) vol;
-(NSArray*) range:(NSString*) packageId;

@end
