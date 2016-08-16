//
//  DataCodec.h
//  MejijoX
//
//  Created by jopi on 9/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DataCodec : NSObject {
    
}

+(NSDictionary*) stringToPList:( NSString* ) xml;
+(id) jsonToObject:( NSString*) json;
+(NSString*) objectToJSONString :(id) obj;
@end
