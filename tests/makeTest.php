<?php
namespace Test;

class ObjectTest extends \PHPUnit_Framework_TestCase
{
    public function testShowHelp()
    {
        $out = var_export(`./make help`, 1);
//        echo($out);
        $help = unpack('C', $out);
        var_dump($help);
//        $this->assertEquals($this->getHelp(), $out);
    }

    protected function getHelp()
    {
        return <<<HELP

------------------------------

Usage:  ./make [options]

    ./make help                                 This help
    ./make phar_name [directory] [index_name]   Create PHAR file

    phar_name - name of output phar file
    directory - (optional) source directory without separator, default ./src
    index_name - (optional) name of file that execute phar without separator, default ./src/index.php

------------------------------

HELP;
    }
}
