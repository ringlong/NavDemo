//
//  SearchViewController.m
//  NavDemo
//
//  Created by Ryan on 15/7/3.
//  Copyright (c) 2015年 BitAuto. All rights reserved.
//

#import "SearchViewController.h"
#import "RRToolkit.h"

@interface SearchViewController ()<UISearchBarDelegate, UISearchResultsUpdating>

@property (nonatomic, strong) NSArray *data;
@property (nonatomic, strong) NSMutableArray *filterData;
@property (nonatomic, strong) UISearchController *searchController;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"混蛋们";
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.searchBar.placeholder = @"搜索";
    self.searchController.dimsBackgroundDuringPresentation = YES;
    self.searchController.hidesNavigationBarDuringPresentation = YES;
    
    self.searchController.searchBar.height = 44.f;
    
    self.tableView.tableHeaderView = self.searchController.searchBar;
    self.tableView.allowsSelection = NO;
    self.tableView.tableFooterView = UIView.new;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (NSArray *)data {
    if (!_data) {
        _data = @[@1, @2, @3, @4, @5, @6, @7, @8, @9, @10, @1, @2, @3, @4, @5, @6, @7, @8, @9, @10];
    }
    return _data;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_searchController.active) {
        return self.filterData.count;
    }
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (_searchController.active) {
        cell.textLabel.text = [self.filterData[indexPath.row] stringValue];
    } else {
        cell.textLabel.text = [self.data[indexPath.row] stringValue];
    }
    return cell;
}

#pragma mark - UITableViewDataSource

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchString = [self.searchController.searchBar text];
    if (searchString && IsStringWithAnyText(searchString)) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.stringValue CONTAINS[c] %@", searchString];
        
        if (self.filterData) {
            [self.filterData removeAllObjects];
        }
        
        self.filterData = [NSMutableArray arrayWithArray:[self.data filteredArrayUsingPredicate:predicate]];
        
        [self.tableView reloadData];
    }
}

@end
