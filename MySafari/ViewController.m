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

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //delegates set via storyboard
    
    [self.myURLTextField setKeyboardType:UIKeyboardTypeURL];
    [self.myURLTextField  setReturnKeyType:UIReturnKeyGo];
	
}


// Disgustingly copyed and pasted
- (void) loadUrlString:(NSString *)urlString
{
    
    NSURL *url = [NSURL URLWithString:[@"http://" stringByAppendingString:urlString]];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [self.myWebView loadRequest:urlRequest];
    
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
