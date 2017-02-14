<?php 
class Getmac{ 
    var $result = array(); // 返回带有MAC地址的字串数组 
    var $macAddr;
    /*构造*/
    function __construct($osType){ 
        switch ( strtolower($osType) ){ 
            case "unix": break;
            case "solaris": break;
            case "aix": break;
            case "linux": {
                $this->for_linux_os();
            }break; 
            default: { 
                $this->for_windows_os(); 
            }break; 
        } 
        $temp_array = array(); 
        foreach($this->result as $value){
            if(preg_match("/[0-9a-f][0-9a-f][:-]"."[0-9a-f][0-9a-f][:-]"."[0-9a-f][0-9a-f][:-]"."[0-9a-f][0-9a-f][:-]"."[0-9a-f][0-9a-f][:-]"."[0-9a-f][0-9a-f]/i",$value, 
                $temp_array ) ){ 
                $this->macAddr = $temp_array[0]; 
                break; 
            } 
        } 
        unset($temp_array); 
        return $this->macAddr; 
    }
    /*linux系统中获取方法*/
    function for_linux_os(){ 
        @exec("ifconfig -a", $this->result); 
        return $this->result; 
    }
    /*win系统中的获取方法*/
    function for_windows_os(){ 
        @exec("ipconfig /all", $this->result); 
        if ( $this->result ) {
            return $this->result;
        } else { 
            $ipconfig = $_SERVER["WINDIR"]."\system32\ipconfig.exe";
            if(is_file($ipconfig)) {
                @exec($ipconfig." /all", $this->result);
            } else {
                @exec($_SERVER["WINDIR"]."\system\ipconfig.exe /all", $this->result);
                return $this->result; 
            }
        } 
    } 
} 

?>