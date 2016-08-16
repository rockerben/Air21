//
//  RCRates.m
//  Air21
//
//  Created by Phillip John Ardona on 5/31/12.
//  Copyright (c) 2012 SAS. All rights reserved.
//

#import "RCRates.h"

@interface RCRates() 

-(BOOL) isBigahe:(NSString*) pid;
-(float) calculateRangeFreight:(float) weight packageId:(NSString*) pid scale:(NSString*) scale;
-(float) calculateNonStandard ; 
-(float) calculateNonStandardRangeFreight :  (float) weight packageId:(NSString*) pid scale:(NSString*) scale;
@end

@implementation RCRates
@synthesize currentMaxWeight;
-(id) init {
    self = [super initWithFile:@"assets/conf/rates.txt"];
    if( self ) {
       // NSLog(@"RCRates %d", dataSource.content.count );
    }
    return self;
}

-(NSArray*) range:(NSString *)packageId {
    NSMutableArray *a = [[[NSMutableArray alloc] initWithCapacity:0] autorelease];
    for (int i=0; i < dataSource.content.count;i++ ) {
        NSMutableDictionary *item = [dataSource.content objectAtIndex:i];
        NSString *iPid = [item valueForKey:@"package_id"];
        if( [iPid isEqualToString:packageId]  ) {
            [a addObject:item];
        }
    }
    return a;
}



-(float) calculate:(NSString *)packageId weight:(float)weight scale:(NSString *)scale volume:(RCVolume) vol {
    float result = 0.0;
    activeRate = [[self range: packageId] retain];
    activeVol = vol;
    activeWeight= weight;
    activePID = packageId;
    activeScale = scale;
    
    if( ![self isBigahe:packageId] ) {
        result = [self calculateRangeFreight:weight packageId:packageId scale:scale];
    } else {
    
       result =  [self calculateNonStandard];
    }
    
    [activeRate release];
    activeRate = nil;
    return result;
}

-(float) calculateRangeFreight:(float)weight packageId:(NSString *)pid scale:(NSString *)scale {
    float result = 0.0;
    for( int i = 0; i < activeRate.count ;i++ ) {
        NSDictionary *item = [activeRate objectAtIndex:i];
        NSString *columnName = [NSString stringWithFormat: @"scale_%@", scale];
        float  perKg = [[item valueForKey:@"per_kg"] floatValue];
        if( weight <= perKg ) {
            result = [[item valueForKey: columnName]floatValue];
            break;
        }
        
    }
    //NSLog(@"Weight result %f " , result);
    return result;
}

-(float) calculateNonStandard  {
    [activeRate release];
     activeRate = [[self range: @"3"] retain];
    float r = 0;
    float finalWeight = activeWeight;
    
    /*
     float dimWeight =  activeVol.length * activeVol.width * activeVol.height / 3500;
     
    if( dimWeight > finalWeight ) {
        finalWeight = dimWeight;
    }
     */
    
    
    if( finalWeight <= 20 ) {
        r = [self calculateRangeFreight:finalWeight packageId: activePID scale:activeScale];    
    } else {
        r = [self calculateNonStandardRangeFreight:finalWeight packageId:activePID scale:activeScale];
    }
    
    return r;
}

-(float) calculateNonStandardRangeFreight:(float)weight packageId:(NSString *)pid scale:(NSString *)scale {
    float result = 0.0;
    float rateValue = -1;
    
    for( int i = 40; i < activeRate.count ;i++ ) {
        NSDictionary *item = [activeRate objectAtIndex:i];
        NSString *columnName = [NSString stringWithFormat: @"scale_%@", scale];
        
        NSString *kgStr =[item valueForKey:@"per_kg"];
                          
        NSRange  dashRange = [kgStr rangeOfString:@"-"];
        
        NSLog(@"DashRange  Weight : %f kgStr:[%@] :  %d - %d " , weight, kgStr, dashRange.location , dashRange.length );
        if( dashRange.length == 0 ) {
            //500+
            NSLog(@"caculate package 500+");
            rateValue = [[item valueForKey: columnName]floatValue];
        } else {
            //split
            NSArray *kgs = [kgStr componentsSeparatedByString:@"-"];
            float min = [[kgs objectAtIndex:0] floatValue];
            float max = [[kgs objectAtIndex:1] floatValue];
            if( weight >= min && weight <= max ) {
                NSLog(@"calculating %f of %f - %f ",weight, min, max );
                rateValue = [[item valueForKey: columnName]floatValue]; 
            }
        }
        
        if( rateValue > -1 ) {
            result = weight * rateValue;
            break;
        }
        
        
    }
    return result;
}

-(BOOL) isBigahe:(NSString*) pid {
    if( [pid isEqualToString:@"3"] ) {
        return YES;
    } 
    
    NSDictionary *last = [activeRate objectAtIndex: activeRate.count -1];
    float kg = [[last valueForKey: @"per_kg"] floatValue];
    if( activeWeight > kg ) {
        return YES;
    }
    
    
    return NO;
}


-(BOOL) isAllowedWeight:(float)weight package:(NSString *)pid volume:(RCVolume)vol {
    BOOL result = YES;
    activeRate = [[self range: pid] retain];
    NSDictionary *last = [activeRate objectAtIndex: activeRate.count-1];
    float max = [[last valueForKey:@"per_kg"]floatValue];
    currentMaxWeight = max;
    if( weight > max ) {
        result = NO;
    } 
    [activeRate release];
    return  result;
}

@end
