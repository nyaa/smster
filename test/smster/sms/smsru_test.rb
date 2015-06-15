require 'test_helper'

class Sms::SmsRuTest < ActiveSupport::TestCase
  def setup
    @provider = Sms::Smsru

    set_sms_params
    stub_send_request
    stub_cost_request
  end

  test 'create' do
    sms = @provider.create(text: @text, to: @to)

    assert_equal false, sms.new_record?
  end

  private

    def stub_send_request
      body = "100\n201523-1000007\nbalance=52.54"

      stub_request(:post, 'http://sms.ru/sms/send')
        .to_return(status: 200, body: body, headers: {})
    end

    def stub_cost_request
      body = "100\n0.69\n1"

      stub_request(:post, 'http://sms.ru/sms/cost')
        .to_return(status: 200, body: body, headers: {})
    end
end
