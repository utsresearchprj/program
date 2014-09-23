//
//  BasicInformationViewController.m
//  Social Network Privacy Management
//
//  Created by Cong Phap Bui on 19/09/2014.
//
//

#import "BasicInformationViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface BasicInformationViewController ()

@end

static const CGFloat cellHeight = 65.0f;

static int numberOfRows = 0;
static int numberOfPages = 1;

static const CGFloat headerHeight = 30;
static const CGFloat footerHeight = 30;

static const CGFloat viewOffsetY = 70;

static int const genderCount = 3;
static NSString* const gender[] = {@"Male", @"Female", @"Custom"};

static int const relationshipCount = 4;
static NSString* const relationship[] = {@"Single", @"Married", @"In relationship", @"In open relationship"};

static int const schoolTypeCount = 3;
static NSString* const schoolType[] = {@"College",@"University",@"High school"};

@implementation BasicInformationViewController
@synthesize fbAccount;
@synthesize dsInfo;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //dsInfo = nibNameOrNil;
        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
        self.fbAccount = delegate.fbAccount;
        self.pageNumber = 0;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //self.view.backgroundColor = [UIColor lightGrayColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    CGFloat tableHeight = numberOfRows*cellHeight + headerHeight + footerHeight;
    if (tableHeight > 380) {
        tableHeight = 380;
    }
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(10, 0 + viewOffsetY, 300, tableHeight) style:UITableViewStylePlain];
    
    table.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    table.layer.borderColor = [UIColor colorWithWhite:0.8 alpha:1].CGColor;
    table.layer.borderWidth = 1;
    table.layer.cornerRadius = 10;
    
    self.dataTable = table;
    
    [self.dataTable setScrollEnabled:YES];
    [self.dataTable setScrollsToTop:NO];
    
    self.dataTable.delegate = self;
    self.dataTable.dataSource=self;
    
    [[self view] addSubview:self.dataTable];

    
    [self registerForKeyboardNotifications];
}

//===============================Keyboard===============================//

- (void)registerForKeyboardNotifications

{
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWasShown:)
     
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWillBeHidden:)
     
                                                 name:UIKeyboardWillHideNotification object:nil];
    
    
    
}

// Called when the UIKeyboardDidShowNotification is sent.

- (void)keyboardWasShown:(NSNotification*)aNotification

{
    
    NSDictionary* info = [aNotification userInfo];
    
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    CGRect viewRect = self.view.frame;
    
    //This height does not need to be add to content Inset
    CGFloat unUsedHeight = viewRect.size.height - viewOffsetY - self.dataTable.frame.size.height;
    
    CGFloat contentInsetsHeight = kbSize.height - unUsedHeight;
    
    CGRect frame = self.dataTable.frame;
    frame.size.height -= contentInsetsHeight;
    
    self.dataTable.frame = frame;
    

}

// Called when the UIKeyboardWillHideNotification is sent

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    
    self.dataTable.contentInset = contentInsets;
    
    self.dataTable.scrollIndicatorInsets = contentInsets;
    
    CGRect frame = self.dataTable.frame;
    frame.size.height = 380;
    
    self.dataTable.frame = frame;
    
}

//===============================UITextField===============================//

- (void)textFieldDidBeginEditing:(UITextField *) textField

{
    self.activeField = textField;
    CGFloat offsetY = CGRectGetMinY(self.activeField.superview.superview.superview.frame);
    offsetY -= 30;
    [self.dataTable setContentOffset:CGPointMake(0.0, offsetY) animated:YES];
    
    if (textField.tag != KeyboardType && textField.tag != DatePickerType)
    {
        [self preparePickerDataForType:textField.tag];
        [self showPicker];
    }
    else if (textField.tag == DatePickerType)
    {
        [self showDatePicker];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField

{
    self.activeField = nil;
    //[self.activeField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

//===============================UITableView===============================//

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    [self.dataTable reloadData];
}

- (CGFloat) tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat result = 20.0f;
    if ([tableView isEqual:self.dataTable]){
        result = cellHeight;
    }
    return result;
    
}

- (CGFloat) tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section{
    
    CGFloat result = 0.0f;
    if ([tableView isEqual:self.dataTable]){
        result = headerHeight;
    }
    return result;
}

- (CGFloat) tableView:(UITableView *)tableView
heightForFooterInSection:(NSInteger)section{
    
    CGFloat result = 0.0f;
    if ([tableView isEqual:self.dataTable]){
        result = footerHeight;
    }
    return result;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, cellHeight*5, tableView.frame.size.width, 30)];
    
    [view setBackgroundColor:[UIColor colorWithWhite:0.8 alpha:1]];
    if (numberOfPages > 1) {
        for (int i=0; i<numberOfPages; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
            [button setTitle:[NSString stringWithFormat:@"%d",i+1] forState:UIControlStateNormal];
            button.frame = CGRectMake(20+(i*30), 0, 50, 30);
            [button addTarget:self action:@selector(goToPage:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:button];
        }
    }
    return view;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 30)];
    /* Create custom view to display section header... */
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 200, 30)];
    [label setFont:[UIFont boldSystemFontOfSize:15]];
    NSString *string;
    if ([dsInfo isEqualToString:@"BI"]) {
        string = @"BASIC INFO";
    }else if ([dsInfo isEqualToString:@"WI"]){
        string = @"WORK HISTORY";
    }else if ([dsInfo isEqualToString:@"EI"]){
        string = @"EDUCATION";
    }

    /* Section header is in 0th index... */
    [label setText:string];
    
    UIButton *edit = [UIButton buttonWithType:UIButtonTypeSystem];
    
    self.editBtn = edit;
    
    [self.editBtn addTarget:self action:@selector(saveData:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.editBtn setTitle:@"Save" forState:UIControlStateNormal];
    self.editBtn.frame = CGRectMake(230, 0, 50, 30);
    
    [view addSubview:label];
    [view addSubview:self.editBtn];
    
    [view setBackgroundColor:[UIColor colorWithWhite:0.8 alpha:1]]; //your background color...
    
    return view;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section{

    if ([tableView isEqual:self.dataTable]){
        return numberOfRows;
    }
    return 0;
}

- (UITableViewCell *) tableView:(UITableView *)tableView
          cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"%@",@"Render cell at a given Index Path Section and Row");
    BasicInformationViewCell *bICell = nil;
    
    if ([tableView isEqual:self.dataTable]){
        
        static NSString *TableViewCellIdentifier = @"BasicInformationViewCell";
        
        //this method dequeues an existing cell if one is available or creates a new one
        //if no cell is available for reuse, this method returns nil
        bICell = [tableView dequeueReusableCellWithIdentifier:TableViewCellIdentifier];
        if (bICell == nil){
            //initialize the cell view from the xib file
            NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"BasicInformationViewCell"
                                                          owner:self options:nil];
            bICell = (BasicInformationViewCell *)[nibs objectAtIndex:0];
        }
        
        NSMutableArray *propList = self.tableDataSource;
        NSMutableArray *inputTypeList = self.inputTypeForTableDataSource;
        
        //populate data from your country object to table view cell
        Property *prop = [propList objectAtIndex:indexPath.row];
        
        bICell.typeLabel.text = [[prop key] capitalizedString];
        bICell.valueLabel.text = [prop value];
        
        NSNumber *tagType = [inputTypeList objectAtIndex:indexPath.row];
        NSInteger tagValue = [tagType intValue];
        bICell.valueLabel.tag = tagValue;
        
        bICell.valueLabel.delegate = self;
        [bICell.valueLabel setReturnKeyType:UIReturnKeyDone];
    }
    return bICell;
}

//======================================ACTION SHEET======================================//
- (void) dismissActionSheet: (id)sender
{
    if (self.activeField.tag == DatePickerType) {
        NSDate *selectedDate = self.datePicker.date;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM/dd/yyyy"];
        self.activeField.text = [dateFormatter stringFromDate:selectedDate];
    }
    UIActionSheet *sheet = (UIActionSheet *)[(UISegmentedControl*)sender superview];
    
    [sheet dismissWithClickedButtonIndex:0 animated:YES];
    [self.activeField resignFirstResponder];
}

- (void)pickerView:(UIPickerView *)pV didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSString *value = [self.pickerViewDataSource objectAtIndex:row];
    self.activeField.text = value;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.pickerViewDataSource count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.pickerViewDataSource objectAtIndex:row];
}


- (void) preparePickerDataForType: (TextFieldInputType) type
{
    NSMutableArray *datasource = [[NSMutableArray alloc] init];
    switch (type) {
        case GenderPickerType:
            for (int i=0; i<genderCount; i++) {
                [datasource addObject:gender[i]];
            }
            self.pickerViewDataSource = datasource;
            break;
        case RelationshipPickerType:
            for (int i=0; i<relationshipCount; i++) {
                [datasource addObject:relationship[i]];
            }
            self.pickerViewDataSource = datasource;
            break;
        case SchoolPickerType:
            for (int i=0; i<schoolTypeCount; i++) {
                [datasource addObject:schoolType[i]];
            }
            self.pickerViewDataSource = datasource;
            break;
        default:
            break;
    }
}

- (void) showPicker
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:nil
                                                    cancelButtonTitle:nil
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:nil];
    
    [actionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];


    
    CGRect pickerFrame = CGRectMake(0, 30, 0, 0);
    
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:pickerFrame];
    pickerView.showsSelectionIndicator = YES;
    pickerView.dataSource = self;
    pickerView.delegate = self;
    
    NSString *value = self.activeField.text;
    NSInteger index = [self.pickerViewDataSource indexOfObject: [value capitalizedString]];
    
    [pickerView selectRow:index inComponent:0 animated:YES];
    
    [actionSheet addSubview:pickerView];
    
    //[pickerView release];
    
    UISegmentedControl *doneButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:@"Done"]];
    doneButton.momentary = YES;
    doneButton.frame = CGRectMake(260, 7.0f, 50.0f, 30.0f);
    doneButton.segmentedControlStyle = UISegmentedControlStyleBar;
    doneButton.tintColor = [UIColor blackColor];
    [doneButton addTarget:self action:@selector(dismissActionSheet:) forControlEvents:UIControlEventValueChanged];
    [actionSheet addSubview:doneButton];
    //[closeButton release];
    
    [actionSheet showInView:[[UIApplication sharedApplication] keyWindow]];
    
    [actionSheet setBounds:CGRectMake(0, 0, 320, 485)];
}

- (void) showDatePicker
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:nil
                                                    cancelButtonTitle:nil
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:nil];
    
    [actionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
    
    
    
    CGRect pickerFrame = CGRectMake(0, 30, 0, 0);
    
    UIDatePicker *pickerView = [[UIDatePicker alloc] initWithFrame:pickerFrame];
    
    NSString *dateString = self.activeField.text;
    if (![dateString isEqualToString:@""]) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];

        @try
        {
            [dateFormatter setDateFormat:@"MM/dd/yyyy"];
            NSDate *dateValue = [dateFormatter dateFromString:dateString];
            [pickerView setDate: dateValue];
        }
        @catch(NSException *ex)
        {
            @try {
                [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                NSDate *dateValue = [dateFormatter dateFromString:dateString];
                [pickerView setDate: dateValue];
            }
            @catch (NSException *exception) {
                [dateFormatter setDateFormat:@"yyyy"];
                NSDate *dateValue = [dateFormatter dateFromString:dateString];
                [pickerView setDate: dateValue];
            }
        }
    }
    
    pickerView.datePickerMode = UIDatePickerModeDate;
    self.datePicker = pickerView;
    
    [actionSheet addSubview:self.datePicker];
    
    //[pickerView release];
    
    UISegmentedControl *doneButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:@"Done"]];
    doneButton.momentary = YES;
    doneButton.frame = CGRectMake(260, 7.0f, 50.0f, 30.0f);
    doneButton.segmentedControlStyle = UISegmentedControlStyleBar;
    doneButton.tintColor = [UIColor blackColor];
    [doneButton addTarget:self action:@selector(dismissActionSheet:) forControlEvents:UIControlEventValueChanged];
    [actionSheet addSubview:doneButton];
    //[closeButton release];
    
    [actionSheet showInView:[[UIApplication sharedApplication] keyWindow]];
    
    [actionSheet setBounds:CGRectMake(0, 0, 320, 485)];
}

- (void) loadDSInfFo:(NSString*) dsInfo_
{
    dsInfo = dsInfo_;
    [self prepareDataSource];
}

- (void) prepareDataSource
{
    
    NSMutableArray *propList;
    NSMutableArray *inputTypeList;
    
    //BasicInfo *info = self.fbAccount.basicInfo;
    if ([dsInfo isEqualToString:@"BI"])
    {
        numberOfPages = 1;
        propList = self.fbAccount.basicInfo.propertyList;
        inputTypeList = self.fbAccount.basicInfo.inputTypeList;
    }else if ([dsInfo isEqualToString:@"WI"])
    {
        numberOfPages = [self.fbAccount.workInfo.propertyList count];
        Property * wiProp = [self.fbAccount.workInfo.propertyList objectAtIndex:self.pageNumber];
        propList = [wiProp value];
        inputTypeList = self.fbAccount.workInfo.inputTypeList;
    }else if ([dsInfo isEqualToString:@"EI"])
    {
        numberOfPages = [self.fbAccount.educationInfo.propertyList count];
        Property * eiProp = [self.fbAccount.educationInfo.propertyList objectAtIndex:self.pageNumber];
        propList = [eiProp value];
        inputTypeList = self.fbAccount.educationInfo.inputTypeList;
    }
    
    self.tableDataSource = propList;
    self.inputTypeForTableDataSource = inputTypeList;
    
    numberOfRows = [self.tableDataSource count];
}

- (void)goToPage:(UIButton*)sender {
    
    NSString *page =[sender titleLabel].text;
    self.pageNumber = [page intValue]-1;
    [self prepareDataSource];
    [self.dataTable reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)saveData:(UIButton*)sender {
    for (int i = 0; i < numberOfRows; i++) {
        BasicInformationViewCell *cell = (BasicInformationViewCell*)[self.dataTable cellForRowAtIndexPath: [NSIndexPath indexPathForRow:i inSection:0]];
        Property * prop = [self.tableDataSource objectAtIndex:i];
        prop.value = cell.valueLabel.text;
    }
}

@end
