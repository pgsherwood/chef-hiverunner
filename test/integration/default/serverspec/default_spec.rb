require 'spec_helper'

describe group('hiverunner') do
  it { should exist }
end

describe user('hiverunner') do
  it { should exist }
  it { should belong_to_group 'hiverunner'}
  it { should have_login_shell '/bin/false'}
end

hiverunner_dir = '/usr/local/hiverunner'

hiverunner_cmd = %Q{ source #{hiverunner_dir}/bin/activate; hiverunner --FREQ \
    --mysql-host mysql01.example.com \
    --mysql-database beeswax \
    --mysql-user hue \
    --mysql-password secret \
    --hive-host hive01.example.com \
    --memcache-host cache01.example.com }

hourly_cron = hiverunner_cmd.gsub("FREQ", "hourly")
daily_cron = hiverunner_cmd.gsub("FREQ", "daily")
weekly_cron = hiverunner_cmd.gsub("FREQ", "weekly")

describe cron do
  it { should have_entry("0 * * * * #{hourly_cron}").with_user('hiverunner') }
  it { should have_entry("20 0 * * * #{daily_cron}").with_user('hiverunner') }
  it { should have_entry("40 0 * * 0 #{weekly_cron}").with_user('hiverunner') }
end


