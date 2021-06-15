# frozen_string_literal: true

require "eol/version"
require "eol/api"
require "eol/config"
require "eol/response"
require "eol/client"
require "eol/resource"
require "eol/result_set"
require "eol/sanitizer"
require "eol/resources/aging_receivables_list"
require "eol/resources/receivables_list"
require "eol/resources/shared_sales_attributes"
require "eol/resources/base_entry_line"
require "eol/resources/bank_entry"
require "eol/resources/bank_entry_line"
require "eol/resources/bank_account"
require "eol/resources/contact"
require "eol/resources/sales_invoice"
require "eol/resources/sales_invoice_line"
require "eol/resources/printed_sales_invoice"
require "eol/resources/layout"
require "eol/resources/journal"
require "eol/resources/sales_item_prices"
require "eol/resources/item"
require "eol/resources/item_group"
require "eol/resources/account"
require "eol/resources/address"
require "eol/resources/gl_account"
require "eol/resources/sales_entry"
require "eol/resources/sales_entry_line"
require "eol/resources/sales_order"
require "eol/resources/sales_order_line"
require "eol/resources/project"
require "eol/resources/time_transaction"
require "eol/resources/purchase_entry"
require "eol/resources/purchase_entry_line"
require "eol/resources/costunit"
require "eol/resources/costcenter"
require "eol/resources/transaction"
require "eol/resources/transaction_line"
require "eol/resources/document"
require "eol/resources/document_attachment"
require "eol/resources/mailbox"
require "eol/resources/vat_code"
require "eol/resources/general_journal_entry"
require "eol/resources/general_journal_entry_line"
require "eol/resources/payment_condition"
require "eol/resources/goods_delivery"
require "eol/resources/goods_delivery_line"
require "eol/resources/division"
require "eol/resources/user"

module Eol
  extend Config

  def self.client(options = {})
    Eol::Client.new(options)
  end

  # Delegate to eol::Client
  def self.method_missing(method, *args, &block)
    super unless client.respond_to?(method)
    client.send(method, *args, &block)
  end

  # Delegate to eol::Client
  def self.respond_to?(method, include_all = false)
    client.respond_to?(method, include_all) || super
  end

  def self.info(msg)
    logger.info(msg)
  end

  def self.error(msg)
    logger.error(msg)
  end
end
