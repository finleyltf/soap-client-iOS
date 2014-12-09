//
//  SCViewController.h
//  SoapWebServices
//


#import <UIKit/UIKit.h>

@interface SCViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *gsmLabel;

@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;

- (IBAction)pushButtonPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *resultIV;



@end
