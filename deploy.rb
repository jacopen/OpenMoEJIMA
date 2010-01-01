#!/bin/ruby

require 'yaml'
require 'pp'

def configure
  $config = YAML.load_file '/usr/local/nadoka/deploy.yaml'
end

def main
  if flg_nadoka_git_pull or nadoka_proccess_id==nil
    nadoka_reboot
  end
end

def flg_nadoka_git_pull
  Dir::chdir($config[:git_moejimabot_dir])
  result_exec_git=`git pull`
  if /Already up-to-date/=~result_exec_git
    `cp -R #{$config[:git_moejimabot_dir]}/moejimabot.nb #{$config[:nadoka_dir]}/plugins/`
    `cp -R #{$config[:git_moejimabot_dir]}/deploy.yaml #{$config[:nadoka_dir]}/`
    return false
  else
    `cp -R #{$config[:git_moejimabot_dir]}/moejimabot.nb #{$config[:nadoka_dir]}/plugins/`
    `cp -R #{$config[:git_moejimabot_dir]}/deploy.yaml #{$config[:nadoka_dir]}/`
    return true
  end
end

def nadoka_reboot
  nadoka_kill
  nadoka_start
end

def nadoka_proccess_id
  proccess_id = `ps aux | grep nadoka | egrep -v grep | awk \'\{print \$2\}\'`
  if proccess_id == ""
    return nil
  else
    return proccess_id.to_i
  end
end

def nadoka_kill
  if nadoka_proccess_id
    `kill -9 #{nadoka_proccess_id}`
  end
end

def nadoka_start
  Dir::chdir($config[:nadoka_dir])
  Thread.new do
    `ruby  #{$config[:nadoka_dir]}/nadoka.rb --r #{$config[:nadoka_dir]}/nadoka_config_main`
  end
end

configure
main

