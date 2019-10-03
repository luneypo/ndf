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

ActiveRecord::Schema.define(version: 20191003130821) do

  create_table "deplacements", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.date     "date"
    t.string   "title"
    t.integer  "vehicule_id"
    t.float    "tauxkm",      limit: 24
    t.integer  "nombrekm"
    t.float    "gasoil",      limit: 24
    t.float    "peage",       limit: 24
    t.float    "parking",     limit: 24
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.boolean  "valider"
    t.index ["user_id"], name: "index_deplacements_on_user_id", using: :btree
    t.index ["vehicule_id"], name: "index_deplacements_on_vehicule_id", using: :btree
  end

  create_table "divers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "info"
    t.float    "montant",        limit: 24
    t.integer  "deplacement_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["deplacement_id"], name: "index_divers_on_deplacement_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "name",                   default: "",    null: false
    t.string   "first_name",             default: "",    null: false
    t.boolean  "admin",                  default: false
    t.string   "login",                  default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "vehicules", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "immatriculation"
    t.float    "tauxkm",          limit: 24
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_foreign_key "deplacements", "users"
  add_foreign_key "deplacements", "vehicules"
  add_foreign_key "divers", "deplacements"
end
