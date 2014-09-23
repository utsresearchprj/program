//
//  AccountViewController.m
//  Social Network Privacy Management
//
//  Created by Nga Nguyen on 8/29/14.
//
//

#import "AccountViewController.h"
#import "MasterViewController.h"
#import "FBAccountSignInViewController.h"


@interface AccountViewController ()

@end

@implementation AccountViewController

@synthesize menuArray;

static const int kNumViewControllers = 2;
static NSString * const kNibNames[kNumViewControllers] = {
    @"FBAccountSignInViewController", @"MasterViewController"};
static NSString * const kMenuOptions[kNumViewControllers] = {
    @"Facebook", @"Google +" };

static NSString * const kStrAbout = @"About";
static NSString * const kAboutNibName = @"AboutViewController";

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
    
    self.menuArray = [NSArray arrayWithObjects:@"Facebook", @"Google +", nil];
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    self.navigationController.toolbarHidden = false;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString* title = nil;
    if (section == 0)
        title =  @"";
    else if (section == 1)
        title = @" ";
    
    return title;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if(section == 0)
        return [self.menuArray count];
    else
        return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    
    //init cell
    static NSString *MyIdentifier = @"MyReuseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:MyIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

    
    if (section == 0) {
    
        cell.textLabel.text = [self.menuArray objectAtIndex:row];
        
        UIImage *theImage = [UIImage imageNamed:@"IconF.png"];
        if (row == 1) {
            theImage = [UIImage imageNamed:@"IconG.png"];
        }
        cell.imageView.image = theImage;
        
    }
    else if(section == 1)
    {
        cell.textLabel.text = kStrAbout;
        
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


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    //[self.navigationController pushViewController:masterViewController animated:YES];
    
    NSInteger section = indexPath.section;
    Class nibClass = nil;
    if (section == 0)
        nibClass = NSClassFromString(kNibNames[indexPath.row]);
    
    else if (section == 1)
        nibClass = NSClassFromString(kAboutNibName);
    
    UIViewController *controller =
    [[nibClass alloc] initWithNibName:nil bundle:nil];
    if (section == 0)
        controller.navigationItem.title = kMenuOptions[indexPath.row];
    
    else if (section == 1)
        controller.navigationItem.title = kStrAbout;
    
    
    [self.navigationController pushViewController:controller animated:YES];

}


@end
