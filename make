#!/usr/bin/env php
<?php

if(empty($argv[1])) {
    echo "\n";
    display('Missing phar name.', 'red_label');
    display(help(), 'black_label');
    exit();
} else {
    $pharName = $argv[1];
}

function make() {
    
}

function install() {
    
}

function error() {

}

function display($message, $color = '') {
    echo message($message, $color) . PHP_EOL;
}

function help() {
    return <<<USAGE

------------------------------

Usage:  ./make [options]

    ./make help                                 This help
    ./make phar_name [directory] [index_name]   All optionsThis help

    phar_name - name of output phar file
    directory - (optional) source directory, default ./src
    index_name - (optional) name of file that execute phar, default ./src/index.php

------------------------------

USAGE;
}

/**
 * @param string $message
 * @param string $color
 * @return string
 */
function message($message, $color) {
    $colors = colors($color);
    return $colors['start'] . $message . $colors['end'];
}

/**
 * @param string $type
 * @return array
 */
function colors($type) {
    $list = [
        'start' => '',
        'end'   => "\033[0m"
    ];

    switch ($type) {
        case 'red':
            $list['start'] = "\033[0;31m";
            break;

        case 'green':
            $list['start'] = "\033[0;32m";
            break;

        case 'brown':
            $list['start'] = "\033[0;33m";
            break;

        case 'black':
            $list['start'] = "\033[0;30m";
            break;

        case 'blue':
            $list['start'] = "\033[0;34m";
            break;

        case 'magenta':
            $list['start'] = "\033[0;35m";
            break;

        case 'cyan':
            $list['start'] = "\033[0;36m";
            break;

        case 'white':
            $list['start'] = "\033[0;37m";
            break;

        case 'red_label':
            $list['start'] = "\033[41m";
            break;

        case 'brown_label':
            $list['start'] = "\033[43m";
            break;

        case 'black_label':
            $list['start'] = "\033[40m";
            break;

        case 'green_label':
            $list['start'] = "\033[42m";
            break;

        case 'blue_label':
            $list['start'] = "\033[44m";
            break;

        case 'magenta_label':
            $list['start'] = "\033[45m";
            break;

        case 'cyan_label':
            $list['start'] = "\033[46m";
            break;

        case 'white_label':
            $list['start'] = "\033[47m";
            break;

        default:
            $list['end'] = '';
            break;
    }

    return $list;
}
