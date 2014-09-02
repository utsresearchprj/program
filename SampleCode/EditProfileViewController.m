//
//  EditProfileViewController.m
//  Social Network Privacy Management
//
//  Created by Nga Nguyen on 9/2/14.
//
//

#import "EditProfileViewController.h"

@interface EditProfileViewController ()

@end


static NSString * const kEditProfileURL = @"https://plus.google.com/app/basic/profile/edit";

@implementation EditProfileViewController

@synthesize myWebView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidStartLoad:(UIWebView *)webView
{
    // starting the load, show the activity indicator in the status bar
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)viewDidFinishLoad:(UIWebView *)webView
{
    // finished loading, hide the activity indicator in the status bar
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //trying to support landscape view
    self.view.autoresizesSubviews = YES;
    self.view.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    self.view.frame = [[UIScreen mainScreen] applicationFrame];
    
    CGRect webFrame = [[UIScreen mainScreen] applicationFrame];
    webFrame.origin.y -= 20.0;
    
    self.myWebView.scalesPageToFit = YES;
    self.myWebView.frame = webFrame;
    self.myWebView.autoresizesSubviews = YES;
    self.myWebView.autoresizingMask=(UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);
    
    //load URL
    [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:kEditProfileURL]]];
    
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    if ( self.myWebView.loading ) {
        [self.myWebView stopLoading];
    }
    self.myWebView.delegate = nil;    // disconnect the delegate as the webview is hidden
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    // load error, hide the activity indicator in the status bar
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    // report the error inside the webview
    NSString* errorString = [NSString stringWithFormat:
                             @"<html><center><font size=+5 color='red'>An error occurred:<br>%@</font></center></html>",
                             error.localizedDescription];
    [self.myWebView loadHTMLString:errorString baseURL:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) orientation
{
    return YES;
    
}
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    if(fromInterfaceOrientation == UIInterfaceOrientationPortrait){
        [self.myWebView stringByEvaluatingJavaScriptFromString:@"rotate(0)"];
        
    }
    else{
        [self.myWebView stringByEvaluatingJavaScriptFromString:@"rotate(1)"];
    }
}

@end
