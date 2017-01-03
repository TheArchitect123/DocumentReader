//
//  PaintListController.m
//  PaperBrush
//
//  Created by Dan Gerchcovich on 29/12/16.
//  Copyright © 2016 Alpha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PaintListController.h"
#import "AppDelegate.h"
#import <CoreData/CoreData.h>

@interface PaintListController()

@property(nonatomic, strong, readwrite) AppDelegate* app;
@property(nonatomic, strong, readwrite) NSManagedObject* managed;
@property(nonatomic, strong, readwrite) NSArray* array;

@end

@implementation PaintListController

@synthesize app = _app;
@synthesize managed = _managed;
@synthesize array = _array;





-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //sorts through the array and organizes the files accoring to the first character in their name
    NSError* error = [NSError alloc];
    switch (section) {
        case 0: //A
            //read all files in the documents directory and write them to the SQLite store via CoreData
            //then simply read all core data files
            return self.array.count;
            break;
            
        default:
            break;
    }
    return 0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 26;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"A";
            break;
            
        case 1:
            return @"B";
            break;
            
        case 2:
            return @"C";
            break;
            
        case 3:
            return @"D";
            break;
            
        case 4:
            return @"E";
            break;
            
        case 5:
            return @"F";
            break;
            
        case 6:
            return @"G";
            break;
            
        case 7:
            return @"H";
            break;
            
        case 8:
            return @"I";
            break;
            
        case 9:
            return @"J";
            break;
            
        case 10:
            return @"K";
            break;
            
        case 11:
            return @"L";
            break;
            
        case 12:
            return @"M";
            break;
            
        case 13:
            return @"N";
            break;
            
        case 14:
            return @"O";
            break;
            
        case 15:
            return @"P";
            break;
            
        case 16:
            return @"Q";
            break;
            
        case 17:
            return @"R";
            break;
            
        case 18:
            return @"S";
            break;
            
        case 19:
            return @"T";
            break;
            
        case 20:
            return @"U";
            break;
            
            
        case 21:
            return @"V";
            break;
            
        case 22:
            return @"W";
            break;
            
        case 23:
            return @"X";
            break;
            
        case 24:
            return @"Y";
            break;
            
        case 25:
            return @"Z";
            break;
    
        default:
            return @"";
            break;
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* arrayTable = [tableView dequeueReusableCellWithIdentifier:@"CellData"];
    
    if(arrayTable == nil) {
        arrayTable = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CellData"];
    }
    
    NSManagedObject* arrayValue = self.array[indexPath.row];
    
    arrayTable.textLabel.text = [arrayValue valueForKeyPath:@"filePDF"];
    arrayTable.textLabel.textColor = [UIColor blackColor];
    
    
    return arrayTable;
}


-(void)viewDidLoad {
    
    
    self.array = [NSArray arrayWithObject:self.managed];
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

@end
