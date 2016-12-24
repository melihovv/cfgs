 <?php

 // Anything not Laravel - let's try to autoload something likely to exist
if (!defined('LARAVEL_START')) {
    return [
        'defaultIncludes' => [
            getcwd() . '/vendor/autoload.php',
            getcwd() . '/bootstrap/autoload.php',
        ],
    ];
}

/*
|--------------------------------------------------------------------------
| Laravel magic begins
|--------------------------------------------------------------------------
*/

// Register toRawSql() macro which will get nice, full sql of the query (with
// bound values)
\Illuminate\Database\Query\Builder::macro('toRawSql', function () {
    $bindings = array_map(function ($binding) {
        return is_int($binding)
            || is_float($binding) ? $binding : "'${binding}'";
    }, $this->getBindings());

    return vsprintf(str_replace('?', "%s", $this->toSql()), $bindings);
});

/*
|--------------------------------------------------------------------------
| Custom casters (presenters) and aliases registration for PsySH
|--------------------------------------------------------------------------
*/
_Tinker::alias('Carbon\Carbon');

class _Tinker
{
    static function castQuery($query)
    {
        if ($query instanceof \Illuminate\Database\Eloquent\Builder) {
            $query = $query->getQuery();
        }

        return [
            'sql'      => $query->toSql(),
            'bindings' => $query->getBindings(),
            'raw'      => $query->toRawSql(),
        ];
    }

    static function register($path)
    {
        foreach (glob($path.'/*.php') as $file) {
            $class = trim(app()->getNamespace(), '\\')
                . str_replace([app_path(), '/', '.php'], ['', '\\', ''], $file);
            self::alias($class);
        }
    }

    static function alias($class, $alias = null)
    {
        if (!class_exists($alias = $alias ?: class_basename($class))
            && class_exists($class)) {
            class_alias($class, $alias);
        }
    }
}

/*
|--------------------------------------------------------------------------
| Application HTTP requests helper
|--------------------------------------------------------------------------
*/
// Why extending TestCase here? Just because it's sooo easy and consistent
// across all L versions ;)
class _LocalRequest extends \TestCase
{
    function __construct()
    {
        $this->setUp();
    }

    function response()
    {
        return $this->response;
    }

    function __call($method, $params)
    {
        return call_user_func_array([$this, $method], $params);
    }
}

/*
|--------------------------------------------------------------------------
| Helper functions for common tasks
|--------------------------------------------------------------------------
*/

if (!function_exists('local')) {
    function local($uri = null)
    {
        return $uri ? (new _LocalRequest)->get($uri) : new _LocalRequest;
    }
}

if (!function_exists('guzzle')) {
    function guzzle($url = null)
    {
        return $url
            ? (new \GuzzleHttp\Client)->get($url)
            : new \GuzzleHttp\Client;
    }
}

if (!function_exists('http')) {
    function http($url = null)
    {
        return guzzle($url);
    }
}

if (!function_exists('www')) {
    function www($url = null)
    {
        return guzzle($url);
    }
}

if (!function_exists('now')) {
    function now($timezone = null)
    {
        return \Carbon\Carbon::now($timezone);
    }
}

return [
    // Sets the maximum number of entries the history can contain.
    // If set to zero, the history size is unlimited.
    'historySize' => 0,

    // If set to true, the history will not keep duplicate entries.
    // Newest entries override oldest.
    // This is the equivalent of the HISTCONTROL=erasedups setting in bash.
    'eraseDuplicates' => true,

    // PsySH uses a couple of UTF-8 characters in its own output. These can be
    // disabled, mostly to work around code page issues. Because Windows.
    //
    // Note that this does not disable Unicode output in general, it just makes
    // it so PsySH won't output any itself.
    'useUnicode' => false,

    'casters' => [
        'Illuminate\Database\Eloquent\Builder' => '_Tinker::castQuery',
        'Illuminate\Database\Query\Builder' => '_Tinker::castQuery',
    ],

    'defaultIncludes' => [
        getcwd() . '/.tinker',
    ],
];
