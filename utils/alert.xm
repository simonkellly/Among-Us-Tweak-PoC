#include "utils/alert.hpp"

void showAlert(NSString* title, NSString* body, NSString* buttonTitle) {
    UIAlertView *alert1 = [[UIAlertView alloc] initWithTitle:title
        message:body
        delegate:nil
        cancelButtonTitle:buttonTitle
        otherButtonTitles:nil];
    //Now show that alert
    [alert1 show];
}