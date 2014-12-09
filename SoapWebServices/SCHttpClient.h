//
//  SCHttpClient.h
//  SoapWebServices
//

//...
@protocol senddataProtocol <NSObject>

-(void)sendDataToA:(NSDictionary *)myStringData;

@end
//...

#import <Foundation/Foundation.h>

typedef void(^SCHttpSuccessBlock)(NSString *soapResults);

@interface SCHttpClient : NSObject<NSURLConnectionDelegate>{
    NSMutableData *soapData;
}
-(void)postRequestWithPhoneNumber:(NSString *)number;

@property(nonatomic,assign)id delegate;

@end

