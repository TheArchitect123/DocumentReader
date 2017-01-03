//
//  TabMaster.m
//  PaperBrush
//
//  Created by Dan Gerchcovich on 29/12/16.
//  Copyright © 2016 Alpha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TabMaster.h"
#import "PaintListController.h"

@interface TabMaster()
    @property(nonatomic, strong, readwrite) UIBarButtonItem* edit;
    @property(nonatomic, strong, readwrite) UIBarButtonItem* add;
@end

@implementation TabMaster

@synthesize add = _add;
@synthesize edit = _edit;

-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    switch ([tabBarController selectedIndex]) {
        case 0:
            printf(":)");
            self.navigationItem.title = @"My PDFs";
            [self.navigationItem setLeftBarButtonItem:_edit];
            [self.navigationItem setRightBarButtonItem:_add];
            break;
            
        case 1:
            printf(":|");
            self.navigationItem.title = @"Check these apps out!";
            [self.navigationItem setLeftBarButtonItem:nil];
            [self.navigationItem setRightBarButtonItem:nil];
            
            break;
            
        case 2:
            printf(":>)");
            self.navigationItem.title = @"Settings";
            [self.navigationItem setLeftBarButtonItem:nil];
            [self.navigationItem setRightBarButtonItem:nil];
            break;
        default:
            break;
    }
}


-(void)viewDidLoad {
    //draw tab bar items
    self.tabBar.items[0].title = @"My PDFs";
    self.tabBar.items[0].image = [UIImage imageNamed:@"Paint.png"];
    
    self.tabBar.items[1].title = @"More";
    self.tabBar.items[1].image = [UIImage imageNamed:@"Wallet4040.png"];
    
    self.tabBar.items[2].title = @"Settings";
    self.tabBar.items[2].image = [UIImage imageNamed:@"SettingsOfficial.png"];
    
    self.navigationItem.title = @"My PDFs";
    
    self.delegate = self;
    
    UIBarButtonItem* editPDF = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editClick)];
    
    UIBarButtonItem* addPDF = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addPDFClick)];
    
    self.add = addPDF;
    self.edit = editPDF;
    
    [self.navigationItem setLeftBarButtonItem:_edit];
    [self.navigationItem setRightBarButtonItem:_add];

    
}

@end
