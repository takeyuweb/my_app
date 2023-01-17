# == Schema Information
#
# Table name: my_api_keys
#
#  id            :uuid             not null, primary key
#  encrypted_key :string           not null
#  key_cipher    :string           not null
#  key_salt      :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class MyApiKey < ApplicationRecord
  concerning :DirtyKey do
    class Key
      include ActiveModel::Model
      include ActiveModel::Attributes
      include ActiveModel::Dirty

      attribute :data, :string
      attribute :salt, :string
      attribute :cipher, :string
      define_attribute_methods :data, :salt, :cipher

      validates :data, presence: true, on: :create
      validates :data, presence: true, on: :update, if: :changed?

      def descrypt(encrypted_data, salt, cipher)
        data = create_encrypter(salt, cipher).decrypt_and_verify(encrypted_data)
        self.data = data
        self.salt = salt
        self.cipher = cipher
      end

      def encrypt
        create_encrypter(self.salt, self.cipher).encrypt_and_sign(data)
      end

      def data=(new_data)
        return new_data if self.data == new_data
        data_will_change!
        self.salt = SecureRandom.hex
        self.cipher = ActiveSupport::MessageEncryptor.default_cipher
        super(new_data)
      end

      private

      def create_encrypter(salt, cipher)
        key_len = ActiveSupport::MessageEncryptor.key_len(cipher)
        secret = Rails.application.key_generator.generate_key(salt, key_len)
        ActiveSupport::MessageEncryptor.new(secret)
      end
    end

    included do
      after_initialize do
        if encrypted_key.present? && key_salt.present? && key_cipher.present?
          _key.descrypt(encrypted_key, key_salt, key_cipher)
        end
      end

      after_validation do
        _key.errors.full_messages.each { |message| errors.add :key, message } unless _key.valid?(validation_context)
      end

      before_save do
        if _key.changed?
          self.key_salt = _key.salt
          self.key_cipher = _key.cipher
          self.encrypted_key = _key.encrypt
        end
      end

      after_save { _key.changes_applied }
    end

    def key
      _key.data
    end

    def key=(new_key)
      _key.data = new_key
    end

    def reload(*)
      super.tap { _key.restore_attributes }
    end

    protected

    def _key
      @key ||= Key.new
    end
  end
end
