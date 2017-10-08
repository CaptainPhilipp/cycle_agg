# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_171_008_000_030) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'categories', force: :cascade do |t|
    t.string 'ru_title'
    t.string 'en_title'
    t.integer 'depth'
    t.string 'short_title'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'children_parents', force: :cascade do |t|
    t.string 'children_type', null: false
    t.bigint 'children_id', null: false
    t.string 'parent_type', null: false
    t.bigint 'parent_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[children_type children_id], name: 'index_children_parents_on_children_type_and_children_id'
    t.index %w[parent_type parent_id], name: 'index_children_parents_on_parent_type_and_parent_id'
  end

  create_table 'list_values', force: :cascade do |t|
    t.string 'ru_title'
    t.string 'en_title'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'parameters', force: :cascade do |t|
    t.string 'ru_title'
    t.string 'en_title'
    t.string 'values_type', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'present_type'
  end

  create_table 'pricelists', force: :cascade do |t|
    t.string 'attachment'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'publications', force: :cascade do |t|
    t.string 'title'
    t.text 'description'
    t.string 'company'
    t.string 'shop_title'
    t.string 'shop_url'
    t.integer 'offer_id'
    t.string 'url'
    t.string 'picture'
    t.boolean 'available'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'sport_groups', force: :cascade do |t|
    t.string 'ru_title'
    t.string 'en_title'
    t.string 'short_title'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end
end
