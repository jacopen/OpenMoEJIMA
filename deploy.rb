#!/bin/ruby

def configure
  $nadoka_dir='/usr/local/nadoka'
  $git_moejimabot_dir='/home/udcp/git/OpenMoEJIMA'
end

def main
  Dir::chdir($git_moejimabot_dir)
  result_exec_git=`git pull`
  unless /Already up-to-date/=~result_exec_git
    `cp -R #{$git_moejimabot_dir}/moejimabot.nb #{$nadoka_dir}/plugins/`
    nadoka_reboot
  end
end

def nadoka_reboot
  nadoka_kill
  nadoka_start
end

def nadoka_kill
  nadoka_pid = `ps aux | grep nadoka | egrep -v grep | awk \'\{print \$2\}\'`
  `kill -9 #{nadoka_pid}`
end

def nadoka_start
  Dir::chdir($nadoka_dir)
  Thread.new do 
    `ruby  #{$nadoka_dir}/nadoka.rb --r #{$nadoka_dir}/nadoka_config_main`
  end
end

configure
main

