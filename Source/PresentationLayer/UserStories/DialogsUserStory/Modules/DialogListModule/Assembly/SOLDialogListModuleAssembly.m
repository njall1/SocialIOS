//
//  DialogListModuleAssembly.m
//  OutputFaceBookData
//
//  Created by Vitaliy Rusinov on 4/4/16.
//  Copyright © 2016 Oleh Petrunko. All rights reserved.
//

#import "SOLDialogListModuleAssembly.h"
#import "SOLDialogListTableViewController.h"

#import "SOLDialogListPresenter.h"
#import "SOLDialogListInteractor.h"
#import "SOLDialogListRouter.h"
#import "SOLDialogDataDisplayManager.h"

#import "SOLDialogCellObjectBuilder.h"

@interface SOLDialogListModuleAssembly ()
@property (weak, nonatomic) IBOutlet SOLDialogListTableViewController *viewController;
@end

@implementation SOLDialogListModuleAssembly

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self configureModuleForViewInput:_viewController];
}

- (void)configureModuleForViewInput:(SOLDialogListTableViewController *)viewInput {
    
    if(viewInput != nil) {
        
        [self configure:viewInput];
    }
}

- (void)configure:(SOLDialogListTableViewController *)viewController {
    
    SOLDialogListPresenter *presenter = [self presenter];
    presenter.view = viewController;
    
    viewController.output = presenter;
    viewController.dataDisplayManager = [self dataDisplayManager];
}

- (SOLDialogListPresenter *)presenter {
    
    SOLDialogListInteractor *interactor = [self interactor];
    SOLDialogListPresenter *presenter = [[SOLDialogListPresenter alloc] init];
    interactor.output = presenter;
    presenter.interactor = interactor;
    presenter.router = [self router];
    
    return presenter;
}

- (id<SOLDialogListInteractorInput>)interactor {

    return [[SOLDialogListInteractor alloc] init];
}

- (id<SOLDialogListRouterInput>)router {
    
    return [[SOLDialogListRouter alloc] init];
}

- (SOLDialogDataDisplayManager *)dataDisplayManager {
    
    SOLDialogDataDisplayManager *dataDisplayManager = [[SOLDialogDataDisplayManager alloc] init];
    dataDisplayManager.cellObjectBuilder = [self cellObjectBuilder];
    return dataDisplayManager;
}

- (id<SOLCellObjectBuilder>)cellObjectBuilder {
    
    return [[SOLDialogCellObjectBuilder alloc] init];
}

@end
