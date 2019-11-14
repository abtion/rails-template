# frozen_string_literal: true

class EnablePgCryptoExtension < ActiveRecord::Migration[6.0]
  def change
    enable_extension "pgcrypto"
  end
end
