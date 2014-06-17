require_relative '../spec_helper'

describe 'razor_server::default' do
  subject { ChefSpec::Runner.new.converge(described_recipe) }
  let(:chef_run) do
    ChefSpec::Runner.new(platform: 'centos', version: '5.10') do |node|
      stub_command("which nginx").and_return('usr/bin/nginx')
    end.converge(described_recipe)
  end

  it 'converges the node' do
    chef_run
  end
end
