//
//  NetProxy.m
//  MejijoX
//
//  Created by jopi on 9/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NetProxy.h"
#import "DataCodec.h" 


@interface  NetProxy () 
-(void) reset;
-(NSString*) toURLEncodedString: (NSDictionary *) params;
-(void) send: ( NSURLRequest*) request;
  
@end


@implementation NetProxy

@synthesize content;
 
-(void) reset {
    if( _conn != nil ) {
        [_conn release];
        _conn = nil;
    }
    
    if( _data != nil ) {
        [_data release];
        _data = nil;
    }
    
    if( content != nil ) {
        [content release];
    }
}


-(void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error 
{
    NSLog(@"error on load");
    [self notify:@"errorOnLoad"];
    
}

-(void) connectionDidFinishLoading:(NSURLConnection *)connection {
    
  //  content 
    
    content = [[NSString alloc]  initWithBytes: [_data mutableBytes] length: [_data length] encoding: NSUTF8StringEncoding];
    
    //NSLog(@"########## NetProxy.connectionDidFinishLoading content = \"%@\" " , content );
    
     [self notify:@"complete"];
}

-(void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    
    [self notify:@"ready"];
    
    [_data setLength:0]; //initialize data
}

-(void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    NSLog(@"####### NetProxy didRcv Data ");
    [_data appendData: data];
    [self notify:@"progress"];
}


-(void) load:(NSString *)url {
    [self reset];
   // NSLog(@"NetProxy load %@" , url );
    NSURLRequest *req = [NSURLRequest requestWithURL:  [NSURL URLWithString: url] ];
    _data  = [[NSMutableData alloc] initWithLength:0];
    _conn = [[NSURLConnection alloc] initWithRequest: req delegate:self];
}

-(void) load:(NSString *)url params:(NSObject *)params {

}


-(NSString*) toURLEncodedString:(NSDictionary *)params {
    NSString *result = @"";
    
    NSArray *keys = [params allKeys];
         
    for( int i=0 ;  i < [keys count] ; i++ ) {
      NSString *key = [keys objectAtIndex: i];
        if( [result isEqualToString: @""] ) {
            result =  [NSString stringWithFormat: @"%@=%@", key , [params objectForKey: key]]; 
        } else {
            result = [NSString stringWithFormat: @"%@&%@=%@", result ,key , [params objectForKey: key] ];
        }
    }
    return result;
}

-(void) post:(NSString *)url params:(NSDictionary *)params {
    [self reset];
    _data  = [[NSMutableData alloc] initWithLength:0];
    NSString *paramStr = [self toURLEncodedString:  params];
    NSLog(@"#####NetProxy POST: %@ " , paramStr );
    
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL: [NSURL URLWithString: url]];
    [req setHTTPMethod: @"POST"]; 
    [req setHTTPBody: [paramStr  dataUsingEncoding: NSUTF8StringEncoding]];
    [self send:  req ];
}

-(void) get:(NSString *)url params:(NSDictionary *)params {
    [self reset];
    _data  = [[NSMutableData alloc] initWithLength:0];
    
    NSString *paramStr = [self toURLEncodedString:  params];
    NSString *nurl = [NSString stringWithFormat: @"%@?%s", url , [ paramStr UTF8String] ];
    NSLog(@"#####NetProxy. GET %@ " , nurl);

    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL: [NSURL URLWithString: nurl]];
    [req setHTTPMethod: @"GET"]; 
    [self send:  req ];

    
}


-(void) send:(NSURLRequest *)request {
    if( _conn != nil ) {
        [_conn release];
        _conn = nil;
    }
    _conn = [[NSURLConnection alloc] initWithRequest: request delegate:self startImmediately: YES];
}



-(void) invokeAMF:(NSString *)url className:(NSString *)className action:(NSString *)action params:(NSDictionary *)params {
    
}


-(void) loadBundleData:(NSString *)url {
    NSString *path = [[[NSBundle mainBundle] bundleURL] relativeString];
    path = [NSString stringWithFormat: @"%@%@" , path , url ];
    //NSLog(@"Loading from Bundle %@" , path );
    [self load: path];
    
}

 
-(void) loadDomainData:(NSString *) url {
   NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
   NSString *path = [NSString stringWithFormat:@"%@/%@", doc, url];
    path = [path stringByReplacingOccurrencesOfString:@" " withString:@"%20"] ;
    path = [NSString stringWithFormat: @"file://localhost/%@" , path];
    //NSLog(@"Load Domain Data from %@" , path );
   [self load: path]; 
}


+(NSString*) loadBundleDataNow:(NSString *)url {
   /*
    NSString *zpath = [[[NSBundle mainBundle] bundleURL] relativeString];
    NSLog(@"ZPATH %@", zpath );
    NSString *xpath = [[NSBundle mainBundle] pathForResource:@"assets/data/assets-list" ofType: @"txt"];
    NSLog(@"XPATH %@" , xpath );
    */
    
    NSString *path = [[[NSBundle mainBundle ] bundleURL] path];
    path = [NSString stringWithFormat: @"%@/%@" , path , url ]; 
    //path = [path stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
    
    NSError *error = nil;
    
    NSString *value = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error: &error ];
     
    if( error != nil ) {
        
        NSLog(@"\nNetProxy Error loading file %@\n\n" , path );
        NSLog(@"Error %@\n\n" , error );
    }
    
    
    
    return value;
}


/* AMF SECTION */

-(void) amfStart:(NSString *)gateway remoteService:(NSString *)service  {
    if( _amfCall == nil ) {
        NSLog(@"#### NetProxy amfStart:  %@  service: %@ ", gateway , service );
        _amfCall = [[AMFRemotingCall alloc] init];
        _amfCall.service = service;
        _amfCall.URL = [NSURL URLWithString: gateway];
        _amfCall.delegate = self;
         
    }
}

-(void) amfSend:( NSString*) method {
    if( _amfCall != nil ) {
        _amfCall.method = method;
        _amfCall.arguments = nil;
        [_amfCall start];
    }

}

-(void) amfSend:( NSString* ) method arguments:(NSMutableDictionary*) args {
    if( _amfCall != nil ) {
        NSLog(@"#### NetProxy amfSend method: %@ arguments %@", method, args );
        _amfCall.method = method;
        _amfCall.arguments = args;
        [_amfCall start];
    }
}

-(void) remotingCallDidFinishLoading:(AMFRemotingCall *)remotingCall receivedObject:(NSObject *)object {
     
   // NSLog(@"######## NetProxy.remotingCallDidFinishLoading... %@ ",  object  ); 
   // NSLog(@"All Keys: %@" , [object valueForKey: @"allKeys"]);
       
  //  NSLog(@"Styling Step: Test %@" , [object valueForKey: @"stylingStep"] );    
    
     
}

-(void) remotingCall:(AMFRemotingCall *)remotingCall didFailWithError:(NSError *)error {
   //   NSLog(@"######## NetProxy.remotingCall didFailWithError... %@" , error );
}


-(void) clean {
    [super clean];
}
-(void) dealloc 
{
    
    if( _amfCall != nil ) {
        [_amfCall release];
    }
    [self reset];
    [super dealloc];
}

@end
