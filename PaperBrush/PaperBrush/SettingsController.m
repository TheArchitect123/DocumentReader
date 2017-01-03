//
//  SettingsController.m
//  PaperBrush
//
//  Created by Dan Gerchcovich on 29/12/16.
//  Copyright © 2016 Alpha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreFoundation/CoreFoundation.h>
#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <MessageUI/MessageUI.h>
#import "AppDelegate.h"
#import "SettingsController.h"

@interface SettingsController()

@property(nonatomic, strong) UIView* mainView;
@property(nonatomic, strong, readwrite) AppDelegate* appDelegate;
@end

@implementation SettingsController

@synthesize appDelegate = _appDelegate;
//settings functions
//about alert

-(void)aboutPress:(NSString *)title message:(NSString *) message {
    UIAlertController* aboutAlert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction* confirmed = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^ (UIAlertAction* action) {
        //release resources
    
    }];
    
    [aboutAlert addAction:confirmed];
    
    if(self.presentedViewController == nil) {
        [self presentViewController:aboutAlert animated:true completion:^(void) {
            printf("Presenting instructions");
        }];
    }
    else {
        [self.presentedViewController dismissViewControllerAnimated:true completion:^(void) {
            [self presentViewController:aboutAlert animated:true completion:^(void) {
                printf("Presenting instructions controller");
            }];
        }];
    }
}

//share alert
-(void)shareAlert:(NSString *)title message:(NSString *)message {
    NSArray* array = [[NSArray alloc] initWithObjects:@"Check out 'PaintBrush' By Dan Gerchcovich. Available on the App Store", nil];
    
    UIActivityViewController* activity = [[UIActivityViewController alloc] initWithActivityItems:array applicationActivities:nil];
    
    if(self.presentedViewController == nil) {
        [self presentViewController:activity animated:true completion:^(void) {
            printf("Presenting sharing controller");
        }];
    }
    else {
        [self.presentedViewController dismissViewControllerAnimated:true completion:^(void) {
            [self presentViewController:activity animated:true completion:nil];
        }];
    }
}

-(void)speechVoice:(NSString*) title {
    AVSpeechSynthesizer* speechSynth = [AVSpeechSynthesizer alloc];
    
    AVSpeechUtterance* speechutter = [[AVSpeechUtterance alloc] initWithString:title];
    
    speechutter.rate = AVSpeechUtteranceMaximumSpeechRate /2.5f;
    speechutter.voice = AVSpeechSynthesisVoiceIdentifierAlex;
    speechutter.volume = 1.0f;
    speechutter.pitchMultiplier = 1.0f;
    
    [speechSynth speakUtterance:speechutter];
}

//send feedback
-(void)sendFeedback:(NSString* ) title message:(NSString *)message {
    UIAlertController* feedbackController = [UIAlertController alertControllerWithTitle:title message: message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *confirmed = [UIAlertAction actionWithTitle:@"Send Feedback" style:UIAlertActionStyleDefault handler:^(UIAlertAction* action) {
        MFMailComposeViewController* feedbackMail = [MFMailComposeViewController alloc];
        [feedbackMail setToRecipients:@"dan.developer789@gmail.com"];
        
        if([MFMailComposeViewController canSendMail] == true) {
            //present mail controller and
            if(self.presentedViewController == nil) {
                [self presentViewController:feedbackMail animated:true completion:^(void){
                    [self speechVoice:@"Send me feedback. I'll appreciate it"];
                }];
            }
        }
        else {
            printf("Cannot open mail controller");
        }
    }];
    
    UIAlertAction* denied = [UIAlertAction actionWithTitle:@"Never Mind" style:UIAlertActionStyleCancel handler:^(UIAlertAction* action) {
        printf("I wanted to dispose of the alert controller. But automatic reference counting takes care of that for me. :)");
    }];
    
    [feedbackController addAction:confirmed];
    [feedbackController addAction:denied];
    
    if(self.presentedViewController == nil) {
        [self presentViewController:feedbackController animated:true completion:^(void) {
            printf("Presenting feedback controller");
        }];
    }
    else {
        [self.presentedViewController dismissViewControllerAnimated:true completion:^(void) {
            printf("Presenting feedback controller");
        }];
    }
}

//send reports
-(void)sendReports:(NSString *) title message:(NSString *)message {
    UIAlertController* reportController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* confirmed = [UIAlertAction actionWithTitle:@"Send error Report" style:UIAlertActionStyleDefault handler:^(UIAlertAction* action) {
        MFMailComposeViewController* mailError = [MFMailComposeViewController alloc];
        [mailError setToRecipients:@"dan.developer789@gmail.com"];
        
        if([MFMailComposeViewController canSendMail] == true) {
            if(self.presentedViewController == nil) {
                [self presentViewController:mailError animated:true completion:^(void){
                    [self speechVoice:@"Any problems? Tell me about them. So I may address them immediately"];
                }];
            }
            else {
                [self.presentedViewController dismissViewControllerAnimated:true completion:^(void) {
                    [self presentViewController:reportController animated:true completion:^(void) {
                        [self speechVoice:@"Any problems? Tell me about them. So I may address them immediately"];
                    }];
                }];
            }
        }
        else {
            printf("Cannot present mail controller ");
        }
    }];
    
    UIAlertAction* denied = [UIAlertAction actionWithTitle:@"Never Mind" style:UIAlertActionStyleDestructive handler:^(UIAlertAction* action) {
        
    }];
    
    [reportController addAction:confirmed];
    [reportController addAction:denied];
    
    if(self.presentedViewController == nil) {
        [self presentViewController:reportController animated:true completion:^(void) {
            printf("Presenting report controller");
        }];
    }
    else {
        [self.presentedViewController dismissViewControllerAnimated:true completion:^(void){
            [self presentViewController:reportController animated:true completion:^(void) {
                printf("Presenting report controller");
            }];
        }];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* tableCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"SettingsCell"];
    
    NSArray* settingsList = [[NSArray alloc] initWithObjects:@"             About PaperBrush",@"             Share PaperBrush",@"             Send Feedback",@"             Report an issue", nil];
    
    tableCell.textLabel.text = settingsList[indexPath.row];
    tableCell.textLabel.textColor = [UIColor blackColor];
    
    tableCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return tableCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0: //about controller
            [self aboutPress:@"About PaperBrush" message:@"Welcome to PaperBrush. This application empowers you to make art ranging from the simple to the extreme. Have fun"];
            break;
        
        case 1: //share controller
            [self shareAlert:@"" message:@"Tell all your friends about PaperBrush!"];
            break;
            
            
        case 2: //send feedback controlller
            [self sendFeedback:@"Any suggestions?" message:@"If you have any suggestions for potential improvements, then email me"];
            break;
            
        default:    //report controller
            [self sendReports:@"Any problems?" message:@"Email me and I will address them as soon as possible"];
            break;
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}


-(void)viewWillLayoutSubviews {
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        if([[UIDevice currentDevice] orientation] == UIDeviceOrientationPortrait || [[UIDevice currentDevice] orientation] == UIDeviceOrientationPortraitUpsideDown) {
            
            [self.mainView  setFrame:CGRectMake(0, 321, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
        }
        else if([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeLeft || [[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeRight) {
            
            [self.mainView  setFrame:CGRectMake(0, 321, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
        }
    }
}

-(void)viewDidLoad {
    UIImage* about = [UIImage imageNamed:@"About.png"];
    UIImage* share = [UIImage imageNamed:@"Share.png"];
    UIImage* reportIssure = [UIImage imageNamed:@"Feedback_2nd.png"];
    UIImage* sendFeedback = [UIImage imageNamed:@"Fix.png"];
    
    
    UIImageView* aboutImage = [[UIImageView alloc] initWithImage:about];
    aboutImage.frame = CGRectMake(10.0f, 14.5f, 50, 50);
    aboutImage.contentMode = UIViewContentModeScaleAspectFit;
    
    
    UIImageView* shareImage = [[UIImageView alloc] initWithImage:share];
    shareImage.frame = CGRectMake(7.0f, 88.5f, 60, 60);
    shareImage.contentMode = UIViewContentModeScaleAspectFit;
    
    
    UIImageView* reportImage = [[UIImageView alloc] initWithImage:reportIssure];
    reportImage.frame = CGRectMake(7.0f, 172.5f, 60, 60);
    reportImage.contentMode = UIViewContentModeScaleAspectFit;
    
    
    UIImageView* sendImage = [[UIImageView alloc] initWithImage:sendFeedback];
    sendImage.frame = CGRectMake(7.0f, 250.5f, 60, 60);
    sendImage.contentMode = UIViewContentModeScaleAspectFit;
    
    self.tableView.separatorColor = [UIColor groupTableViewBackgroundColor];
    
    //is user using an iPhone
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        self.tableView.rowHeight = 80.0f;
    }
    //is user using an iPad
    else {
         self.tableView.rowHeight = 120.0f;
    }
    
    [self.tableView addSubview:aboutImage];
    [self.tableView addSubview:shareImage];
    [self.tableView addSubview:reportImage];
    [self.tableView addSubview:sendImage];
    
    
    UIView* mainGrey = [[UIView alloc] initWithFrame: CGRectMake(0, 0,0,0)];
    
    mainGrey.backgroundColor = [UIColor groupTableViewBackgroundColor];
    

    
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        if([[UIApplication sharedApplication] isStatusBarHidden] == false) {
            printf("Portrait");
           
            [mainGrey setFrame:CGRectMake(0, 321, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
            self.mainView = mainGrey;
        }
        else {
            printf("Landscape");
            [mainGrey setFrame:CGRectMake(0, 321, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
            self.mainView = mainGrey;
        }
    }
    
    self.appDelegate.backgroundView = mainGrey;
    
    [self.tableView addSubview:self.mainView];
    
    self.navigationItem.title = @"Settings";
}

@end
