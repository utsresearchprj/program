//
//  FBViewController.m
//  Social Network Privacy Management
//
//  Created by Nga Nguyen on 9/1/14.
//
//

#import "FBViewController.h"
#import <GooglePlus/GooglePlus.h>

static const int kFBNumViewControllers = 2;
static NSString * const kFBMenuOptions[kFBNumViewControllers] = {
    @"Sign in", @"Privacy Setting" };

static NSString * const kFBUnselectableMenuOptions[kFBNumViewControllers] = {
    nil, @"Privacy Setting" };
static NSString * const kFBNibNames[kFBNumViewControllers] = {
    @"FBSignInViewController",@"FBPrivacySettingViewController"};

@interface FBViewController ()

@end

@implementation FBViewController

- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Social Network Privacy Management";
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return kFBNumViewControllers;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL selectable = [self isSelectable:indexPath];
    NSString * const kCellIdentifier = selectable ? @"Cell" : @"GreyCell";
    UITableViewCell *cell =
    [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    if (cell == nil) {
        cell =
        [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                               reuseIdentifier:kCellIdentifier];
        if (selectable) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } else {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.textColor = [UIColor lightGrayColor];
        }
    }
    cell.textLabel.text = (selectable ? kFBMenuOptions : kFBUnselectableMenuOptions)
    [indexPath.row];
    cell.accessibilityLabel = cell.textLabel.text;
    
    UIImage *theImage = [UIImage imageNamed:@"signin.png"];
    if (indexPath.row == 1) {
        theImage = [UIImage imageNamed:@"privacy.png"];
    }
    cell.imageView.image = theImage;
    
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


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    if (![self isSelectable:indexPath]) {
        return;
    }
    Class nibClass = NSClassFromString(kFBNibNames[indexPath.row]);
    UIViewController *controller =
    [[nibClass alloc] initWithNibName:nil bundle:nil];
    controller.navigationItem.title = kFBMenuOptions[indexPath.row];
    
    [self.navigationController pushViewController:controller animated:YES];
}


#pragma mark - Helper methods

- (BOOL)isSelectable:(NSIndexPath *)indexPath {
    if (kFBUnselectableMenuOptions[indexPath.row]) {
        // To use Google+ app activities, you need to sign in.
        return [GPPSignIn sharedInstance].authentication != nil;
    }
    return YES;
}

@end
