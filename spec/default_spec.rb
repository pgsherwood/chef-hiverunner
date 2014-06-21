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


end