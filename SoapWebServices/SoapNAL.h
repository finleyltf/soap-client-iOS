//
//  SoapNAL.h
//  SoapWebServices
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CustomIOS7AlertView.h"

typedef void (^SoapNALBlock) (NSMutableString *parserXML);
@interface SoapNAL : NSObject<NSXMLParserDelegate>{
    NSXMLParser *xmlParser;
    BOOL elementFound;
}
@property(nonatomic,strong)SoapNALBlock soapBlock;
@property(nonatomic,strong)NSMutableString *soapResults;
+(SoapNAL *)shareInstance;
-(void)parserSoapXML:(NSMutableData *)soapData withParserBlock:(SoapNALBlock)block;
@end
