require_relative '../spec_helper'
require_relative '../../../chef_helpers/libraries/encrypted_data_bag'
include Brightcove::Helpers::EncryptedDataBag

describe 'razor_server::default' do
  subject { ChefSpec::Runner.new.converge(described_recipe) }
  let(:chef_run) do
    ChefSpec::Runner.new(platform: 'centos', version: '5.9') do |node|
      node.set[:datacenter][:domain] = 'local'
    end.converge(described_recipe)
  end

  before(:each) do

    bind9_databag = {
      'local' => {
        'internal'    => "dummy",
        'rndc_secret' => "dummy",
        'external'    => "dummy"
      }
    }

    #stub_data_bag_item("highly_confidential", "bind9").and_return(bind9_databag)

    Chef::Recipe.any_instance.stub(:encrypted_data_bag_item).with("highly_confidential","bind9").and_return(bind9_databag)
  end

  it 'converges the node' do
    chef_run
  end
end
