<?php

use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\RedirectResponse;
use Symfony\Component\HttpKernel\Exception\NotFoundHttpException;


/*
 * Photos
 */

function get_gravatar( $email, $s = 150, $d = 'mm', $r = 'g', $img = false, $atts = array() ) {
  $url = 'http://www.gravatar.com/avatar/';
  $url .= md5( strtolower( trim( $email ) ) );
  $url .= "?s=$s&d=$d&r=$r";
  if ( $img ) {
    $url = '<img src="' . $url . '"';
    foreach ( $atts as $key => $val )
      $url .= ' ' . $key . '="' . $val . '"';
    $url .= ' />';
  }
  return $url;
}


/*
 * Pages
 */

$pages = array(
  'accueil'      => array('nom' => 'Accueil',         'couleur' => 'orange'),
  'experiences'  => array('nom' => 'Expériences',     'couleur' => 'rouge'),
  'experiperso'  => array('nom' => 'Expéri. perso.',  'couleur' => 'vert'),
  'formations'   => array('nom' => 'Formations',      'couleur' => 'bleu'),
  'competences'  => array('nom' => 'Compétences',     'couleur' => 'violet'),
  'divers'       => array('nom' => 'Divers',          'couleur' => 'rose')
);

$app['pages'] = $pages;

foreach ($pages as $route => $params) {
  $app->get('/'.$route, function () use ($app, $route) {
    if ($route == 'accueil')
    {
      $app['photo'] = get_gravatar('kosssi@gmail.com');
    }
    return $app['twig']->render('pages/'.$route . '.twig');
  })->bind($route);
}

/*
 * Default
 */

$app->get('/', function () use ($app) {
  return $app->redirect('/accueil');
});

$app->error(function (\Exception $e, $code) use ($app) {
    if ($app['debug']) {
        return;
    }

    $page = 404 == $code ? '404.twig' : '500.twig';

    return new Response($app['twig']->render('errors/'.$page, array('code' => $code)), $code);
});