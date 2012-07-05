//
//  HttpConnection.m
//  COMB
//
//  Created by DEIMOS on 25/10/11.
//  Copyright (c) 2011 DEIMOS. All rights reserved.
//

#import "HttpConnection.h"
//#import "Reachability.h"

// URL parameters formatters
#define URL_PARAMS_INITIATOR            @"?"
#define URL_PARAMS_KEY_VALUE_SEPARATOR  @"="
#define URL_PARAMS_SEPARATOR            @"&"

// HTTP methods
#define HTTP_GET_METHOD                 @"GET"
#define HTTP_POST_METHOD                @"POST"
#define HTTP_PUT_METHOD                 @"PUT"

// HTTP status
#define HTTP_OK_STATUS                  200
#define HTTP_CREATED_STATUS             201
#define HTTP_UNAUTHORIZED_STATUS        401
#define HTTP_FORBIDDEN_STATUS           403
#define HTTP_NOT_FOUND_STATUS           404


@interface HttpConnection()

@property (nonatomic, assign) NSURLConnection *connection;
@property (nonatomic, assign) NSURLResponse *response;
@property (nonatomic, assign) NSMutableData *responseData;

@end
    
@implementation HttpConnection

@synthesize delegate, connection, response, responseData,tag;

- (void) dealloc
{
    [connection cancel];
    [connection release];
    [response release];
    [responseData release];
	[super dealloc];
}

- (HttpConnection *) initWithDelegate:(id<HttpConnectionDelegate>) httpDelegate
{
    if (self = [super init])
    {
        self.delegate = httpDelegate;
    }
    return self;
}

- (void) requestUrl:(NSString *) url params:(NSDictionary *) params method:(HttpMethod) method content:(NSString *) content headers:(NSDictionary *) headers
{
  
  /*if (![self isConnectedToNework]) {
    [self.delegate connection:self requestFailed:Unreachable];
    return;
  }*/
  if (![UIApplication sharedApplication].isNetworkActivityIndicatorVisible) {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
  }
    // Add params to URL
    NSString *urlWithParams = [NSString stringWithString:url];
    if (params && [params count] > 0)
    {
        urlWithParams = [urlWithParams stringByAppendingString:URL_PARAMS_INITIATOR];
        for (NSString *param in [params keyEnumerator])
        {
            urlWithParams = [urlWithParams stringByAppendingFormat:@"%@%@%@%@", param, URL_PARAMS_KEY_VALUE_SEPARATOR, [params valueForKey:param], URL_PARAMS_SEPARATOR];
        }
        urlWithParams = [urlWithParams substringToIndex:[urlWithParams length] - 1];        
    }
    urlWithParams = [urlWithParams stringByAddingPercentEscapesUsingEncoding:
                     NSASCIIStringEncoding];
  
  NSLog(@"urlwithparams %@",urlWithParams);

    // Create the request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlWithParams]];

    // Set the request HTTP method
    switch (method)
    {
        case Get:
            [request setHTTPMethod:HTTP_GET_METHOD];
            break;
        case Post:
            [request setHTTPMethod:HTTP_POST_METHOD];
            break;
        case Put:
            [request setHTTPMethod:HTTP_PUT_METHOD];
            break;
    }

    // Set the request headers
    if (headers && [headers count] > 0) {
        [request setAllHTTPHeaderFields:headers];
    }

    // Set the body content
	[request setHTTPBody:[content dataUsingEncoding:NSUTF8StringEncoding]];

    // Perform the request
    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if (connection)
    {
        responseData = [[NSMutableData data] retain];
    }
    else
    {
        NSLog(@"Connection cannot be init");
      [self.delegate connection:self requestFailed:Error];
    }
}

- (void)connection:(NSURLConnection *) connection didReceiveResponse:(NSURLResponse *) urlResponse
{
    response = [urlResponse retain];
    [responseData setLength:0];
}

- (void)connection:(NSURLConnection *) connection didReceiveData:(NSData *) data
{
    [responseData appendData:data];
}

- (void)connection:(NSURLConnection *) connection didFailWithError:(NSError *) error
{
  [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
  [self.delegate connection:self requestFailed:Error];
    NSLog(@"Connection failed: %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
  
}

- (void)connectionDidFinishLoading:(NSURLConnection *) connection
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    switch (((NSHTTPURLResponse*) response).statusCode)
    {
        case HTTP_OK_STATUS:
        case HTTP_CREATED_STATUS:
            // Successful request
            [self.delegate connection:self 
                      requestFinished:responseData 
                         withEncoding:[response textEncodingName] != nil ? CFStringConvertEncodingToNSStringEncoding(CFStringConvertIANACharSetNameToEncoding((CFStringRef)[response textEncodingName])) : 0];
    
            break;
        case HTTP_UNAUTHORIZED_STATUS:
        case HTTP_FORBIDDEN_STATUS:
            NSLog(@"HTTP_FORBIDDEN_STATUS");
            break;
        case HTTP_NOT_FOUND_STATUS:
            NSLog(@"HTTP_NOT_FOUND_STATUS");
            break;
        default:
            // Error status
            NSLog(@"status code %d",((NSHTTPURLResponse*) response).statusCode);
            [self.delegate connection:self requestFailed:Error];
            break;
    }
}

/*- (BOOL)isConnectedToNework
// Test if there is connectivity right now.
{ 	
	Reachability *r = [Reachability reachabilityForInternetConnection];	
	NetworkStatus internetStatus = [r currentReachabilityStatus];	
	if ((internetStatus != ReachableViaWiFi) && (internetStatus != ReachableViaWWAN)) 
	{
		return NO;
	}
	return YES;
}*/

- (void)cancel {
  [self.connection cancel];
}

@end
