//
//  NetProxy.h
//  MejijoX
//
//  Created by jopi on 9/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VNotifier.h"
#import "AMFRemotingCall.h"

@interface NetProxy : VNotifier   <AMFRemotingCallDelegate> {
    NSMutableData *_data;
    NSURLConnection *_conn;
    NSString *content;
    
    AMFRemotingCall *_amfCall;
}

@property (nonatomic , readonly)  NSString *content;

-(void) load:(NSString*) url;
-(void) load:(NSString*) url params:(NSObject*) params;
-(void) loadBundleData:(NSString*) url;
-(void) loadDomainData:(NSString *) url;

-(void) post:( NSString *) url  params:(NSDictionary*) params;
-(void) get:(NSString *) url params: (NSDictionary*) params;
-(void) invokeAMF:(NSString *) url className:(NSString*) className action:(NSString*) action params:(NSDictionary*) params;
/* AMF related methods */
-(void) amfStart: (NSString*) gateway remoteService:(NSString*) service ;
-(void) amfSend:( NSString*) method;
-(void) amfSend:( NSString* ) method arguments:(NSMutableDictionary*) args ;

+(NSString*) loadBundleDataNow:(NSString *)url;



@end
