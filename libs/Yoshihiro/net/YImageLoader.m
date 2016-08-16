//
//  YImageLoader.m
//  VirtualHairstyler
//
//  Created by Phillip John Ardona on 5/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "YImageLoader.h"

@interface YImageLoader ()

-(void) reset;
-(void) close;
-(void) write;


@end

@implementation YImageLoader


-(void)reset {
    [self close];
    if( _data != nil ) {
        [_data release];
        _data = nil;
    }
  
    if( writePath != nil ){
        [writePath release];
        writePath = nil;
    }
    
    _data = [[NSMutableData alloc] initWithLength:0];
    [_data setLength:0];
}

-(void) load:(NSString *)url {
    [self reset];
    NSURLRequest *req = [NSURLRequest requestWithURL: [NSURL URLWithString: url]];
    connection = [[NSURLConnection alloc] initWithRequest: req delegate:self startImmediately:YES];
}

-(void) load:(NSString *)url thenWrite:(NSString *)path {
    [self reset];
    writePath = [[NSString alloc] initWithFormat:@"%@" , path];
    NSURLRequest *req = [NSURLRequest requestWithURL: [NSURL URLWithString: url]];
    connection = [[NSURLConnection alloc] initWithRequest: req delegate:self startImmediately:YES];
}


-(void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
}

-(void) connection:(NSURLConnection*) connection didReceiveData:(NSData *)data {
    [_data appendData: data ];
   _loadedbytes = [_data length];
    
    float ratio = (float) _loadedbytes / (float) _totalbytes ;
    
    NSLog(@"Progress loaded: [%ld]  total: [%ld] , rate: %f ", _loadedbytes , _totalbytes ,  ratio );
}

-(void) connection:(NSURLConnection*) connection didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"Image did recv response");
    _totalbytes = response.expectedContentLength;
}

-(void) connectionDidFinishLoading:(NSURLConnection*) connection  {
    //download complete
    NSLog(@"Image download complete ");
    [self close];
    [self write];
    
}

-(void) write {
    if( writePath != nil ) {
        
        //NSString *appPath = [[[NSBundle mainBundle] bundleURL] relativeString];
        NSString *appPath = [[NSBundle mainBundle] resourcePath];
        
        appPath = [NSString stringWithFormat: @"%@/%@" , appPath , writePath ];
        //UIImage *image = [UIImage imageWithData: _data];
        
        NSLog(@"Writing.... path -> %@ " , appPath );
        if(   [_data writeToFile: appPath atomically:NO] ) {
            NSLog(@"Writing image success");
        } else {
            NSLog(@"Writing of Image failed" );
        }
    } else {
        //send complete
    }
}
 
-(void) close {
    if( connection != nil ) {
        [connection release];
        connection = nil;
    }
}

-(NSData*) content {
    return _data;
}

-(void) dealloc{
    [self reset];
    [_data release];
    [super dealloc];
}

@end
