class CreateTableOutboundMessages < ActiveRecord::Migration

  def self.up
    create_table :outbound_messages do |t|
      t.string   :message_id, :limit => 100, :null => false
      t.boolean  :relayed
      t.datetime :relayed_at
      t.string   :exchange_name, :limit => 100, :null => false
      t.text     :message
      t.datetime :created_at, :null => false
      t.datetime :updated_at, :null => false
      t.integer  :inbound_message_id
      t.string   :exchange_type, :limit => 10
      t.string   :app_id, :limit => 50
      t.string   :correlation_id, :limit => 100
      t.string   :group_id, :limit => 100, :null => false
      t.string   :http_method, :limit => 10
      t.string   :http_uri, :limit => 4096
      t.string   :reply_to, :limit => 50
      t.string   :reply_to_http_method, :limit => 10
      t.string   :reply_to_http_uri
      t.string   :txn_id, :limit => 100
      t.string   :routing_key, :limit => 100
      t.text     :context
      t.integer  :destination_response_status
      t.string   :relay_error
      t.integer  :retries, :default => 0
      t.text     :custom_headers
    end
    add_index :outbound_messages, :message_id, :unique=>true
    add_index :outbound_messages, :group_id, :unique=>false
    add_index :outbound_messages, :exchange_name, :unique=>false
  end

  def self.down
    drop_table :outbound_messages
  end


end