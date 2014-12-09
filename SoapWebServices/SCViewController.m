//
//  SCViewController.m
//  SoapWebServices
//


#import "SCViewController.h"
#import "SCHttpClient.h"
#import "SoapNAL.h"
#import "XMLReader.h"
@interface SCViewController ()

@end

@implementation SCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
//    self.testlabel.text = @"123";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pushButtonPressed:(id)sender {
    SCHttpClient *client=[SCHttpClient new];
    [client postRequestWithPhoneNumber:_phoneNumber.text];
    
    client.delegate = self;
    
    
    
//    NSString *str = @"data:image/jpeg;base64, ";
//    str = [str stringByAppendingString:_soapResults];
//    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:str]];
//    UIImage *image = [UIImage imageWithData:imageData];
    
    
}

-(void)sendDataToA:(NSDictionary *)myStringData
{
    
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Your string Data Showing"
//                                                    message:myStringData
//                                                   delegate:self
//                                          cancelButtonTitle:@"Ok "
//                                          otherButtonTitles:nil];
//    [alert show];

    for (NSString* key in myStringData) {
        id value = [myStringData objectForKey:key];
        if ([key  isEqual: @"env:Envelope"]) {
//            NSLog(@"\n\n 123 456 Value:%@", value);
            for (NSString* key2 in value){
                id value2 = [value objectForKey:key2];
                if ([key2  isEqual: @"env:Body"]){
//                    NSLog(@"\n\n 123 456 Value:%@", value2);
                    for (NSString* key3 in value2){
                        id value3 = [value2 objectForKey:key3];
                        if ([key3  isEqual: @"ns1:getEntryByNameResponse"]){
//                            NSLog(@"\n\n 123 456 Value:%@", value3);
                            for (NSString* key4 in value3){
                                id value4 = [value3 objectForKey:key4];
                                if ([key4  isEqual: @"return"]){
//                                    NSLog(@"\n\n 123 456 Value:%@", value4);
                                    for (NSString* key5 in value4){
                                       id value5 = [value4 objectForKey:key5];
                                        
                                        if ([key5  isEqual: @"guestName"]) {
                                            for (NSString* key6 in value5) {
                                                id value6 = [value5 objectForKey:key6];
                                                if ([key6  isEqual: @"text"]){
                                                    self.nameLabel.text = value6;
                                                }
                                            }
                                        }
                                        if ([key5  isEqual: @"image"]) {
                                            for (NSString* key7 in value5){
                                                id value7 = [value5 objectForKey:key7];
                                                if ([key7  isEqual: @"text"]){
                                                    // value 7 为base64data
                                                        NSData* imageData = [[NSData alloc] initWithBase64EncodedString:value7 options:0];
                                                            UIImage *image = [UIImage imageWithData:imageData];
                                                        [self.resultIV setImage:image];
                                                }
                                            }
                                        }
                                        if ([key5  isEqual: @"phoneNumber"]) {
                                            for (NSString* key8 in value5){
                                                id value8 = [value5 objectForKey:key8];
                                                if ([key8  isEqual: @"text"]){
                                                    self.gsmLabel.text = value8;
                                                }
                                            }
                                            
//
                                        }
                                        
                                        
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        
        
    }
    
//    NSData* imageData = [[NSData alloc] initWithBase64EncodedString:myStringData options:0];
//    
//        UIImage *image = [UIImage imageWithData:imageData];
//    [self.resultIV setImage:image];

    
    


}


@end
