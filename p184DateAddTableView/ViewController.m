//
//  ViewController.m
//  p184DateAddTableView
//
//  Created by SDT-1 on 2014. 1. 6..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "ViewController.h"
#define CELL_ID @"CELL_ID"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *data;
}
@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation ViewController


- (BOOL)alertViewShouldEnableFirstOtherButton:(UIAlertView *)alertView
{
    NSString *inputStr = [alertView textFieldAtIndex:0].text;
    return [inputStr length]>2;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
    {
        UITextField *textField = [alertView textFieldAtIndex:0];
        [data addObject:textField.text];
        NSLog(@"%@",data);
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:([data count]-1) inSection:0];
        NSArray *row = [NSArray arrayWithObject:indexPath];
        [self.table insertRowsAtIndexPaths:row withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }
    
    
    
}

- (IBAction)toggleEdit:(id)sender
{
    self.table.editing =! self.table.editing;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row %3 == 0)
    {
        return UITableViewCellEditingStyleNone;
    }
    if(indexPath.row %3 ==1)
    {
        return UITableViewCellEditingStyleDelete;
    }
    else
        return UITableViewCellEditingStyleInsert;
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(UITableViewCellEditingStyleDelete == editingStyle)
    {
        [data removeObjectAtIndex:indexPath.row];
        NSArray *rowList = [NSArray arrayWithObjects:indexPath,nil];
        [tableView deleteRowsAtIndexPaths:rowList withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"추가" message:nil delegate:self cancelButtonTitle:@"취소" otherButtonTitles:@"확인", nil];        
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        [alert show];

    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL_ID" forIndexPath:indexPath];
    cell.textLabel.text = data[indexPath.row];
    return cell;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    data = [[NSMutableArray alloc]initWithObjects:@"Item0",@"Item1",@"Item2",@"Item3",@"Item4",@"Item5",@"Item6",@"Item7", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
