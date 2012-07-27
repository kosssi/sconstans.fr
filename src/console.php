<?php

use Symfony\Component\Console\Application;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\Console\Input\InputArgument;
use Symfony\Component\Console\Input\InputOption;

$console = new Application('sconstans.fr Application', '0.1');

$console
    ->register('twig:clear')
    ->setDefinition(array(
        // new InputOption('some-option', null, InputOption::VALUE_NONE, 'Some help'),
    ))
    ->setDescription('Clear twig cache file')
    ->setCode(function (InputInterface $input, OutputInterface $output) use ($app) {
        $app['twig']->clearCacheFiles();
    })
;

return $console;
