//
//  PrivacySettingViewController.m
//  Social Network Privacy Management
//
//  Created by Nga Nguyen on 8/30/14.
//
//

#import "PrivacySettingViewController.h"
#import <GooglePlus/GooglePlus.h>
#import <GoogleOpenSource/GoogleOpenSource.h>
#import "AppDelegate.h"


@interface PrivacySettingViewController ()

@end

static const int kNumSections = 3;
static const int kNumRowsPerBasicInfo = 5;
static const int kNumRowsPerEmployer = 4;
static const int kNumRowsPerSchool = 3;
static NSString * const kSections[kNumSections] = {
    @"BASIC INFORMATION", @"WORKING INFORMATION", @"EDUCATION INFORMATION" };
static NSString * const kRowsOfBasicInfo[kNumRowsPerBasicInfo] = {
    @"DOB", @"Gender", @"Name", @"Relationship",@"Email" };
static NSString * const kRowsPerEmployer[kNumRowsPerEmployer] = {
    @"Employer", @"Start Date", @"End Date", @"Job Title" };
static NSString * const kRowsPerSchool[kNumRowsPerSchool] = {
    @"School", @"Start Date", @"End Date" };
static NSString * const kNibName = @"EditProfileViewController";
static NSString * const kTitleForEditScr = @"Edit Profile";

@implementation PrivacySettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //GTLServicePlus* plusService = [[[GTLServicePlus alloc] init] autorelease];
    
    self.arrayBasicInfo = [[NSMutableArray alloc]init];
    self.arrayWorkingInfo = [[NSMutableArray alloc]init];
    self.arrayEducationInfo = [[NSMutableArray alloc]init];
    self.Me = [[GTLPlusPerson alloc]init];
    
//    GTLServicePlus* plusService = [[GTLServicePlus alloc]init];
//    GTLServicePlus* plusService = [GPPSignIn sharedInstance].plusService;
//    plusService.retryEnabled = YES;
    
//    [plusService setAuthorizer:[GPPSignIn sharedInstance].authentication];
//    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    [plusService setAuthorizer:appDelegate];
//    [plusService setAuthorizer:static_auth];
    
//    GTLQueryPlus *query = [GTLQueryPlus queryForPeopleGetWithUserId:@"me"];
//    
//    [plusService executeQuery:query
//            completionHandler:^(GTLServiceTicket *ticket,
//                                GTLPlusPerson *person,
//                                NSError *error) {
//                if (error) {
//                    GTMLoggerError(@"Error: %@", error);
//                } else {
//                    
//                    self.Me = person;
//                    [self.arrayBasicInfo addObject:(person.birthday)];
//                    [self.arrayBasicInfo addObject:(person.gender)];
//                    [self.arrayBasicInfo addObject:(person.name)];
//                    [self.arrayBasicInfo addObject:(person.relationshipStatus)];
//                    [self.arrayBasicInfo addObject:([person.emails objectAtIndex:0]) ];
//                    
//                    [self.arrayWorkingInfo addObject:([person.organizations objectAtIndex:0])];
//                }
//            }];
    
    
    GTLPlusPerson *person1 = [GPPSignIn sharedInstance].googlePlusUser;
    self.Me = person1;
    if(person1.birthday != nil)
        [self.arrayBasicInfo addObject:(person1.birthday)];
    else
        [self.arrayBasicInfo addObject:@"NA"];
    [self.arrayBasicInfo addObject:(person1.gender)];
    [self.arrayBasicInfo addObject:(person1.displayName)];
    if(person1.relationshipStatus != nil)
        [self.arrayBasicInfo addObject:(person1.relationshipStatus)];
    else
        [self.arrayBasicInfo addObject:@"NA"];
    [self.arrayBasicInfo addObject:([GPPSignIn sharedInstance].authentication.userEmail)];
    
    NSString* orgType = nil;
    GTLPlusPersonOrganizationsItem* tempOrg = [[GTLPlusPersonOrganizationsItem alloc]init];
    for (int i =0; i< person1.organizations.count;i++)
    {
        tempOrg = [person1.organizations objectAtIndex:i];
        orgType = tempOrg.type;
        if ( [orgType isEqualToString:@"work"])
            [self.arrayWorkingInfo addObject:tempOrg];
        else
            [self.arrayEducationInfo addObject:tempOrg];
    }
    
    UIBarButtonItem *editProfile = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editProfileBt)];
    self.navigationItem.rightBarButtonItem = editProfile;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return kNumSections;
}
- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return kSections[section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    switch (section) {
        case 0:
            return kNumRowsPerBasicInfo;
            break;
         
        case 1:
            return ([self.arrayWorkingInfo count]*kNumRowsPerEmployer);
            break;
        case 2:
            return ([self.arrayEducationInfo count]*kNumRowsPerSchool);
            break;
        default:
            return 0;
            break;
    }
    
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    
    static NSString *MyIdentifier = @"MyReuseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1  reuseIdentifier:MyIdentifier];
        //cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    NSString* cellText = nil;
    NSString* cellLabel = nil;
    GTLPlusPersonOrganizationsItem* tempOrg = [[GTLPlusPersonOrganizationsItem alloc]init];
    
    switch (section) {
        case 0:
            cellText = [self.arrayBasicInfo objectAtIndex:row];
            cell.textLabel.text = kRowsOfBasicInfo[row];
            cell.detailTextLabel.text = cellText;
            break;
        case 1:
            tempOrg = [self.arrayWorkingInfo objectAtIndex:(row/kNumRowsPerEmployer)];
            if(row % kNumRowsPerEmployer == 0)
            {
                cellLabel = kRowsPerEmployer[0];
                cellText = tempOrg.name;
            }
            else if(row % kNumRowsPerEmployer == 1)
            {
                cellLabel = kRowsPerEmployer[1];
                cellText = tempOrg.startDate;
            }
            else if(row % kNumRowsPerEmployer == 2)
            {
                cellLabel = kRowsPerEmployer[2];
                cellText = tempOrg.endDate;
            }
            else if(row % kNumRowsPerEmployer == 3)
            {
                cellLabel = kRowsPerEmployer[3];
                cellText = tempOrg.title;
            }

            cell.textLabel.text = cellLabel;
            cell.detailTextLabel.text = cellText;

            break;
        case 2:
            tempOrg = [self.arrayEducationInfo objectAtIndex:(row/kNumRowsPerSchool)];
            if(row % kNumRowsPerSchool == 0)
            {
                cellLabel = kRowsPerSchool[0];
                cellText = tempOrg.name;
            }
            else if(row % kNumRowsPerSchool == 1)
            {
                cellLabel = kRowsPerSchool[1];
                cellText = tempOrg.startDate;
            }
            else if(row % kNumRowsPerSchool == 2)
            {
                cellLabel = kRowsPerSchool[2];
                cellText = tempOrg.endDate;
            }
            
            cell.textLabel.text = cellLabel;
            cell.detailTextLabel.text = cellText;
            break;
    }
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

#pragma mark - Button Delegate


- (IBAction)editProfileBt {
    
    Class nibClass = NSClassFromString(kNibName);
    UIViewController *controller =
    [[nibClass alloc] initWithNibName:nil bundle:nil];
    controller.navigationItem.title = kTitleForEditScr;
    
    [self.navigationController pushViewController:controller animated:YES];
}
@end
