output="$(ssh -i /home/centos/mykeypair root@10.0.2.100 cat ${filename} 2> /dev/null)"

test1_passed=false
test2_passed=false
test3_passed=false

check_plugins_exists "hipchat" && test3_passed=true
check_not_empty system_config "token" <<< "$output" && test1_passed=true
check_not_empty system_config "room" <<< "$output" && test2_passed=true

if $test3_passed ; then
    echo "Plugin Installed: Passed"
else
    echo "Plugin Installed: Failed"
fi

if $test1_passed ; then
    echo "Token: Passed"
else
    echo "Check [ failed ]"
fi

if $test2_passed ; then
    echo "Room: Passed"
else
    echo "Check [ fail ]"
fi  