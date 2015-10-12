//
//  ViewController.m
//  DORTouchID_objc
//
//  Created by Marcel Starczyk on 08/10/15.
//  Copyright © 2015 Droids on Roids. All rights reserved.
//

// Frameworks
#import <LocalAuthentication/LocalAuthentication.h>

// View Controllers
#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)touchIDButtonTapped:(UIButton *)sender {
    // Require TouchID authentication, otherwise fail
    [self evaluateWithPolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics];
}
- (IBAction)touchIDPasscodeButtonTapped:(id)sender {
    // New policy introduced in iOS 9.0, enter password
    // if TouchID is not available (or fingerprint is not added yet).
    [self evaluateWithPolicy:LAPolicyDeviceOwnerAuthentication];
}

- (void)evaluateWithPolicy:(LAPolicy)policy {
    LAContext *context = [LAContext new];
    NSError *error = nil;
    
    if ([context canEvaluatePolicy:policy error:&error]) {
        /**
         *  Authenticate user
         */
        [context evaluatePolicy:policy
                localizedReason:@"Prove that you're a device owner."
                          reply:^(BOOL success, NSError *error) {
                              if (success) {
                                  [self showAlertWithOkActionWithTitle:@"Success" message:@"This is your device!"];
                              } else {
                                  NSString *errorMessage = error? @"Oops! There was a problem verifying your identity :(" : @"You are not the device owner.";
                                  [self showAlertWithOkActionWithTitle:@"Error" message:errorMessage];
                              }
                          }];
        
    } else {
        [self showAlertWithOkActionWithTitle:@"Error" message:@"Touch ID is not supported on that device"];
    }
}

- (void)showAlertWithOkActionWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDestructive handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

@end