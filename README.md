ruby-sendmail
=============

Sendmail AJAX contact form used on the RoR Footprint Media 2013 website.

This is a modification and implementation of the code provided in the 'Contact form in Rails 3' tutorial here:

http://matharvard.ca/posts/2011/aug/22/contact-form-in-rails-3/

I wanted a few different/extra things such as use of sendmail instead of SMTP, double-entry email fields, form loading, both client and server-side validation, error handling etc, all via AJAX but with the ability to fall back to use in a standard view if necessary. It can also be easily extended to provide DNS MX validation in addition to regex checking, save-to-database and email receipt to sender.

This form can be seen functioning here:

http://www.footprintmedia.net/

Code is clean and should be self-explanatory, hence the few # comments

jquery-rails and bootstrap-sass are in use on the site with modest CSS modifications. The captcha functionality is provided by simple_captcha:

https://github.com/galetahub/simple-captcha
