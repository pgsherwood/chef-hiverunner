require 'chefspec'
require_relative 'spec_helper'

describe 'hiverunner::default' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  it 'includes the apt recipe' do
    expect(chef_run).to include_recipe('apt')
  end

  it 'installs python package' do
    expect(chef_run).to install_package('python')
  end

  it 'installs python-virtualenv package' do
    expect(chef_run).to install_package('python-virtualenv')
  end

  it 'installs python-pip package' do
    expect(chef_run).to install_package('python-pip')
  end

  it 'creates a hiverunner group' do
    expect(chef_run).to create_group('hiverunner').with(
      system: true
    )
  end

  it 'creates a hiverunner user' do
    expect(chef_run).to create_user('hiverunner').with(
      comment: 'Hiverunner User',
      system: true,
      gid: 'hiverunner',
      shell: '/bin/false'
    )
  end

  it 'creates a hiverunner hourly cron job' do
    expect(chef_run).to create_cron('hiverunner_hourly').with(
      user: 'hiverunner',
      minute: '0'
    )
  end

  it 'creates a hiverunner daily cron job' do
    expect(chef_run).to create_cron('hiverunner_daily').with(
      user: 'hiverunner',
      hour: '0',
      minute: '20'
    )
  end

  it 'creates a hiverunner weekly cron job' do
    expect(chef_run).to create_cron('hiverunner_weekly').with(
      user: 'hiverunner',
      weekday: '0',
      hour: '0',
      minute: '40'
    )
  end
end
