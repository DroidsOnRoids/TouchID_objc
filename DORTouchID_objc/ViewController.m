//
//  ViewController.m
//  DORTouchID_objc
//
//  Created by Marcel Starczyk on 08/10/15.
//  Copyright © 2015 Coding Lion Studio. All rights reserved.
//

// View Controllers
#import "ViewController.h"

// Frameworks
#import <LocalAuthentication/LocalAuthentication.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)touchIDButtonTapped:(UIButton *)sender {
    LAContext *context = [[LAContext alloc] init];
    
    NSError *error = nil;
    
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        /**
         *  AUthenticate user
         */
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
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
                                  [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDestructive handler:nil]];
                                  [self presentViewController:alert animated:YES completion:nil];
                              } else {
                                  UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                                                 message:@"You are not the device owner."
                                                                                          preferredStyle:UIAlertControllerStyleAlert];
                                  [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDestructive handler:nil]];
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
