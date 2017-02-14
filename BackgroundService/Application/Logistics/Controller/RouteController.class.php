<?php
namespace Logistics\Controller;
use Think\Controller;

class RouteController extends Controller
{
    const ROUTINE_RUNNING = 1;
    const ROUTINE_STOPPED = 0;

    public function updateRoutes()
    {

        $is_running = S('is_updateRoutes_running');

        if ($is_running) {
            exit('routine is running');
        }

        S('is_updateRoutes_running', self::ROUTINE_RUNNING);

        $route = D('shipping_route');
        $res = $route->updateRouteList();

        S('is_updateRoutes_running', self::ROUTINE_STOPPED);

        if ($res === false) {
            exit("Failed to get way bill list. \n");
        }

        exit($res." items updated\n");
    }


    public function resetService()
    {
        if (S('is_updateRoutes_running', self::ROUTINE_STOPPED)) {
            exit("Service resetted successfully.\n");
        }

        exit("Failed to reset serivce.\n");
    }
}
