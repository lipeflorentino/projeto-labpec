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

ActiveRecord::Schema.define(version: 20170111130311) do

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable"
    t.index ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type"
  end

  create_table "compromissos", force: :cascade do |t|
    t.string   "titulo"
    t.text     "texto"
    t.date     "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "documentos", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "titulo"
    t.text     "descricao"
    t.boolean  "status"
    t.date     "data_defesa"
    t.boolean  "tese"
    t.boolean  "mestrado"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "arquivo"
    t.boolean  "accepted",    default: false
    t.boolean  "respondido",  default: false
  end

  create_table "eventos", force: :cascade do |t|
    t.string   "titulo"
    t.text     "descricao"
    t.datetime "data"
    t.text     "localizacao"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "posts", force: :cascade do |t|
    t.string   "titulo"
    t.text     "descricao"
    t.integer  "user_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "picture"
    t.text     "conteudo"
    t.integer  "vezes_visitado", default: 0
  end

  create_table "simposios", force: :cascade do |t|
    t.text     "conteudo"
    t.string   "picture"
    t.string   "titulo"
    t.text     "video"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "matricula"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "password_digest"
    t.string   "picture"
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.boolean  "adm"
    t.string   "new_email"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.boolean  "picture_accepted",  default: false
    t.boolean  "picture_declined",  default: false
  end

end
