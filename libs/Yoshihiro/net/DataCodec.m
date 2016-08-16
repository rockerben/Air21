//
//  DataCodec.m
//  MejijoX
//
//  Created by jopi on 9/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DataCodec.h"
#import "SBJson.h"

@implementation DataCodec

 
+(NSDictionary*) stringToPList : (NSString*) strXml {
    NSData *content =  [strXml dataUsingEncoding: NSASCIIStringEncoding];
    
    NSString *errorDesc = nil;
    NSPropertyListFormat format;
    
    NSDictionary *dict = (NSDictionary*) [NSPropertyListSerialization propertyListFromData:content mutabilityOption: NSPropertyListMutableContainersAndLeaves format: &format errorDescription:&errorDesc];
    
    return dict;
}

+(id) jsonToObject:( NSString*) json {
    SBJsonParser *parser = [[[SBJsonParser alloc]init] autorelease];
    
    return  [parser objectWithString: json];
}

+(NSString*) objectToJSONString :(id) obj {
    SBJsonWriter *writer = [[[SBJsonWriter alloc] init] autorelease];
    writer.humanReadable = YES;
    return [writer stringWithObject:obj];
}

@end
