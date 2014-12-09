//
//  SoapNAL.m
//  SoapWebServices
//


#import "SoapNAL.h"
#define MacthingElement @"return"

static SoapNAL *instance;

@implementation SoapNAL

+(SoapNAL *)shareInstance{
    if (instance==nil) {
        instance=[[self alloc] init];
    }
    return instance;
}

-(void)parserSoapXML:(NSMutableData *)soapData withParserBlock:(SoapNALBlock)block{
    self.soapBlock=block;
    xmlParser=[[NSXMLParser alloc] initWithData:soapData];
    xmlParser.delegate=self;
    [xmlParser parse];
}

#pragma mark -
#pragma mark XML Parser Delegate Methods

// 开始解析一个元素名
-(void) parser:(NSXMLParser *) parser didStartElement:(NSString *) elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *) qName attributes:(NSDictionary *) attributeDict {
    if ([elementName isEqualToString:MacthingElement]) {
        if (!_soapResults) {
            _soapResults = [[NSMutableString alloc] init];
        }
        elementFound = YES;
    }
}

// 追加找到的元素值，一个元素值可能要分几次追加
-(void)parser:(NSXMLParser *) parser foundCharacters:(NSString *)string {
    if (elementFound) {
        [_soapResults appendString: string];
    }
}

// 结束解析这个元素名
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if ([elementName isEqualToString:MacthingElement]) {
        self.soapBlock(_soapResults);
//        NSLog(@"得到的ImageData=%@", _soapResults);
        
        
        
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Result:"
//                                                        message:[NSString stringWithFormat:@"%@", _soapResults]
//                                                       delegate:self
//                                              cancelButtonTitle:@"Ok"
//                                              otherButtonTitles:nil];
//        [alert show];

//        CustomIOS7AlertView *alertView = [[CustomIOS7AlertView alloc] init];
//        
//        UIView *demoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 220)];
//        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 300, 200)];
//        
//        NSString *str = @"data:image/jpeg;base64, ";
//        str = [str stringByAppendingString:_soapResults];
//        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:str]];
//        UIImage *image = [UIImage imageWithData:imageData];
//
//        [imageView setImage:image];
//        [demoView addSubview:imageView];
//        [alertView setContainerView:demoView];
//
//        [alertView show];
        
        
        
        
        
        elementFound = FALSE;
        // 强制放弃解析
        [xmlParser abortParsing];
    }
}

// 解析结束后
- (void)parserDidEndDocument:(NSXMLParser *)parser {
    if (_soapResults) {
        _soapResults = nil;
    }
}

// 出错时，例如强制结束解析
- (void) parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    if (_soapResults) {
        _soapResults = nil;
    }
}

@end
