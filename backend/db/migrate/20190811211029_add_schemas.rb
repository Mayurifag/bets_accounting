# frozen_string_literal: true

class AddSchemas < ActiveRecord::Migration[6.0]
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
    add_index :disciplines, :name, using: :gin, opclass: {name: :gin_trgm_ops}

    create_table :participants do |t|
      t.string :name, null: false
      # TODO: image

      t.timestamps
    end
    add_index :participants, :name, using: :gin, opclass: {name: :gin_trgm_ops}

    create_table :bookmakers do |t|
      t.string :name, null: false
      # TODO: image

      t.timestamps
    end
    add_index :bookmakers, :name, using: :gin, opclass: {name: :gin_trgm_ops}

    create_table :events do |t|
      t.string :name, null: false
      t.date :period

      t.timestamps
    end
    add_index :events, :name, using: :gin, opclass: {name: :gin_trgm_ops}

    create_table :result_variants do |t|
      t.string :name, null: false

      t.timestamps
    end
    add_index :result_variants, :name, using: :gin, opclass: {name: :gin_trgm_ops}

    create_table :bet_types do |t|
      t.string :name, null: false

      t.timestamps
    end
    add_index :bet_types, :name, using: :gin, opclass: {name: :gin_trgm_ops}

    create_table :bets do |t|
      t.text :comment, comment: 'Комментарий'
      t.float :coefficient, null: false, comment: 'Коэффициент'
      t.decimal :profit, null: false, default: 0, comment: 'Профит'
      t.string :outcome, null: false, comment: 'Выбор'
      t.integer :wager, null: false, comment: 'Ставка'

      t.references :choice1, index: true, foreign_key: {to_table: :participants}
      t.references :choice2, index: true, foreign_key: {to_table: :participants}

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
