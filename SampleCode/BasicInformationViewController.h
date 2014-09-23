//
//  BasicInformationViewController.h
//  Social Network Privacy Management
//
//  Created by Cong Phap Bui on 19/09/2014.
//
//

#import <UIKit/UIKit.h>
#import "BasicInformationViewCell.h"
#import "FBAccount.h"
#import "AppDelegate.h"
@interface BasicInformationViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong,nonatomic) UITextField *activeField;

@property (strong,nonatomic) UIButton *editBtn;

@property (strong,nonatomic) UIDatePicker *datePicker;

@property (strong,nonatomic) NSMutableArray *pickerViewDataSource;

@property (strong, nonatomic) UITableView *dataTable;

@property (strong,nonatomic) FBAccount *fbAccount;

@property (strong,nonatomic) NSString *dsInfo;

@property (assign,nonatomic) NSInteger pageNumber;

@property (strong,nonatomic) NSMutableArray *tableDataSource;

@property (strong,nonatomic) NSMutableArray *inputTypeForTableDataSource;

- (void) loadDSInfFo:(NSString*) dsInfo_;
@end
