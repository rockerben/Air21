//
//  RCModelProxy.h
//  Air21
//
//  Created by Phillip John Ardona on 5/31/12.
//  Copyright (c) 2012 SAS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCModelBase.h"
#import "RCLocationVO.h"
#import "RCPackage.h"
#import "RCSubLocation.h"
#import "RCScale.h"
#import "RCRates.h"
@interface RCModelProxy : NSObject {
    RCLocationVO *location;
    RCPackage *package;
    RCSubLocation *subLocation;
    
    RCScale *scale;
    RCRates *rates;
    
    int targetField;
    
    float weight;
    float declaredValue;
    
    float pricePHP;
    float pricePHPVat;
    
    RCVolume packageVolume;
     
}


@property(nonatomic,assign) int targetField;
@property(nonatomic, assign) RCLocationVO *location;
@property(nonatomic, assign) RCPackage *package;
@property(nonatomic, assign) RCSubLocation *subLocation;
@property(nonatomic, assign) RCVolume packageVolume;
@property(nonatomic, readonly) RCRates *rates;
@property(nonatomic, assign) float weight, declaredValue , pricePHP , pricePHPVat;
-(BOOL) calculate;

-(NSObject*) selectDataSource;
-(NSString*) pickerField:(int) index;
-(void) updateSelection:(int) index;
-(int) selected ;
-(BOOL) isAllowedWeight;
-(void)  updatePackageSelection:(int) index;

@end
