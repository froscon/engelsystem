<?php

return [

    // event
    'event_has_day0' => true,
    'privacy_email' => 'helfen@froscon.org',

    // features
    'enable_dect' => true,
    'enable_mobile_show' => false,
    'enable_full_name' => true,
    'display_full_name' => false,
    'enable_pronoun' => true,
    'required_user_fields' => [],
    'enable_planned_arrival' => false,
    'enable_force_active' => false,
    'enable_voucher' => false,
    'enable_force_food' => false,
    'enable_self_worklog' => true,
    'signup_requires_arrival' => false,
    'autoarrive' => false,
    'supporters_can_promote' => true,

    // certificates
    'driving_license_enabled' => false,
    'ifsg_enabled' => true,
    'ifsg_light_enabled' => false,

    // shifts
    'signup_post_fraction' => 1,

    // goodie
    'goodie_type' => 'none',
    'night_shifts.enabled' => false,

    // system
    'app_name' => 'Helferinnensystem',
    'default_locale' => 'de_DE',
    'theme' => 0,
    // password files are not supported here, still implemented in docker-compose.override.yml
    'email.driver' => 'smtp',
    'email.from.name' => 'Helferinnensystem',
    'email.from.address' => 'helfen@froscon.org',
    'email.host' => 'mail.froscon.org',
    'email.port' => 25,
    'email.tls' => false,
    'password_min_length' => 5,
    'footer_items' => [
        'faq.faq' => ['/faq', 'faq.view'],
        'general.email' => 'mailto:helfen@froscon.org',
    ],
    'disabled_user_view_columns' => ['freeloads'],
    'headers'                 => [
        'X-Content-Type-Options'  => 'nosniff',
        'X-Frame-Options'         => 'sameorigin',
        'Referrer-Policy'         => 'strict-origin-when-cross-origin',
        'Content-Security-Policy' =>
            'default-src \'self\' https://www.openstreetmap.org; '
            . ' style-src \'self\' \'unsafe-inline\'; '
            . 'img-src \'self\' data:;',
        'X-XSS-Protection'        => '1; mode=block',
        'Feature-Policy'          => 'autoplay \'none\'',
        //'Strict-Transport-Security' => 'max-age=7776000',
        //'Expect-CT' => 'max-age=7776000,enforce,report-uri="[uri]"',
    ],
];
