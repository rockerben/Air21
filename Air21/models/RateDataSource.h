//
//  PackagingDataSource.h
//  Air21
//
//  Created by Phillip John Ardona on 5/28/12.
//  Copyright (c) 2012 SAS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RateDataSource : NSObject <UIPickerViewDataSource> {
    NSArray *content;
    int overrideCount;
    int selectedIndex;
}

@property (nonatomic, readonly) NSArray *content;
@property (nonatomic, assign ) int selectedIndex, overrideCount;
-(id) initWithContent:(NSArray*) c ;

@end
