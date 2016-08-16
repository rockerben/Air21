//
//  A21BranchVO.h
//  Air21
//
//  Created by Phillip John Ardona on 6/11/12.
//  Copyright (c) 2012 SAS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"
@interface A21BranchVO : NSObject {
    
    int  cid; 
    
   NSString *air21; 
     NSString *branch; 
    NSString *address1; 
    NSString *address2; 
      NSString *city; 
    NSString *spr; 
    NSString  *zip; 
    NSString *country; 
    NSString *longi; 
     NSString *lati; 
     NSString *manager; 
     NSString *telephone1; 
  NSString *telephone2; 
    NSString *telephone3; 
      NSString *email; 
      NSString *photo; 
  NSString *day1; 
      NSString *hours1; 
     NSString *day2; 
     NSString *hours2; 
     NSString *day3; 
     NSString *hours3; 
     NSString *day4; 
     NSString *hours4; 
 
}

@property(nonatomic, readonly) int cid;
@property(nonatomic, readonly) NSString *air21, *branch, *address1, *address2, *city, *spr, *country, *longi, *lati, *manager, *telephone1, *telephone2, *telephone3, *email, *photo, *day1, *day2, *day3, *day4, *hours1, *hours2, *hours3, *hours4, *zip;


-(id) initWithStatement:(sqlite3_stmt *) stmt ;
 
@end
