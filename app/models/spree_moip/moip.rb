# encoding: utf-8
require 'net/https'
require 'uri'
require 'builder'

module SpreeMoip
  class Moip

    CONFIG = YAML.load_file(File.join(::Rails.root, 'config', 'gateway.yml'))[::Rails.env]
    STATUS = { 1 => "authorized", 2 => "started", 3 => "printed", 4 => "completed", 5 => "canceled", 6 => "analysing"}
    BANDEIRAS = {'Visa' => 'Visa', 'Mastercard' => 'Mastercard'}

    class << self
      def authorize(attributes = {})
        logger.info "Authorizing transaction with Gateway"

        xml = request_body(attributes)
        parse_content perform_request(xml)
      end

      def charge_url(token)
        "#{CONFIG["uri"]}/Instrucao.do?token=#{token}"
      end

      protected
      def request_body(args)
        raise "Invalid data to do the request" unless valid_request_for?(args)

        xml = Builder::XmlMarkup.new.EnviarInstrucao do |e|
          e.InstrucaoUnica("TipoValidacao" => "Transparent") do |i|
            i.Razao args[:reason]
            i.IdProprio args[:id]
            i.URLRetorno CONFIG['uri_return']
            i.URLNotificacao CONFIG['uri_notification']
            i.Valores {|v| v.Valor(args[:value], :moeda => "BRL")}
            i.FormasPagamento { |p|
              p.FormaPagamento "CartaoCredito"
            }
          end
        end
      end

      def perform_request(body)
        uri = URI.parse("#{CONFIG["uri"]}/ws/alpha/EnviarInstrucao/Unica")

        req = Net::HTTP::Post.new(uri.path)
        req.body = body
        req.basic_auth CONFIG["token"], CONFIG["key"]

        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE

        http.request(req).body
      end

      def parse_content(raw_data)
        raise "Webservice can't be reached" if raw_data.nil?

        content = Hash.from_xml(raw_data)
        content = content["EnviarInstrucaoUnicaResponse"]["Resposta"]

        content["Status"] == "Sucesso" ? content : raise("Fail to authorize")
      end

      def valid_request_for?(args)
        args[:reason].present? && args[:id].present? && args[:value].present?
      end

      def logger
        Rails.logger
      end
    end
  end
end