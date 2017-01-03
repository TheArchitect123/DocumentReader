//
//  ListOfOtherAppsController.m
//  PaperBrush
//
//  Created by Dan Gerchcovich on 29/12/16.
//  Copyright © 2016 Alpha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreFoundation/CoreFoundation.h>
#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>
#import <AudioToolbox/AudioToolbox.h>

#import "ListOfOtherAppsController.h" 

@interface ListOfOtherAppsController()

@property(nonatomic, strong, readwrite) NSArray* cells;

@end

@implementation ListOfOtherAppsController

@synthesize cells = _cells;

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cells.count;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* appCells = [tableView dequeueReusableCellWithIdentifier:@"ImageCell"];
    
    if(appCells == nil) {
        appCells = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ImageCell"];
    }
    
    appCells.textLabel.text = self.cells[indexPath.row];
    appCells.textLabel.textColor = [UIColor blackColor];

    appCells.textLabel.font = [UIFont systemFontOfSize:18.0f weight:22.0f];
    
    appCells.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    return appCells;
    
}

-(void) errorLoadingAppStore:(NSString* )title message:(NSString*)message {
    UIAlertController* alertError = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* openSettings = [UIAlertAction actionWithTitle:@"" style:UIAlertActionStyleDefault handler:^(UIAlertAction* action){
        //open settings controller
    }];
    
    UIAlertAction* confirmed = [UIAlertAction actionWithTitle:@"Maybe Later" style:UIAlertActionStyleDestructive handler:nil];
    
    [alertError addAction:openSettings];
    [alertError addAction:confirmed];
    
    if(self.presentedViewController == nil) {
        [self presentViewController:alertError animated:true completion:^(void) {
           //play Audio Services 4095: Vibrator Sound
        }];
    }
    else {
        [self.presentedViewController dismissViewControllerAnimated:true completion:^(void) {
            [self presentViewController:alertError animated:true completion:^(void) {
                //play Audio Services 4095: Vibrator Sound
            }];
        }];
    }

}

-(void)appStoreLink:(NSString*)title message:(NSString*)message URL:(NSURL* )url {
    UIAlertController* appStoreController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* confirmed = [UIAlertAction actionWithTitle:@"Show Me" style:UIAlertActionStyleDefault handler:^(UIAlertAction* action) {
        if([[UIApplication sharedApplication] canOpenURL:url] == true) {
            [[UIApplication sharedApplication] openURL:url];
        }
        else {
            if(self.presentedViewController == nil) {
                [self errorLoadingAppStore:@"No internet connection detected" message:@""];
            }
            else {
                [self.presentedViewController dismissViewControllerAnimated:true completion:^(void) {
                    [self errorLoadingAppStore:@"No internet connection detected" message:@""];
                }];
            }
        }
    }];

    
    UIAlertAction* denied = [UIAlertAction actionWithTitle:@"Maybe Later" style:UIAlertActionStyleDestructive handler:^(UIAlertAction* action){
        
    }];
    
    [appStoreController addAction:confirmed];
    [appStoreController addAction:denied];
    
    
    if(self.presentedViewController == nil) {
        [self presentViewController:appStoreController animated:true completion:nil];
    }
    else {
        [self.presentedViewController dismissViewControllerAnimated:true completion:^(void) {
            [self presentViewController:appStoreController animated:true completion:nil];
        }];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSURL* urlPocket = [NSURL URLWithString:@"https://itunes.apple.com/us/app/pocket-diary/id1171062264?mt=8"];
    NSURL* urlTongueTwister = [NSURL URLWithString:@"https://itunes.apple.com/us/app/tongue-twister!/id1163954039?mt=8"];
    NSURL* urlVault = [NSURL URLWithString:@"https://itunes.apple.com/us/app/alpha-vault/id1182643346?mt=8"];
    
    switch (indexPath.row) {
        case 0:
            [self appStoreLink:@"Pocket Diary" message:@"Pocket Diary is a FREE application where you can write notes and protect your notes with a password lock of your choosing" URL:urlPocket];
            break;
        
        case 1:
            [self appStoreLink:@"Tongue Twister!" message:@"Tongue Twister! is an application that will aid you in your journey of learning French. It contains over 500 French phrases each read by a native speaker" URL:urlTongueTwister];
            break;
            
        case 2:
            [self appStoreLink:@"Alpha Vault" message:@"Alpha Vault is a security and utility application that will keep your data safe. You can store your photos, PDFs, Word documents, and you can even create and store your own passcodes that you use in everyday life. All this information is encrypted with the latest cryptographic algorithm AES-256. You can also protect your data with a password of your choosing." URL:urlVault];
            break;
        default:
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}

-(void)viewDidLoad {
    self.cells = [NSArray arrayWithObjects:@"                   Pocket Diary",@"                   Tongue Twister!", @"                   Alpha Vault", nil];
    
    //list of other apps
    UIImage* pocketDiary = [UIImage imageNamed:@"PocketDiary.png"];
    UIImage* tongueTwister = [UIImage imageNamed:@"TongueTwister.png"];
    UIImage* alphaVault = [UIImage imageNamed:@"Vault.png"];
    
    
    UIImageView* pocketImage = [[UIImageView alloc] initWithImage:pocketDiary];
    pocketImage.frame = CGRectMake(10.0f, 10.5f, 80, 80);
    pocketImage.contentMode = UIViewContentModeScaleAspectFit;
    
    
    UIImageView* tongueTwisterImage = [[UIImageView alloc] initWithImage:tongueTwister];
    tongueTwisterImage.frame = CGRectMake(7.0f, 106.5f, 80, 80);
    tongueTwisterImage.contentMode = UIViewContentModeScaleAspectFit;
    
    
    UIImageView* alphaVaultImage = [[UIImageView alloc] initWithImage:alphaVault];
    alphaVaultImage.frame = CGRectMake(7.0f, 208.5f, 80, 80);
    alphaVaultImage.contentMode = UIViewContentModeScaleAspectFit;
    
    //iPhone
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        self.tableView.rowHeight = 100.0f;
    }
    //iPad
    else {
        self.tableView.rowHeight = 140.0f;
    }
    
    
    [self.tableView addSubview:pocketImage];
    [self.tableView addSubview:tongueTwisterImage];
    [self.tableView addSubview:alphaVaultImage];
    
}


@end
