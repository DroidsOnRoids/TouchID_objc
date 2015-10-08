//
//  ViewController.m
//  DORTouchID_objc
//
//  Created by Marcel Starczyk on 08/10/15.
//  Copyright © 2015 Coding Lion Studio. All rights reserved.
//

#import "ViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)touchIDButtonTapped:(UIButton *)sender {
    [self evaluateWithPolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics];
}
- (IBAction)touchIDPasscodeButtonTapped:(id)sender {
    [self evaluateWithPolicy:LAPolicyDeviceOwnerAuthentication];
}

- (void)evaluateWithPolicy:(LAPolicy)policy {
    LAContext *context = [[LAContext alloc] init];
    
    NSError *error = nil;
    
    if ([context canEvaluatePolicy:policy error:&error]) {
        /**
         *  AUthenticate user
         */
        [context evaluatePolicy:policy
                localizedReason:@"Prove that you're a device owner."
                          reply:^(BOOL success, NSError *error) {
                              
                              if (error) {
                                  UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                                                 message:@"Oops! There was a problem verifying your identity :("
                                                                                          preferredStyle:UIAlertControllerStyleAlert];
                                  [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDestructive handler:nil]];
                                  [self presentViewController:alert animated:YES completion:nil];
                                  return;
                              }
                              
                              if (success) {
                                  UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Success"
                                                                                                 message:@"This is your device!"
                                                                                          preferredStyle:UIAlertControllerStyleAlert];
                                  [self presentViewController:alert animated:YES completion:nil];
                              } else {
                                  UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                                                 message:@"You are not the device owner."
                                                                                          preferredStyle:UIAlertControllerStyleAlert];
                                  [self presentViewController:alert animated:YES completion:nil];
                              }
                              
                          }];
        
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                       message:@"Touch ID is not supported on that device"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDestructive handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

@end
