//
//  AwarenessViewController.m
//  Social Network Privacy Management
//
//  Created by Nga Nguyen on 9/2/14.
//
//

#import "AwarenessViewController.h"

@interface AwarenessViewController ()

@end

@implementation AwarenessViewController

@synthesize myWebView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //UIWebView *wv = [[UIWebView alloc] init];
    NSURL *htmlFile = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"GoogleAwareness" ofType:@"htm"] isDirectory:NO];
    if(htmlFile)
    {
        //[wv loadRequest:[NSURLRequest requestWithURL:htmlFile]];
        [self.myWebView loadRequest:[NSURLRequest requestWithURL:htmlFile]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
