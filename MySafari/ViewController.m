//
//  ViewController.m
//  MySafari
//
//  Created by Alejandro Tami on 23/07/14.
//  Copyright (c) 2014 Alejandro Tami. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *myWebView;
@property (weak, nonatomic) IBOutlet UITextField *myURLTextField;
@property (weak, nonatomic) IBOutlet UIButton *forwardButton;
@property (weak, nonatomic) IBOutlet UIButton *backButton;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //delegates set via storyboard
    
    [self.myURLTextField setKeyboardType:UIKeyboardTypeURL];
    [self.myURLTextField  setReturnKeyType:UIReturnKeyGo];
    
    [self.forwardButton setEnabled:FALSE];
    [self.backButton setEnabled:FALSE];
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

- (IBAction)onReloadButtonPressed:(id)sender
{
    [self.myWebView reload];
}

- (IBAction)onStopLoadingButtonPressed:(id)sender
{
    [self.myWebView stopLoading];
}

- (IBAction)onForwardButtonPressed:(id)sender
{
    [self.myWebView goForward];
}

- (IBAction)onBackButtonPressed:(id)sender
{
    [self.myWebView goBack];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self checkWebPageStateForButtons];
}

// Disgustingly copyed and pasted
- (void) loadUrlString:(NSString *)urlString
{
    
//    NSURL *url = [NSURL URLWithString:[@"http://" stringByAppendingString:urlString]];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [self.myWebView loadRequest:urlRequest];
    [self checkWebPageStateForButtons];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
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
