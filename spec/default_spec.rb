require 'chefspec'  
require_relative 'spec_helper'

describe 'hiverunner::default' do  
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  it 'includes the apt recipe' do
    expect(chef_run).to include_recipe('apt')
  end  

  it 'install python package' do
    expect(chef_run).to install_package('python')
  end

  it 'install python-virtualenv package' do
    expect(chef_run).to install_package('python-virtualenv')
  end

  it 'install python-pip package' do
    expect(chef_run).to install_package('python-pip')
  end


end