module Rubykassa  
  class Interface
    VALID_PARAMS = %w(MrchLogin OutSum InvId SignatureValue)
    PARAMS_CONFORMITY = {
      login:      "MrchLogin",
      total:      "OutSum",
      invoice_id: "InvId",
      signature:  "SignatureValue"
    }

    attr_accessor :invoice_id, :total, :params

    # Add later 'Desc', 'Email', 'IncCurrLabel', 'Culture'
    def initialize &block
      instance_eval &block if block_given?
    end

    def test_mode?
      Rubykassa.mode == :test
    end

    def base_url
      test_mode? ? "http://test.robokassa.ru/Index.aspx" : "https://merchant.roboxchange.com/Index.aspx"
    end

    def pay_url
      "#{base_url}?" + initial_options.map do |key, value| 
        "#{PARAMS_CONFORMITY[key.to_sym]}=#{value}" unless key =~ /^shp/
      end.compact!.join("&")
    end

    def initial_options
      {
        login: Rubykassa.login,
        total: @total,
        invoice_id: @invoice_id,
        signature: generate_initial_signature
      }.merge(Hash[@params.sort.map {|param_name| ["shp#{param_name[0]}", param_name[1]]}])
    end

    def generate_initial_signature
      custom_param_keys = @params.keys.select {|key| key =~ /^shp/}.sort
      custom_params = custom_param_keys.map {|key| "#{key}=#{params[key]}"}
      string = [Rubykassa.login, @total, @invoice_id, Rubykassa.first_password, custom_params].join(":")
      signature = Digest::MD5.hexdigest(string)
    end

    def generate_response_signature
      custom_param_keys = @params.keys.select {|key| key =~ /^shp/}.sort
      custom_params = custom_param_keys.map {|key| "#{key}=#{params[key]}"}
      string = [Rubykassa.login, @total, @invoice_id, Rubykassa.second_password, custom_params].join(":")
      signature = Digest::MD5.hexdigest(string)
    end    
  end
end