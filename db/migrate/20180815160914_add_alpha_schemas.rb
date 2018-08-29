class AddAlphaSchemas < ActiveRecord::Migration[5.2]
  def change
    # create_table :users do |t|
    #   t.string :name, null: false
    #   t.string :email, null: false
    #   t.string :password_digest
    #   t.monetize :balance
    #   # TODO: image
    #
    #   t.timestamps
    # end

    create_table :disciplines do |t|
      t.string :name, null: false
      # TODO: image

      t.timestamps
    end

    create_table :participants do |t|
      t.string :name, null: false
      # TODO: image

      t.timestamps
    end

    create_join_table :disciplines, :participants do |t|
      # t.index [:discipline_id, :participant_id]
    end

    create_table :bookmakers do |t|
      t.string :name, null: false
      # TODO: image

      t.timestamps
    end

    create_table :events do |t|
      t.string :name, null: false
      t.date :period

      t.timestamps
    end

    create_table :bookmaker_balances do |t|
      t.monetize :balance
      t.belongs_to :user, index: true
      t.belongs_to :bookmaker, index: true
    end

    create_table :result_variants do |t|
      t.string :name
    end

    create_table :bet_types do |t|
      t.string :name
    end

    create_table :bets do |t|
      # Комментарий
      t.text :comment
      # Коэф-т
      t.float :coefficient, null: false
      # Профит
      # t.monetize :profit
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
  end
end