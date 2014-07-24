//
//  ViewController.m
//  MySafari
//
//  Created by Alejandro Tami on 23/07/14.
//  Copyright (c) 2014 Alejandro Tami. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate, UITextFieldDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *myWebView;
@property (weak, nonatomic) IBOutlet UITextField *myURLTextField;
@property (weak, nonatomic) IBOutlet UIButton *forwardButton;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UINavigationItem *myNavBar;

@property (weak, nonatomic) UIButton *clearButton;
@property (strong, nonatomic) UIActivityIndicatorView *spinner;


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.myWebView.scrollView.delegate = self;
    
    //delegates set via storyboard
    
    [self.myURLTextField setKeyboardType:UIKeyboardTypeURL];
    [self.myURLTextField  setReturnKeyType:UIReturnKeyGo];
    
    [self.forwardButton setEnabled:FALSE];
    [self.backButton setEnabled:FALSE];
    
    //placeholder
    self.clearButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
    self.clearButton.titleLabel.text = @"Clr";
    self.clearButton.frame = CGRectMake(self.myURLTextField.frame.size.width - self.clearButton.frame.size.width - 1.0,
                                       4.0,
                                       self.clearButton.frame.size.width,
                                       self.clearButton.frame.size.height);
    
    [self.clearButton addTarget:self action:@selector(clearUrl) forControlEvents:UIControlEventTouchUpInside];
    
    [self.myURLTextField addSubview:self.clearButton];
    
    
    self.spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:
                                        UIActivityIndicatorViewStyleGray];
    self.spinner.center = self.myWebView.center;
    self.spinner.hidesWhenStopped = YES;
   // self.spinner.hidden = NO;

    [self.view addSubview:self.spinner];
    [self.view bringSubviewToFront:self.spinner];
}


- (void) clearUrl
{
    self.myURLTextField.text = @"";
}


- (void) checkWebPageStateForButtons
{
    
    if ([self.myWebView canGoBack]) {
        [self.backButton setEnabled:TRUE];
    }else{
        [self.backButton setEnabled:FALSE];
    }
    
    if ([self.myWebView canGoForward]) {
        [self.forwardButton setEnabled:TRUE];
    }else{
        [self.forwardButton setEnabled:FALSE];
    }
    
}


// Disgustingly copyed and pasted
- (void) loadUrlString:(NSString *)urlString
{
    
    NSURL *url = nil;
    
    if ([urlString hasPrefix:@"http://"]){
        url = [NSURL URLWithString:urlString];
    }else{
        url = [NSURL URLWithString:[@"http://" stringByAppendingString:urlString]];
    }
    
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [self.myWebView loadRequest:urlRequest];
    [self checkWebPageStateForButtons];
    
}


- (IBAction)plusButtonPressed:(id)sender {
    
    UIAlertView * alertView = [[UIAlertView alloc]init];
    
    alertView.delegate = self;
    alertView.message = @"Coming not that soon!";
    [alertView addButtonWithTitle:@"Lame ass"];
    
    [alertView show];

}

- (IBAction)onReloadButtonPressed:(id)sender
{
    [self.myWebView reload];
    [self checkWebPageStateForButtons];
}

- (IBAction)onStopLoadingButtonPressed:(id)sender
{
    [self.myWebView stopLoading];
    [self checkWebPageStateForButtons];
}

- (IBAction)onForwardButtonPressed:(id)sender
{
    [self.myWebView goForward];
    [self checkWebPageStateForButtons];
}

- (IBAction)onBackButtonPressed:(id)sender
{
    [self.myWebView goBack];
    [self checkWebPageStateForButtons];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.spinner startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
//    self.myURLTextField.text =  [NSString stringWithContentsOfURL: webView.request.URL.absoluteString
//                                                         encoding: NSUTF8StringEncoding
//                                                            error: nil];
    self.myURLTextField.text = webView.request.URL.absoluteString;
    
    self.myNavBar.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    
//    if ([self.myWebView canGoBack]) {
//        [self.backButton setEnabled:TRUE];
//    }else{
//        [self.backButton setEnabled:FALSE];
//    }
//    
//    if ([self.myWebView canGoForward]) {
//        [self.forwardButton setEnabled:TRUE];
//    }else{
//        [self.forwardButton setEnabled:FALSE];
//    }

    [self.spinner stopAnimating];
    
    [self checkWebPageStateForButtons];
    


}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    self.myURLTextField.alpha = 0.5;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    self.myURLTextField.alpha = 1;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
   // [self performSelectorInBackground:@selector(loadUrlString:)withObject:textField.text];
    [self loadUrlString:textField.text];
    [textField resignFirstResponder];
    
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
