//
//  FISShipDetailViewController.m
//  objc-Captain-Morgans-Relationships
//
//  Created by Zachary Drossman on 10/22/14.
//  Copyright (c) 2014 Zachary Drossman. All rights reserved.
//

#import "FISShipDetailViewController.h"
#import "FISPiratesDataStore.h"
#import "Engine.h"
#import "Pirate.h"

@interface FISShipDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *shipNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *pirateNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *propTypeLabel;
@property (nonatomic, strong) FISPiratesDataStore *store;

@end

@implementation FISShipDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.store = [FISPiratesDataStore sharedPiratesDataStore];
    
    [self.store fetchData];
    
    self.shipNameLabel.text = self.ship.name;
    self.pirateNameLabel.text = self.ship.pirate.name;
    self.propTypeLabel.text = self.ship.engine.type;
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
