//
//  RCModelBase.h
//  Air21
//
//  Created by Phillip John Ardona on 5/31/12.
//  Copyright (c) 2012 SAS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RateDataSource.h"

struct RCVolume {
    float length;
    float width;
    float height;
};
typedef struct RCVolume RCVolume;

static inline RCVolume RCVolumeMake(float length, float width, float height);
static inline RCVolume RCVolumeMake ( float length, float width, float height ) {
    RCVolume v; 
    v.length = length ; v.width = width ; v.height = height; 
    return v;
}



@interface RCModelBase : NSObject  {
    RateDataSource *dataSource;
}

@property(nonatomic, readonly)  RateDataSource *dataSource;
-(id) initWithFile:(NSString*) path;
@end
