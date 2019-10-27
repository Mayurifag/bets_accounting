# frozen_string_literal: true

class AddAlphaSchemas < ActiveRecord::Migration[6.0]
  def change
    enable_extension :pg_trgm

    create_table :users do |t|
      # TODO: name, balance, avatar, etc.
      t.string :email, null: false
      t.string :password_digest

      t.timestamps
    end
    add_index :users, :email, unique: true

    create_table :disciplines do |t|
      t.string :name, null: false
      # TODO: image

      t.timestamps
    end
    add_index :disciplines, :name, using: :gin, opclass: { name: :gin_trgm_ops }

    create_table :participants do |t|
      t.string :name, null: false
      # TODO: image

      t.timestamps
    end
    add_index :participants, :name, using: :gin, opclass: { name: :gin_trgm_ops }

    # create_join_table :disciplines, :participants do |t|
    # t.index [:discipline_id, :participant_id]
    # end

    create_table :bookmakers do |t|
      t.string :name, null: false
      # TODO: image

      t.timestamps
    end
    add_index :bookmakers, :name, using: :gin, opclass: { name: :gin_trgm_ops }

    create_table :events do |t|
      t.string :name, null: false
      t.date :period

      t.timestamps
    end
    add_index :events, :name, using: :gin, opclass: { name: :gin_trgm_ops }

    # create_table :bookmaker_balances do |t|
    #   t.monetize :balance
    #   t.belongs_to :user, index: true
    #   t.belongs_to :bookmaker, index: true
    # end

    create_table :result_variants do |t|
      t.string :name, null: false

      t.timestamps
    end
    add_index :result_variants, :name, using: :gin, opclass: { name: :gin_trgm_ops }

    create_table :bet_types do |t|
      t.string :name, null: false

      t.timestamps
    end
    add_index :bet_types, :name, using: :gin, opclass: { name: :gin_trgm_ops }

    create_table :bets do |t|
      # Комментарий
      t.text :comment
      # Коэф-т
      t.float :coefficient, null: false
      # Профит
      # t.monetize :profit
      # TODO: default 0, null false, validations
      t.decimal :profit
      # Выбор
      t.string :outcome, null: false
      # Ставка
      # t.monetize :wager, null: false
      t.integer :wager, null: false

      t.references :choice1, index: true, foreign_key: { to_table: :participants }
      t.references :choice2, index: true, foreign_key: { to_table: :participants }

      # t.belongs_to :user, index: { unique: true }
      t.belongs_to :bookmaker, index: true
      t.belongs_to :discipline, index: true
      t.belongs_to :event, index: true
      t.belongs_to :result_variant, index: true
      t.belongs_to :bet_type, index: true

      t.timestamps
    end
    add_index :bets, :created_at
  end
end
