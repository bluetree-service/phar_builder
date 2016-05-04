#!/usr/bin/env php
<?php

namespace MakePhar;

$src = 'src';
$index = 'index.php';

if(empty($argv[1])) {
    echo "\n";
    display('Missing phar name.', 'red_label');
    display(help(), 'black_label');
    exit;
} else {
    $pharName = $argv[1];
}

if ($argv[1] === 'help') {
    echo "\n";
    display(help(), 'black_label');
    exit;
}

if (!empty($argv[2])) {
    $src = $argv[2];
}

if (!empty($argv[3])) {
    $index = $argv[3];
}

make($pharName, $src, $index);

/**
 * @param string $pharName
 * @param string $src
 * @param string $index
 */
function make($pharName, $src, $index) {
    $src .= DIRECTORY_SEPARATOR;

    echo "\n";
    display('Build process started.', 'green');
    display('Package name: ' . $pharName);
    display('Package name: ' . $src);
    display('Package name: ' . $index);

    if(!file_exists($src)) {
        display('Directory ' . $src . ' don\'t exists.', 'red_label');
        exit;
    }

    if(!file_exists($src . $index)) {
        display('Main script file ' . $src . $index . ' don\'t exists.', 'red_label');
        exit;
    }

    try {
        display('Create PHAR.', 'green');
        $phar = new Phar($pharName, 0, $pharName);
        $phar->startBuffering();
        $phar->buildFromDirectory($src);
        display('PHAR created.', 'green');

        $defaultStub = $phar->createDefaultStub($index);

        $stub = "#!/usr/bin/env php \n". $defaultStub;

        $phar->setStub($stub);
        $phar->stopBuffering();

        echo "\n";
        display('BUILD SUCCESS', 'green_label');
    } catch (Exception $e) {
        display(message('ERROR: ', 'red_label') . message($e->getMessage(), 'red'));
        display('BUILD FAIL', 'red_label');
        exit;
    }
}

function install() {
    
}

function currentTime() {
    
}

/**
 * @param string $message
 * @param string $color
 */
function display($message, $color = '') {
    echo message($message, $color) . PHP_EOL;
}

/**
 * @return string
 */
function help() {
    return <<<USAGE

------------------------------

Usage:  ./make [options]

    ./make help                                 This help
    ./make phar_name [directory] [index_name]   All optionsThis help

    phar_name - name of output phar file
    directory - (optional) source directory without separator, default ./src
    index_name - (optional) name of file that execute phar without separator, default ./src/index.php

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
