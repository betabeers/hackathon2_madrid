//
//  HttpConnection.h
//  COMB
//
//  Created by DEIMOS on 25/10/11.
//  Copyright (c) 2011 DEIMOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Result.h"

// HTTP headers
#define HTTP_AUTHORIZATION_HEADER       @"Authorization"
#define HTTP_ACCEPT_HEADER              @"Accept"
#define HTTP_CONTENT_TYPE_HEADER        @"Content-Type"
#define HTTP_USER_AGENT_HEADER          @"User-Agent"

// Content types
#define JSON_CONTENT_TYPE               @"application/json"


typedef enum
{
    Get,
    Post,
    Put
} HttpMethod;

@protocol HttpConnectionDelegate;


@interface HttpConnection : NSObject
{   
    id<HttpConnectionDelegate> delegate;
    @private
    NSURLConnection *connection;
    @private
    NSURLResponse *response;
    @private
    NSMutableData *responseData;
  
    NSUInteger tag;
}

@property (nonatomic, assign) id<HttpConnectionDelegate> delegate;
@property (nonatomic, assign) NSUInteger tag;

- (HttpConnection *) initWithDelegate:(id<HttpConnectionDelegate>) delegate;

- (void) requestUrl:(NSString *) url params:(NSDictionary *) params method:(HttpMethod) method content:(NSString *) content headers:(NSDictionary *) headers;

- (BOOL)isConnectedToNework;

- (void)cancel;

@end

@protocol HttpConnectionDelegate

- (void)connection:(HttpConnection*)connection 
   requestFinished:(NSData *) result 
      withEncoding:(NSStringEncoding) encoding;

- (void)connection:(HttpConnection*)connection
     requestFailed:(Result) error;

@end

