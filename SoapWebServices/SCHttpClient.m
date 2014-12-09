//
//  SCHttpClient.m
//  SoapWebServices
//

#import "SCHttpClient.h"
#import "SCHeader.h"
#import "SoapNAL.h"
#import "XMLReader.h"
@implementation SCHttpClient

//...
@synthesize delegate;
//...

-(void)postRequestWithPhoneNumber:(NSString *)number{
    //创建SOAP信息
    NSString *soapMsg= [NSString stringWithFormat:
                        @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                        "<soap12:Envelope "
                        "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" "
                        "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" "
                        "xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\">"
                        "<soap12:Body>"
                        "<getEntryByName xmlns=\"http://guestbook-soap-vamk.local/soaphandler\">"
                        "<guestName>%@</guestName>"
                        "</getEntryByName>"
                        "</soap12:Body>"
                        "</soap12:Envelope>", number];
    NSLog(@"SOAPMsg==%@",soapMsg);
    //创建URL请求
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:WebServicesURL]];
    NSString *msgLength=[NSString stringWithFormat:@"%lu",(unsigned long)[number length]];
    // 添加请求的详细信息，与请求报文前半部分的各字段对应
    [request addValue:@"application/soap+xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"http://guestbook-soap-vamk.local/soaphandler/getEntryByName" forHTTPHeaderField:@"SOAPAction"];
    [request addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[soapMsg dataUsingEncoding:4]];
    NSURLConnection *connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    if (connection) {
        soapData=[[NSMutableData alloc] init];
    }
}


#pragma mark- 
#pragma mark -NSURLConnectionDelegate


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    [soapData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [soapData appendData:data];
    NSString *theXML = [[NSString alloc] initWithBytes:[soapData mutableBytes]
                                                length:[soapData length]
                                              encoding:4];
    // 打印出得到的XML
    NSLog(@"\n\n得到的XML=%@", theXML);
    
    // Parse the XML into a dictionary
    NSError *parseError = nil;
    NSDictionary* xmlDict = [XMLReader dictionaryForXMLString:theXML error:&parseError];
    
    NSLog(@"\n\nDictionary:%@",xmlDict);
    
//    send data back to ViewController
    [delegate sendDataToA:xmlDict];
    
    // 解析xml
//    [[SoapNAL shareInstance] parserSoapXML:soapData withParserBlock:^(NSString *parserXML) {
//        NSLog(@"\n\nparserXML==%@",parserXML);
//        
//        
//        
//        
//        //send data back to ViewController
////        [delegate sendDataToA:xmlDict];
//        
//    }];
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
}


@end
