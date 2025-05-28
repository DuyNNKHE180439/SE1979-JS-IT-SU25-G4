
(function ($) {
    "use strict";

    
    /*==================================================================
    [ Validate ]*/
    var input = $('.validate-input .input100');

    $('.validate-form').on('submit',function(){
        var check = true;

        for(var i=0; i<input.length; i++) {
            if(validate(input[i]) == false){
                showValidate(input[i]);
                check=false;
            }
        }

        return check;
    });


    $('.validate-form .input100').each(function(){
        $(this).focus(function(){
           hideValidate(this);
        });
    });

    function validate(input) {
        // Check if the input is the email/username field
        if ($(input).attr('name') == 'email') {
            var value = $(input).val().trim();
            // Email regex: validates standard email format
            var emailRegex = /^([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{1,5}|[0-9]{1,3})(\]?)$/;
            // Username regex: alphanumeric, underscores, hyphens, 3-30 characters
            var usernameRegex = /^[a-zA-Z0-9_-]{3,30}$/;
            
            // Return true if the value matches either email or username format
            if (value.match(emailRegex) || value.match(usernameRegex)) {
                return true;
            } else {
                return false;
            }
        } else {
            // For other inputs (e.g., password), check if not empty
            if ($(input).val().trim() == '') {
                return false;
            }
        }
        return true;
    }

    function showValidate(input) {
        var thisAlert = $(input).parent();

        $(thisAlert).addClass('alert-validate');
    }

    function hideValidate(input) {
        var thisAlert = $(input).parent();

        $(thisAlert).removeClass('alert-validate');
    }
    
    

})(jQuery);