//
//  HBMNearbyBeaconTableViewController.m
//  Your Spot
//
//  Created by Matthew Cheetham on 08/03/2014.
//  Copyright (c) 2014 Matthew Cheetham. All rights reserved.
//

#import "HBMNearbyBeaconTableViewController.h"
#import "HBMBeaconController.h"
#import "HBMAvailableBeaconCell.h"
#import "HBMInputCell.h"
#import "HBMChild.h"

@interface HBMNearbyBeaconTableViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) HBMBeaconController *beaconController;
@property (nonatomic, strong) UIImage *childImage;
@property (nonatomic, strong) UITextField *childNameField;
@property (nonatomic, strong) CLBeacon *selectedBeacon;

@end

@implementation HBMNearbyBeaconTableViewController

- (void)dealloc
{
    [self.beaconController removeObserver:self forKeyPath:@"nearbyBeacons"];
}

- (id)init
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        
        self.title = @"Add Child";
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelAdding)];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(finishAdding)];
        
        self.beaconController = [HBMBeaconController sharedController];
        
        [self.beaconController addObserver:self forKeyPath:@"nearbyBeacons" options:kNilOptions context:nil];
        
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"standardCell"];
        [self.tableView registerClass:[HBMAvailableBeaconCell class] forCellReuseIdentifier:@"Cell"];
        [self.tableView registerClass:[HBMInputCell class] forCellReuseIdentifier:@"inputCell"];
        
    }
    return self;
}

- (void)cancelAdding
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)finishAdding
{
    [self.beaconController stopLookingForNearbyBeacons];
    
    HBMChild *newChild = [HBMChild new];
    
    CLBeaconMajorValue major = [self.selectedBeacon.major intValue];
    CLBeaconMinorValue minor = [self.selectedBeacon.minor intValue];
    
    newChild.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:self.selectedBeacon.proximityUUID major:major minor:minor identifier:self.childNameField.text];
    newChild.childName = self.childNameField.text;
    
    [self.beaconController addMonitoredChild:newChild];
    
    [self.beaconController startMonitoringChildren];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.beaconController startLookingForNearbyBeacons];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.beaconController stopLookingForNearbyBeacons];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 2;
            break;
        case 1:
            return self.beaconController.nearbyBeacons.count;
            break;
        default:
            return 0;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0){
        
        if(indexPath.row == 0){

            static NSString *inputCellIdentifier = @"inputCell";
            HBMInputCell *inputCell = [tableView dequeueReusableCellWithIdentifier:inputCellIdentifier forIndexPath:indexPath];
            
            inputCell.textLabel.text = @"Name";
            
            self.childNameField = inputCell.textField;

            return inputCell;

            
        } else if(indexPath.row == 1){
            
            static NSString *standardCellIdentifier = @"standardCell";
            UITableViewCell *standardCell = [tableView dequeueReusableCellWithIdentifier:standardCellIdentifier forIndexPath:indexPath];
            
            if(self.childImage){
                standardCell.textLabel.text = @"Change image";
            } else {
                standardCell.textLabel.text = @"Select Image";
            }
            standardCell.imageView.image = self.childImage;
            
            return standardCell;
            
        }
        
    
    } else if(indexPath.section == 1){
        
        static NSString *CellIdentifier = @"Cell";
        HBMAvailableBeaconCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        CLBeacon *nearbyBeacon = self.beaconController.nearbyBeacons[indexPath.row];
        cell.textLabel.text = [self.beaconController commonIdentifierForBeacon:nearbyBeacon];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@-%@-%@", nearbyBeacon.major, nearbyBeacon.minor, [self.beaconController stringFromProximity:nearbyBeacon.proximity]];
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        if([self.selectedBeacon.minor isEqualToNumber:nearbyBeacon.minor] && [self.selectedBeacon.major isEqualToNumber:nearbyBeacon.major]){
            
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            
        }
        
        return cell;
    }
    
    return nil;
    
}

#pragma mark - Beacon selection

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0){
        
        if(indexPath.row == 1){
            
         
            if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                [self pickPhotoFromLibrary];
                return;
            }
            
            UIActionSheet *imagePickerSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Photo", @"Library", nil];
            imagePickerSheet.tag = 3;
            [imagePickerSheet showInView:self.view];
            
            
        }
        
    }
    
    if(indexPath.section == 1){
        CLBeacon *selectedBeacon = self.beaconController.nearbyBeacons[indexPath.row];
        UIAlertView *selectedBeaconAlert = [[UIAlertView alloc] initWithTitle:@"Add child?" message:[NSString stringWithFormat:@"Do you want to start monitoring this child?\n\n%@-%@", selectedBeacon.major, selectedBeacon.minor] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Accept", nil];
        selectedBeaconAlert.tag = indexPath.row;
        [selectedBeaconAlert show];
        
        self.selectedBeacon = selectedBeacon;
    }
}

#pragma mark - Action sheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(actionSheet.tag == 3){
        
        if(buttonIndex == 0){
            
            [self takePhotoForImage];
            
        } else if (buttonIndex == 1){
            
            [self pickPhotoFromLibrary];
        }
        
    }
}

#pragma mark Image Picker

- (void)pickPhotoFromLibrary
{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void)takePhotoForImage
{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    self.childImage = [info objectForKey:UIImagePickerControllerEditedImage];
    [self dismissViewControllerAnimated:YES completion:^{
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
}

#pragma mark - Alert View options

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1){
        
        NSLog(@"Accepted");
        
    } else {
        
        NSLog(@"Rejected");
        self.selectedBeacon = nil;
        
    }
}

#pragma mark - Header view

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 1:
            return @"Finding available Beacons";
            break;
            
        default:
            return nil;
            break;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section == 1){
        UITableViewHeaderFooterView *headerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"Header"];
        headerView.contentView.backgroundColor = [UIColor colorWithRed:235.0f/255.0f green:235.0f/255.0f blue:235.0f/255.0f alpha:1.0];
        
        UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [headerView.contentView addSubview:indicatorView];
        
        indicatorView.frame = CGRectMake(230, 12, indicatorView.frame.size.width, indicatorView.frame.size.height);
        [indicatorView startAnimating];
        
        return headerView;
    }
    
    return nil;
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
}
@end
