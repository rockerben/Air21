//
//  RCModelProxy.m
//  Air21
//
//  Created by Phillip John Ardona on 5/31/12.
//  Copyright (c) 2012 SAS. All rights reserved.
//

#import "RCModelProxy.h"
#import "RateCalculatorViewController.h"


@interface RCModelProxy ()

-(void) initModels;
-(void) doCalculate;
@end

@implementation RCModelProxy
@synthesize targetField , location, package, subLocation , weight, declaredValue , pricePHP, pricePHPVat, packageVolume ,rates;


-(id) init {
    self = [super init];
    if( self ) {
        [self initModels];
    }
     
    return self;
}

-(void) initModels {
    
    weight = 1;
    declaredValue = 1;
    
    location = [[RCLocationVO alloc] init];
    location.originIndex = 44;
    location.destIndex = 21;
    
    
    package = [[RCPackage alloc] init];
    package.selectedIndex = 0;
    
    subLocation = [[RCSubLocation alloc] init];
    subLocation.originIndex = 9;
    subLocation.destIndex = 16;
    
    [subLocation  selectOrigin: @"9"];
    [subLocation selectDestination:@"41"];
    
    
    scale = [[RCScale alloc] init];
    
    rates = [[RCRates alloc]init];
    [self calculate];
    
}
 
-(NSObject*) selectDataSource {
    RateDataSource *data = nil;
    if( targetField == kA21Packaging ) {
        data = package.dataSource;
    } else if (targetField == kA21OriginCity ) {
        data = location.dataSource;
    } else if( targetField == kA21OriginBranch ) {
        data  = subLocation.origin;
    } else if( targetField == kA21ToCity ) {
        data = location.dataSource;
    } else if( targetField == kA21ToBranch ) {
        data = subLocation.destination;
    }
   
    return data;
}

-(NSString*) pickerField:(int)index {
    NSString *fieldName = nil;
    NSDictionary *item = nil; 
    if( targetField == kA21Packaging ) {
        item = [package.dataSource.content objectAtIndex:index];
        fieldName = @"title";
    } else if (targetField == kA21OriginCity ) {
        item = [location.dataSource.content objectAtIndex:index];
        fieldName = @"title";
    } else if( targetField == kA21OriginBranch ) {
        item = [subLocation.origin.content objectAtIndex: index];
        fieldName = @"branch";
    } else if( targetField == kA21ToCity ) {
        item = [location.dataSource.content objectAtIndex:index];
        fieldName = @"title";
    } else if( targetField == kA21ToBranch ) {
        item = [subLocation.destination.content objectAtIndex:index];
        fieldName = @"branch";
    }
    NSString *result = [item valueForKey: fieldName];
    return  result;
}

-(void) updateSelection:(int)index {
    NSDictionary *item = nil; 
    if( targetField == kA21Packaging ) {
        package.selectedIndex = index;
    } else if (targetField == kA21OriginCity ) {
      
        location.originIndex = index;
        
        item = [location.dataSource.content objectAtIndex:index];
        [subLocation selectOrigin: [item valueForKey:@"loc_id"]];
        subLocation.originIndex = 0;
    } else if( targetField == kA21OriginBranch ) {
        subLocation.originIndex = index;
    } else if( targetField == kA21ToCity ) {
        location.destIndex = index;
        subLocation.destIndex = 0;
        item = [location.dataSource.content objectAtIndex:index];
        [subLocation selectDestination: [item valueForKey:@"loc_id"]];
    } else if( targetField == kA21ToBranch ) {
        subLocation.destIndex = index;
    }
}


-(void)  updatePackageSelection:(int) index {
    package.selectedIndex = index;
}
 

-(int) selected {
    int s = -1;
    if( targetField == kA21Packaging ) {
        s = package.selectedIndex;  
    } else if (targetField == kA21OriginCity ) {
        s = location.originIndex;
    } else if( targetField == kA21OriginBranch ) {
        s =  subLocation.originIndex;
    } else if( targetField == kA21ToCity ) {
        s = location.destIndex;
    } else if( targetField == kA21ToBranch ) {
        s = subLocation.destIndex;
    }
    return s;
}

-(BOOL) calculate {
    if( weight > 0 && 
       package.selectedIndex != -1 && 
       location.originIndex != -1 && 
       location.destIndex != -1 &&
       subLocation.originIndex != -1 &&
       subLocation.destIndex != -1 ) {
        [self doCalculate];
        return  YES;  
    }
    return NO;
}


-(void) doCalculate {
    NSString *oZone =  [location zone: location.originIndex];
    NSString *dZone =  [location zone: location.destIndex];
    NSString *pscale =  [scale from: oZone destination:dZone];
    NSString *packageId = [package packageId];
    
    
    
    pricePHP = [rates calculate:packageId weight: weight scale:pscale volume: packageVolume];
    float dvRate =  declaredValue * 0.01;
    
   
    pricePHP  = pricePHP + dvRate;
    pricePHPVat = pricePHP + (pricePHP * .12 );
    //NSLog(@"PricePHP %f with Vat %f ", pricePHP , pricePHPVat );
     
}

-(BOOL) isAllowedWeight {
    return [rates isAllowedWeight: weight package:[package packageId] volume: packageVolume];
}


-(void) dealloc {
    [scale release];
    [location release];
    [package release];
    [subLocation release];
    [super dealloc];
}
@end
