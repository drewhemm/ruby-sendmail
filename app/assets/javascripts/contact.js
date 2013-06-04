$(function () {
    // Loads the form in the modal template via AJAX
    $('#contact-inline').submit(function () {
        $('#contact').modal({
                remote: '/contact/form'
            });
        return false;
    });

    // Run a few actions when the modal window appears
    $('#contact').on('shown', function () {
        $('.modal-footer .text-error').html('');
        var email = $('#contact-inline input[name="email"]').val();
        if (email != '') {
            $('.modal-body input[name="email"]').val(email);
        }
        $('.form-wrapper, #contact form :input[type="submit"]').show();
    });

    // Destroy the modal when it closes to prevent 'caching' of stale captcha data
    $('#contact').on('hide', function () {
        $(this).removeData('modal');
    });

    // Handles form submission
    $('#contact form').submit(function () {
        $.ajax({
                type: 'POST',
                url: '/contact',
                beforeSend: function () {
                    $('.modal-footer .text-error').html('');
                    $('.modal-body .control-group').removeClass('error');
                    $('.modal-footer :input[type="submit"]').prop('disabled', 'true');
                },
                data: $(this).serialize(),
                dataType: 'json',
                error: function (response) {},
                success: function (response) {
                    $('.modal-footer :input[type="submit"]').removeProp('disabled');
                    // contact_controller.rb returns 1 for success, error will return 0 with additional JSON fields
                    if (response.success == 1) {
                        $('#contact form .message').text('Your message has been sent. We will be in touch shortly.');
                        $('#contact form :input[type="text"],textarea').val('');
                        $('.form-wrapper, #contact form :input[type="submit"]').hide();
                        $('.modal-header h3').text('Thank you!');
                    } else {
                        $('.modal-footer .text-error').html('<i class="icon-exclamation-sign"></i> ' + response.message);
                        $.each(response.invalid, function (key, value) {
                            console.log(key);
                            $('[name="' + key + '"]').parent('.control-group').addClass('error');
                        });
                    }
                }
            });
        return false;
    });
});
