#line 1 "utils/alert.xm"
#include "utils/alert.hpp"

void showAlert(NSString* title, NSString* body, NSString* buttonTitle) {
    UIAlertView *alert1 = [[UIAlertView alloc] initWithTitle:title
        message:body
        delegate:nil
        cancelButtonTitle:buttonTitle
        otherButtonTitles:nil];
    
    [alert1 show];
}
